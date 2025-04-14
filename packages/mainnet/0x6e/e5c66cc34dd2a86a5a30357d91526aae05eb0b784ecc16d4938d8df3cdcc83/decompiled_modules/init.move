module 0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init {
    struct UpgradeEvent has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct ChangeAdminEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
            admin   : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::transfer::share_object<Version>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun change_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 4);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = ChangeAdminEvent{
            old_admin : 0x2::tx_context::sender(arg2),
            new_admin : arg1,
        };
        0x2::event::emit<ChangeAdminEvent>(v0);
    }

    public(friend) fun check_admincap(arg0: &Version, arg1: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 1);
    }

    public(friend) fun check_xbridge_version(arg0: &Version) {
        assert!(arg0.version == 1, 3);
    }

    entry fun migrate(arg0: &mut Version, arg1: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 1);
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

