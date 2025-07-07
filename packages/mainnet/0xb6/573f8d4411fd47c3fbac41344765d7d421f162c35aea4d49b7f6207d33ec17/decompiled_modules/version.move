module 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun admin_freeze(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::GameMasterCap, arg1: &mut Version) {
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

    public fun migrate(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::GameMasterCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 1001);
        arg1.version = arg2;
    }

    public(friend) fun validate_version(arg0: &Version) {
        assert!(get_current_version() == arg0.version, 1001);
    }

    // decompiled from Move bytecode v6
}

