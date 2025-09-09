module 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::version {
    public(friend) fun assert_version_compatibility(arg0: u8) {
        assert!(arg0 == 1, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::version_mismatch());
    }

    public(friend) fun is_compatible(arg0: u8) : bool {
        arg0 == 1
    }

    public fun package_version() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

