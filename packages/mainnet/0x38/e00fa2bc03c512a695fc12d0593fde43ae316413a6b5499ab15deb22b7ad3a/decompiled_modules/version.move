module 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::version_mismatch());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::current_version::current_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::current_version::current_version()
    }

    public fun upgrade(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::current_version::current_version() + 1;
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

