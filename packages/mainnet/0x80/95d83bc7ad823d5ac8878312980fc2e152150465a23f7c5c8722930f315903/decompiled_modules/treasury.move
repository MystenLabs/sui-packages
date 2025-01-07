module 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury {
    struct ControlledTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        admin_count: u8,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        own_capabilities: 0x2::bag::Bag,
    }

    struct AdminCap has drop, store {
        dummy_field: bool,
    }

    struct WhitelistCap has drop, store {
        dummy_field: bool,
    }

    struct WhitelistEntry has drop, store {
        dummy_field: bool,
    }

    struct BurnCap has drop, store {
        dummy_field: bool,
    }

    struct MintCap has drop, store {
        limit: u64,
        epoch: u64,
        left: u64,
    }

    struct MintEvent<phantom T0> has copy, drop {
        amount: u64,
        to: address,
    }

    struct BurnEvent<phantom T0> has copy, drop {
        amount: u64,
        from: address,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : ControlledTreasury<T0> {
        let v0 = ControlledTreasury<T0>{
            id               : 0x2::object::new(arg2),
            admin_count      : 1,
            treasury_cap     : arg0,
            own_capabilities : 0x2::bag::new(arg2),
        };
        let v1 = &mut v0;
        let v2 = AdminCap{dummy_field: false};
        add_cap<T0, AdminCap>(v1, arg1, v2);
        v0
    }

    public fun burn<T0>(arg0: &mut ControlledTreasury<T0>, arg1: 0x2::token::Token<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, BurnCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        let v0 = BurnEvent<T0>{
            amount : 0x2::token::value<T0>(&arg1),
            from   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BurnEvent<T0>>(v0);
        0x2::token::burn<T0>(&mut arg0.treasury_cap, arg1);
    }

    fun add_cap<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: T1) {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::add<RoleKey<T1>, T1>(&mut arg0.own_capabilities, v0, arg2);
    }

    public fun add_capability<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(!has_cap<T0, T1>(arg0, arg1), 3);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<AdminCap>()) {
            arg0.admin_count = arg0.admin_count + 1;
        };
        add_cap<T0, T1>(arg0, arg1, arg2);
    }

    public fun add_whitelist_entry<T0>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, WhitelistCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(!has_cap<T0, WhitelistCap>(arg0, arg1), 4);
        let v0 = WhitelistEntry{dummy_field: false};
        add_cap<T0, WhitelistEntry>(arg0, arg1, v0);
    }

    public fun deconstruct<T0>(arg0: ControlledTreasury<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::bag::Bag) {
        assert!(has_cap<T0, AdminCap>(&arg0, 0x2::tx_context::sender(arg1)), 0);
        let ControlledTreasury {
            id               : v0,
            admin_count      : _,
            treasury_cap     : v2,
            own_capabilities : v3,
        } = arg0;
        0x2::object::delete(v0);
        (v2, v3)
    }

    fun get_cap<T0, T1: drop + store>(arg0: &ControlledTreasury<T0>, arg1: address) : &T1 {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::borrow<RoleKey<T1>, T1>(&arg0.own_capabilities, v0)
    }

    fun get_cap_mut<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address) : &mut T1 {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::borrow_mut<RoleKey<T1>, T1>(&mut arg0.own_capabilities, v0)
    }

    public fun get_treasury_cap_immut<T0>(arg0: &ControlledTreasury<T0>) : &0x2::coin::TreasuryCap<T0> {
        &arg0.treasury_cap
    }

    public fun has_cap<T0, T1: store>(arg0: &ControlledTreasury<T0>, arg1: address) : bool {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::contains_with_type<RoleKey<T1>, T1>(&arg0.own_capabilities, v0)
    }

    public fun mint_and_transfer<T0>(arg0: &mut ControlledTreasury<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, MintCap>(arg0, 0x2::tx_context::sender(arg3)), 0);
        let v0 = get_cap_mut<T0, MintCap>(arg0, 0x2::tx_context::sender(arg3));
        let v1 = &mut v0.limit;
        let v2 = &mut v0.epoch;
        let v3 = &mut v0.left;
        if (0x2::tx_context::epoch(arg3) > *v2) {
            v3 = v1;
            *v2 = 0x2::tx_context::epoch(arg3);
        };
        assert!(arg1 <= *v3, 1);
        *v3 = *v3 - arg1;
        let v4 = MintEvent<T0>{
            amount : arg1,
            to     : arg2,
        };
        0x2::event::emit<MintEvent<T0>>(v4);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(&mut arg0.treasury_cap, 0x2::token::transfer<T0>(0x2::token::mint<T0>(&mut arg0.treasury_cap, arg1, arg3), arg2, arg3), arg3);
    }

    public fun new_admin_cap() : AdminCap {
        AdminCap{dummy_field: false}
    }

    public fun new_burn_cap() : BurnCap {
        BurnCap{dummy_field: false}
    }

    public fun new_mint_cap(arg0: u64, arg1: &0x2::tx_context::TxContext) : MintCap {
        MintCap{
            limit : arg0,
            epoch : 0x2::tx_context::epoch(arg1),
            left  : arg0,
        }
    }

    public fun new_whitelist_cap() : WhitelistCap {
        WhitelistCap{dummy_field: false}
    }

    fun remove_cap<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address) : T1 {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::remove<RoleKey<T1>, T1>(&mut arg0.own_capabilities, v0)
    }

    public fun remove_capability<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(has_cap<T0, T1>(arg0, arg1), 2);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<AdminCap>()) {
            assert!(arg0.admin_count > 1, 6);
            arg0.admin_count = arg0.admin_count - 1;
        };
        remove_cap<T0, T1>(arg0, arg1);
    }

    public fun remove_whitelist_entry<T0>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, WhitelistCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(has_cap<T0, WhitelistEntry>(arg0, arg1), 5);
        remove_cap<T0, WhitelistEntry>(arg0, arg1);
    }

    public fun share<T0>(arg0: ControlledTreasury<T0>) {
        0x2::transfer::share_object<ControlledTreasury<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

