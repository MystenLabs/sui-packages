module 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::version {
    public(friend) fun assert_valid_package(arg0: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury) {
        0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::assert_valid_module_version<0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::witness::BucketV2CDP>(arg0, package_version());
    }

    public fun package_version() : u16 {
        1
    }

    // decompiled from Move bytecode v6
}

