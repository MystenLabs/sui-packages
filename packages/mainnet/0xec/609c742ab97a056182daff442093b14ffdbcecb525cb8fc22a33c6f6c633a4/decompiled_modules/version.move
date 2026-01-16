module 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::version {
    public(friend) fun assert_version_compatibility(arg0: u8) {
        assert!(arg0 == 1, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::version_mismatch());
    }

    public(friend) fun is_compatible(arg0: u8) : bool {
        arg0 == 1
    }

    public fun package_version() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

