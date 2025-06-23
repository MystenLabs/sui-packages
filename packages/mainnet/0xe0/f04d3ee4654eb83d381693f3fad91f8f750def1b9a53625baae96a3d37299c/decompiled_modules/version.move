module 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::version {
    struct Version has drop, store {
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new() : Version {
        Version{value: 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::current_version::current_version()}
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 150);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VersionCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::current_version::current_version()
    }

    public fun migrate_to_current_version(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

