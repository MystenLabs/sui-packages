module 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade {
    struct Protocol has key {
        id: 0x2::object::UID,
        version: u64,
        cap: 0x1::option::Option<0x2::package::UpgradeCap>,
    }

    struct UpgradeAdminCap has store, key {
        id: 0x2::object::UID,
        protocol: 0x2::object::ID,
    }

    struct Installed has copy, drop {
        protocol: 0x2::object::ID,
        upgrade_cap: 0x2::object::ID,
        admin_cap: 0x2::object::ID,
    }

    struct Upgraded has copy, drop {
        protocol: 0x2::object::ID,
        package: 0x2::object::ID,
        version: u64,
    }

    public(friend) fun assert_admin(arg0: &Protocol, arg1: &UpgradeAdminCap) {
        assert!(arg1.protocol == 0x2::object::id<Protocol>(arg0), 3);
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 0);
    }

    public(friend) fun assert_current(arg0: &Protocol, arg1: u64) {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 0);
        let v0 = 0x2::package::upgrade_package(0x1::option::borrow<0x2::package::UpgradeCap>(&arg0.cap));
        assert!(0x2::object::id_to_address(&v0) != @0x0, 5);
        assert!(arg0.version == arg1, 4);
    }

    public fun authorize(arg0: &mut Protocol, arg1: &UpgradeAdminCap, arg2: vector<u8>) : 0x2::package::UpgradeTicket {
        assert_admin(arg0, arg1);
        0x2::package::authorize_upgrade(0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.cap), 0x2::package::compatible_policy(), arg2)
    }

    public fun commit(arg0: &mut Protocol, arg1: 0x2::package::UpgradeReceipt) {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 0);
        0x2::package::commit_upgrade(0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.cap), arg1);
        arg0.version = arg0.version + 1;
        let v0 = Upgraded{
            protocol : 0x2::object::id<Protocol>(arg0),
            package  : 0x2::package::upgrade_package(0x1::option::borrow<0x2::package::UpgradeCap>(&arg0.cap)),
            version  : arg0.version,
        };
        0x2::event::emit<Upgraded>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Protocol{
            id      : 0x2::object::new(arg0),
            version : 1,
            cap     : 0x1::option::none<0x2::package::UpgradeCap>(),
        };
        0x2::transfer::share_object<Protocol>(v0);
    }

    public fun install(arg0: &mut Protocol, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x2::package::UpgradeCap>(&arg0.cap), 2);
        let v0 = 0x2::package::upgrade_package(&arg1);
        assert!(0x2::object::id_to_address(&v0) == 0x1::type_name::original_id<Protocol>(), 1);
        assert!(0x2::package::upgrade_policy(&arg1) == 0x2::package::compatible_policy(), 1);
        let v1 = UpgradeAdminCap{
            id       : 0x2::object::new(arg2),
            protocol : 0x2::object::id<Protocol>(arg0),
        };
        let v2 = Installed{
            protocol    : 0x2::object::id<Protocol>(arg0),
            upgrade_cap : 0x2::object::id<0x2::package::UpgradeCap>(&arg1),
            admin_cap   : 0x2::object::id<UpgradeAdminCap>(&v1),
        };
        0x2::event::emit<Installed>(v2);
        0x1::option::fill<0x2::package::UpgradeCap>(&mut arg0.cap, arg1);
        0x2::transfer::public_transfer<UpgradeAdminCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun package_id(arg0: &Protocol) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 0);
        0x2::package::upgrade_package(0x1::option::borrow<0x2::package::UpgradeCap>(&arg0.cap))
    }

    public fun version(arg0: &Protocol) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

