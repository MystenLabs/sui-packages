module 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    entry fun admin_freeze(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameMasterCap, arg1: &mut Version) {
        arg1.version = 0;
    }

    public fun get_current_version() : u64 {
        1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    entry fun migrate(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameMasterCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 1002);
        arg1.version = arg2;
    }

    public(friend) fun validate_version(arg0: &Version) {
        assert!(get_current_version() == arg0.version, 1002);
    }

    // decompiled from Move bytecode v6
}

