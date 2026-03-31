module 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::version {
    struct VERSION has drop {
        dummy_field: bool,
    }

    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun version(arg0: &Version) : u64 {
        arg0.version
    }

    fun init(arg0: VERSION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VERSION>(arg0, arg1);
        let v0 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun package_version() : u64 {
        1
    }

    public(friend) fun validate_version(arg0: &Version) {
        assert!(arg0.version == 1, 0);
    }

    // decompiled from Move bytecode v6
}

