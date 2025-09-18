module 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::version {
    public(friend) fun assert_version_compatibility(arg0: u8) {
        assert!(arg0 == 1, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::version_mismatch());
    }

    public(friend) fun is_compatible(arg0: u8) : bool {
        arg0 == 1
    }

    public fun package_version() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

