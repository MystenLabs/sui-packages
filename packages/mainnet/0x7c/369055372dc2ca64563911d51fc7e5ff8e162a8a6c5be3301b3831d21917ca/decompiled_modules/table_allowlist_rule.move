module 0x7c369055372dc2ca64563911d51fc7e5ff8e162a8a6c5be3301b3831d21917ca::table_allowlist_rule {
    struct TableAllowlistRule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        _dummy: bool,
    }

    struct AllowlistRegistry has key {
        id: 0x2::object::UID,
        allowed: 0x2::table::Table<0x2::object::ID, bool>,
        version: u64,
    }

    struct AllowlistAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = TableAllowlistRule{dummy_field: false};
        let v1 = Config{_dummy: true};
        0x2::transfer_policy::add_rule<T0, TableAllowlistRule, Config>(v0, arg0, arg1, v1);
    }

    public fun remove<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2::transfer_policy::remove_rule<T0, TableAllowlistRule, Config>(arg0, arg1);
    }

    public fun add_batch_to_allowlist(arg0: &AllowlistAdminCap, arg1: &mut AllowlistRegistry, arg2: vector<0x2::object::ID>) {
        check_version(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            if (!0x2::table::contains<0x2::object::ID, bool>(&arg1.allowed, v1)) {
                0x2::table::add<0x2::object::ID, bool>(&mut arg1.allowed, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    fun check_version(arg0: &AllowlistRegistry) {
        assert!(arg0.version == 1, 1002);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AllowlistRegistry{
            id      : 0x2::object::new(arg0),
            allowed : 0x2::table::new<0x2::object::ID, bool>(arg0),
            version : 1,
        };
        let v1 = AllowlistAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AllowlistRegistry>(v0);
        0x2::transfer::transfer<AllowlistAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_allowed(arg0: &AllowlistRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.allowed, arg1)
    }

    public fun remove_batch_from_allowlist(arg0: &AllowlistAdminCap, arg1: &mut AllowlistRegistry, arg2: vector<0x2::object::ID>) {
        check_version(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            if (0x2::table::contains<0x2::object::ID, bool>(&arg1.allowed, v1)) {
                0x2::table::remove<0x2::object::ID, bool>(&mut arg1.allowed, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun resolve<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &AllowlistRegistry) {
        check_version(arg2);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg2.allowed, 0x2::transfer_policy::item<T0>(arg1)), 1001);
        let v0 = TableAllowlistRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, TableAllowlistRule>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

