module 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry {
    struct KeeperRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        pending_admin: address,
        keepers: vector<address>,
        paused: bool,
    }

    struct AdminTransferProposed has copy, drop {
        current_admin: address,
        pending_admin: address,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct RegistryPauseToggled has copy, drop {
        paused: bool,
    }

    struct KeeperAdded has copy, drop {
        keeper: address,
    }

    struct KeeperRemoved has copy, drop {
        keeper: address,
    }

    public fun accept_admin(arg0: &mut KeeperRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.pending_admin != @0x0, 5);
        assert!(0x2::tx_context::sender(arg1) == arg0.pending_admin, 4);
        arg0.admin = arg0.pending_admin;
        arg0.pending_admin = @0x0;
        let v0 = AdminTransferred{
            old_admin : arg0.admin,
            new_admin : arg0.admin,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public fun add_keeper(arg0: &mut KeeperRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(0x1::vector::length<address>(&arg0.keepers) < 100, 3);
        assert!(!0x1::vector::contains<address>(&arg0.keepers, &arg1), 6);
        0x1::vector::push_back<address>(&mut arg0.keepers, arg1);
        let v0 = KeeperAdded{keeper: arg1};
        0x2::event::emit<KeeperAdded>(v0);
    }

    public fun admin(arg0: &KeeperRegistry) : address {
        arg0.admin
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KeeperRegistry{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            pending_admin : @0x0,
            keepers       : vector[],
            paused        : false,
        };
        0x2::transfer::share_object<KeeperRegistry>(v0);
    }

    public fun is_allowed(arg0: &KeeperRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.keepers, &arg1)
    }

    public fun is_paused(arg0: &KeeperRegistry) : bool {
        arg0.paused
    }

    public fun pending_admin(arg0: &KeeperRegistry) : address {
        arg0.pending_admin
    }

    public fun propose_admin(arg0: &mut KeeperRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(arg1 != @0x0, 2);
        arg0.pending_admin = arg1;
        let v0 = AdminTransferProposed{
            current_admin : arg0.admin,
            pending_admin : arg1,
        };
        0x2::event::emit<AdminTransferProposed>(v0);
    }

    public fun remove_keeper(arg0: &mut KeeperRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.keepers, &arg1);
        assert!(v0, 7);
        0x1::vector::remove<address>(&mut arg0.keepers, v1);
        let v2 = KeeperRemoved{keeper: arg1};
        0x2::event::emit<KeeperRemoved>(v2);
    }

    public fun set_paused(arg0: &mut KeeperRegistry, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.paused = arg1;
        let v0 = RegistryPauseToggled{paused: arg1};
        0x2::event::emit<RegistryPauseToggled>(v0);
    }

    // decompiled from Move bytecode v6
}

