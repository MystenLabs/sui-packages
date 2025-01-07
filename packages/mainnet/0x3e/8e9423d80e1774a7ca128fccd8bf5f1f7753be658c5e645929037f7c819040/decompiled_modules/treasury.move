module 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::treasury {
    struct ControlledTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        admin_count: u8,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        deny_cap: 0x2::coin::DenyCapV2<T0>,
        roles: 0x2::bag::Bag,
    }

    struct AdminCap has drop, store {
        dummy_field: bool,
    }

    struct MinterCap has drop, store {
        limit: u64,
        epoch: u64,
        left: u64,
    }

    struct PauserCap has drop, store {
        dummy_field: bool,
    }

    struct MintEvent<phantom T0> has copy, drop {
        amount: u64,
        to: address,
        tx_id: vector<u8>,
        index: u32,
    }

    struct BurnEvent<phantom T0> has copy, drop {
        amount: u64,
        from: address,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::DenyCapV2<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : ControlledTreasury<T0> {
        let v0 = ControlledTreasury<T0>{
            id           : 0x2::object::new(arg3),
            admin_count  : 1,
            treasury_cap : arg0,
            deny_cap     : arg1,
            roles        : 0x2::bag::new(arg3),
        };
        let v1 = &mut v0;
        let v2 = AdminCap{dummy_field: false};
        add_cap<T0, AdminCap>(v1, arg2, v2);
        v0
    }

    fun add_cap<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: T1) {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::add<RoleKey<T1>, T1>(&mut arg0.roles, v0, arg2);
    }

    public fun add_capability<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(!has_cap<T0, T1>(arg0, arg1), 2);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<AdminCap>()) {
            arg0.admin_count = arg0.admin_count + 1;
        };
        add_cap<T0, T1>(arg0, arg1, arg2);
    }

    public fun deconstruct<T0>(arg0: ControlledTreasury<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::DenyCapV2<T0>, 0x2::bag::Bag) {
        assert!(has_cap<T0, AdminCap>(&arg0, 0x2::tx_context::sender(arg1)), 0);
        let ControlledTreasury {
            id           : v0,
            admin_count  : _,
            treasury_cap : v2,
            deny_cap     : v3,
            roles        : v4,
        } = arg0;
        0x2::object::delete(v0);
        (v2, v3, v4)
    }

    public fun disable_global_pause<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::pk_util::validate_pks(&arg2);
        assert!(0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::multisig::is_sender_multisig(arg2, arg3, arg4, arg5), 5);
        assert!(has_cap<T0, PauserCap>(arg0, 0x2::tx_context::sender(arg5)), 0);
        0x2::coin::deny_list_v2_disable_global_pause<T0>(arg1, &mut arg0.deny_cap, arg5);
    }

    public fun enable_global_pause<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::pk_util::validate_pks(&arg2);
        assert!(0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::multisig::is_sender_multisig(arg2, arg3, arg4, arg5), 5);
        assert!(has_cap<T0, PauserCap>(arg0, 0x2::tx_context::sender(arg5)), 0);
        0x2::coin::deny_list_v2_enable_global_pause<T0>(arg1, &mut arg0.deny_cap, arg5);
    }

    fun get_cap<T0, T1: drop + store>(arg0: &ControlledTreasury<T0>, arg1: address) : &T1 {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::borrow<RoleKey<T1>, T1>(&arg0.roles, v0)
    }

    fun get_cap_mut<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address) : &mut T1 {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::borrow_mut<RoleKey<T1>, T1>(&mut arg0.roles, v0)
    }

    public fun has_cap<T0, T1: store>(arg0: &ControlledTreasury<T0>, arg1: address) : bool {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::contains<RoleKey<T1>>(&arg0.roles, v0)
    }

    public fun is_global_pause_enabled<T0>(arg0: &0x2::deny_list::DenyList) : bool {
        0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<T0>(arg0)
    }

    public fun list_roles<T0>(arg0: &ControlledTreasury<T0>, arg1: address) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        if (has_cap<T0, AdminCap>(arg0, arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"AdminCap"));
        };
        if (has_cap<T0, MinterCap>(arg0, arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"MinterCap"));
        };
        if (has_cap<T0, PauserCap>(arg0, arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"PauserCap"));
        };
        v0
    }

    public fun mint_and_transfer<T0>(arg0: &mut ControlledTreasury<T0>, arg1: u64, arg2: address, arg3: &0x2::deny_list::DenyList, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: u16, arg7: vector<u8>, arg8: u32, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 6);
        0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::pk_util::validate_pks(&arg4);
        assert!(0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::multisig::is_sender_multisig(arg4, arg5, arg6, arg9), 5);
        assert!(has_cap<T0, MinterCap>(arg0, 0x2::tx_context::sender(arg9)), 0);
        assert!(!is_global_pause_enabled<T0>(arg3), 4);
        let v0 = get_cap_mut<T0, MinterCap>(arg0, 0x2::tx_context::sender(arg9));
        let v1 = &mut v0.limit;
        let v2 = &mut v0.epoch;
        let v3 = &mut v0.left;
        if (0x2::tx_context::epoch(arg9) > *v2) {
            *v3 = *v1;
            *v2 = 0x2::tx_context::epoch(arg9);
        };
        assert!(arg1 <= *v3, 1);
        *v3 = *v3 - arg1;
        let v4 = MintEvent<T0>{
            amount : arg1,
            to     : arg2,
            tx_id  : arg7,
            index  : arg8,
        };
        0x2::event::emit<MintEvent<T0>>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury_cap, arg1, arg9), arg2);
    }

    public fun new_admin_cap() : AdminCap {
        AdminCap{dummy_field: false}
    }

    public fun new_minter_cap(arg0: u64, arg1: &0x2::tx_context::TxContext) : MinterCap {
        assert!(arg0 > 0, 6);
        MinterCap{
            limit : arg0,
            epoch : 0x2::tx_context::epoch(arg1),
            left  : arg0,
        }
    }

    public fun new_pauser_cap() : PauserCap {
        PauserCap{dummy_field: false}
    }

    fun remove_cap<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address) : T1 {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::remove<RoleKey<T1>, T1>(&mut arg0.roles, v0)
    }

    public fun remove_capability<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(has_cap<T0, T1>(arg0, arg1), 0);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<AdminCap>()) {
            assert!(arg0.admin_count > 1, 3);
            arg0.admin_count = arg0.admin_count - 1;
        };
        remove_cap<T0, T1>(arg0, arg1);
    }

    public fun share<T0>(arg0: ControlledTreasury<T0>) {
        0x2::transfer::share_object<ControlledTreasury<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

