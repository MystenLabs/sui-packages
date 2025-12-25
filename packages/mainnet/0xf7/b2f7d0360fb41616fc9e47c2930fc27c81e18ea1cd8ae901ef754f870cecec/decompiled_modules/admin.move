module 0xf7b2f7d0360fb41616fc9e47c2930fc27c81e18ea1cd8ae901ef754f870cecec::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperRegistry has key {
        id: 0x2::object::UID,
        keepers: 0x2::table::Table<address, bool>,
    }

    struct KeeperAdded has copy, drop {
        keeper: address,
    }

    struct KeeperRemoved has copy, drop {
        keeper: address,
    }

    public entry fun add_keeper(arg0: &AdminCap, arg1: &mut KeeperRegistry, arg2: address) {
        assert!(!0x2::table::contains<address, bool>(&arg1.keepers, arg2), 2);
        0x2::table::add<address, bool>(&mut arg1.keepers, arg2, true);
        let v0 = KeeperAdded{keeper: arg2};
        0x2::event::emit<KeeperAdded>(v0);
    }

    public(friend) fun assert_keeper(arg0: &KeeperRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.keepers, 0x2::tx_context::sender(arg1)), 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = KeeperRegistry{
            id      : 0x2::object::new(arg0),
            keepers : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<KeeperRegistry>(v1);
    }

    public entry fun remove_keeper(arg0: &AdminCap, arg1: &mut KeeperRegistry, arg2: address) {
        assert!(0x2::table::contains<address, bool>(&arg1.keepers, arg2), 3);
        0x2::table::remove<address, bool>(&mut arg1.keepers, arg2);
        let v0 = KeeperRemoved{keeper: arg2};
        0x2::event::emit<KeeperRemoved>(v0);
    }

    // decompiled from Move bytecode v6
}

