module 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::version {
    public(friend) fun assert_valid_package(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury) {
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::assert_valid_module_version<0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::witness::BucketV2CDP>(arg0, package_version());
    }

    public fun package_version() : u16 {
        1
    }

    // decompiled from Move bytecode v6
}

