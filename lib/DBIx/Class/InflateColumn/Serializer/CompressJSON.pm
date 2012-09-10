#
# This file is part of DBIx-Class-InflateColumn-Serializer-CompressJSON
#
# This software is copyright (c) 2012 by Weborama.  No
# license is granted to other entities.
#
package DBIx::Class::InflateColumn::Serializer::CompressJSON;
{
  $DBIx::Class::InflateColumn::Serializer::CompressJSON::VERSION = '0.001';
}

# ABSTRACT: DBIx::Class::InflateColumn::Serializer::CompressJSON - JSON compressed Inflator

use strict;
use warnings;
use JSON qw//;
use Compress::Zlib qw/compress uncompress/;
use Carp;

sub get_freezer{
  my ($class, $column, $info, $args) = @_;

  if (defined $info->{'size'}){
      my $size = $info->{'size'};
      return sub {
        my $b = Compress::Zlib::compress(JSON::to_json(shift));
        croak "could not get a compressed binary" unless ( defined $b);
        croak "serialization too big" if (length($b) > $size);
        return $b;
      };
  } else {
      return sub {
        my $b = Compress::Zlib::compress(JSON::to_json(shift));
        croak "could not get a compressed binary" unless ( defined $b);
        return $b;
      };
  }
}

sub get_unfreezer {
  return sub {
    my $j = Compress::Zlib::uncompressed(shift);
    croak "could not get an uncompressed scalar" unless defined( $j );
    return JSON::from_json($j);
  };
}


1;


=pod

=head1 NAME

DBIx::Class::InflateColumn::Serializer::CompressJSON - DBIx::Class::InflateColumn::Serializer::CompressJSON - JSON compressed Inflator

=head1 VERSION

version 0.001

=head1 NAME

DBIx::Class::InflateColumn::Serializer::JSON - JSON Inflator
=head1 SYNOPSIS

  package MySchema::Table;
    use base 'DBIx::Class';

    __PACKAGE__->load_components('InflateColumn::Serializer', 'Core');
    __PACKAGE__->add_columns(
        'data_column' => {
            'data_type' => 'VARCHAR',
            'size'      => 255,
            'serializer_class'   => 'JSON'
        }
     );

     Then in your code...

     my $struct = { 'I' => { 'am' => 'a struct' };
     $obj->data_column($struct);
     $obj->update;

     And you can recover your data structure with:

     my $obj = ...->find(...);
     my $struct = $obj->data_column;

The data structures you assign to "data_column" will be saved in the database in JSON format.

=over 4

=item get_freezer

Called by DBIx::Class::InflateColumn::Serializer to get the routine that serializes
the data passed to it. Returns a coderef.

=item get_unfreezer

Called by DBIx::Class::InflateColumn::Serializer to get the routine that deserializes
the data stored in the column. Returns a coderef.

=back

=head1 AUTHOR

Baptiste FOSSÉ <baptiste@weborama.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Weborama.  No
license is granted to other entities.

=cut


__END__



