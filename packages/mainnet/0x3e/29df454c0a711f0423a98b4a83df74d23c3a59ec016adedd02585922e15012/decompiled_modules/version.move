module 0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::version {
    public(friend) fun assert_valid_package(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury) {
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::assert_valid_module_version<0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::witness::BucketV2Saving>(arg0, package_version());
    }

    public fun package_version() : u16 {
        1
    }

    // decompiled from Move bytecode v6
}

