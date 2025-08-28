module 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::version {
    public(friend) fun assert_valid_package(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury) {
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::assert_valid_module_version<0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::witness::BucketV2Saving>(arg0, package_version());
    }

    public fun package_version() : u16 {
        1
    }

    // decompiled from Move bytecode v6
}

