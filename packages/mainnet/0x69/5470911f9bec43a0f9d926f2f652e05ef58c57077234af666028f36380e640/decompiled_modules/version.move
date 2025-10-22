module 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::version {
    public(friend) fun assert_valid_package(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury) {
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::assert_valid_module_version<0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>(arg0, package_version());
    }

    public fun package_version() : u16 {
        1
    }

    // decompiled from Move bytecode v6
}

