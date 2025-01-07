module 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability {
    struct ControlledCaps has key {
        id: 0x2::object::UID,
        admin_count: u8,
        own_capabilities: 0x2::bag::Bag,
    }

    struct AdminCap has drop, store {
        dummy_field: bool,
    }

    struct DrawCap has drop, store {
        dummy_field: bool,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    public fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : ControlledCaps {
        let v0 = ControlledCaps{
            id               : 0x2::object::new(arg1),
            admin_count      : 1,
            own_capabilities : 0x2::bag::new(arg1),
        };
        let v1 = &mut v0;
        let v2 = AdminCap{dummy_field: false};
        add_cap<AdminCap>(v1, arg0, v2);
        v0
    }

    fun add_cap<T0: drop + store>(arg0: &mut ControlledCaps, arg1: address, arg2: T0) {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::add<RoleKey<T0>, T0>(&mut arg0.own_capabilities, v0, arg2);
    }

    public fun add_capability<T0: drop + store>(arg0: &mut ControlledCaps, arg1: address, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<AdminCap>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(!has_cap<T0>(arg0, arg1), 3);
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<AdminCap>()) {
            arg0.admin_count = arg0.admin_count + 1;
        };
        add_cap<T0>(arg0, arg1, arg2);
    }

    fun get_cap<T0: drop + store>(arg0: &ControlledCaps, arg1: address) : &T0 {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::borrow<RoleKey<T0>, T0>(&arg0.own_capabilities, v0)
    }

    public fun has_cap<T0: store>(arg0: &ControlledCaps, arg1: address) : bool {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::contains_with_type<RoleKey<T0>, T0>(&arg0.own_capabilities, v0)
    }

    public fun new_admin_cap() : AdminCap {
        AdminCap{dummy_field: false}
    }

    public fun new_draw_cap() : DrawCap {
        DrawCap{dummy_field: false}
    }

    fun remove_cap<T0: drop + store>(arg0: &mut ControlledCaps, arg1: address) : T0 {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::remove<RoleKey<T0>, T0>(&mut arg0.own_capabilities, v0)
    }

    public fun remove_capability<T0: drop + store>(arg0: &mut ControlledCaps, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<AdminCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(has_cap<T0>(arg0, arg1), 2);
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<AdminCap>()) {
            assert!(arg0.admin_count > 1, 6);
            arg0.admin_count = arg0.admin_count - 1;
        };
        remove_cap<T0>(arg0, arg1);
    }

    public fun share(arg0: ControlledCaps) {
        0x2::transfer::share_object<ControlledCaps>(arg0);
    }

    // decompiled from Move bytecode v6
}

