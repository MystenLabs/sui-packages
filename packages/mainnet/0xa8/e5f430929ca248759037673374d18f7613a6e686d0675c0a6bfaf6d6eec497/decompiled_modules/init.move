module 0xa8e5f430929ca248759037673374d18f7613a6e686d0675c0a6bfaf6d6eec497::init {
    struct UpgradeEvent has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
            admin   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public entry fun change_admin(arg0: &mut Version, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    public(friend) fun check_dexrouter_version(arg0: &Version) {
        assert!(arg0.version == 1, 3);
    }

    public entry fun upgrade(arg0: &mut Version, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        let v0 = arg0.version;
        assert!(v0 < 1, 2);
        arg0.version = 1;
        let v1 = UpgradeEvent{
            old_version : v0,
            new_version : 1,
        };
        0x2::event::emit<UpgradeEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

