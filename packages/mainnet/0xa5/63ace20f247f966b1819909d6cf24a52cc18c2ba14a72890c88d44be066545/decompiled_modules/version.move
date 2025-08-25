module 0xa563ace20f247f966b1819909d6cf24a52cc18c2ba14a72890c88d44be066545::version {
    public(friend) fun assert_valid_package(arg0: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury) {
        0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::assert_valid_module_version<0xa563ace20f247f966b1819909d6cf24a52cc18c2ba14a72890c88d44be066545::witness::BucketV2PSM>(arg0, package_version());
    }

    public fun package_version() : u16 {
        1
    }

    // decompiled from Move bytecode v6
}

