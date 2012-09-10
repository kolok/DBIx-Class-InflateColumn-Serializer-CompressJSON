#
# This file is part of DBIx-Class-InflateColumn-Serializer-CompressJSON
#
# This software is copyright (c) 2012 by Weborama.  No
# license is granted to other entities.
#
use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'DBIx::Class::InflateColumn::Serializer::CompressJSON',
    AUTHOR              => q{Baptiste FOSSÉ <baptiste@weborama.com>},
    VERSION_FROM        => 'lib/DBIx/Class/InflateColumn/Serializer/CompressJSON.pm',
    ABSTRACT_FROM       => 'lib/DBIx/Class/InflateColumn/Serializer/CompressJSON.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'DBIx-Class-InflateColumn-Serializer-CompressJSON-*' },
);
