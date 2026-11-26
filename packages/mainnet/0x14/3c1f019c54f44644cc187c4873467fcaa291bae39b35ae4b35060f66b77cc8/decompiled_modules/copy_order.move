module 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::copy_order {
    struct CopyOrderAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        role_version: u64,
    }

    struct CopyOrderPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        schema_version: u64,
        swap_pool_id: 0x2::object::ID,
        ast_receiver: address,
        admin: address,
        admin_version: u64,
        paused: bool,
        product_keys: vector<u64>,
        config_version: u64,
        next_order_no: u64,
        total_orders: u64,
        total_ast_principal: u128,
        total_performance_usdc: u128,
    }

    struct CopyOrderPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        swap_pool_id: 0x2::object::ID,
        ast_receiver: address,
        admin: address,
        timestamp_ms: u64,
    }

    struct CopyProductUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        chain_product_key: u64,
        enabled: bool,
        config_version: u64,
        timestamp_ms: u64,
    }

    struct CopyPauseUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        config_version: u64,
        timestamp_ms: u64,
    }

    struct CopyAdminUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        admin_version: u64,
        timestamp_ms: u64,
    }

    struct CopyOrderCreated has copy, drop {
        pool_id: 0x2::object::ID,
        swap_pool_id: 0x2::object::ID,
        order_no: u64,
        chain_product_key: u64,
        owner: address,
        ast_receiver: address,
        principal_ast: u64,
        performance_usdc: u64,
        price_e8: u64,
        price_version: u64,
        config_version: u64,
        created_at_ms: u64,
        maturity_at_ms: u64,
    }

    struct CopyOrderFunded has copy, drop {
        pool_id: 0x2::object::ID,
        swap_pool_id: 0x2::object::ID,
        destination_id: 0x2::object::ID,
        order_no: u64,
        chain_product_key: u64,
        owner: address,
        payment_ast: u64,
        payment_usdc: u64,
        principal_ast: u64,
        performance_usdc: u64,
        price_e8: u64,
        price_version: u64,
        config_version: u64,
        created_at_ms: u64,
        maturity_at_ms: u64,
    }

    fun assert_admin<T0, T1>(arg0: &CopyOrderPool<T0, T1>, arg1: &CopyOrderAdminCap<T0, T1>) {
        let v0 = if (arg0.schema_version == 1) {
            if (arg1.pool_id == 0x2::object::id<CopyOrderPool<T0, T1>>(arg0)) {
                arg1.role_version == arg0.admin_version
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 10);
    }

    fun assert_version<T0, T1>(arg0: &CopyOrderPool<T0, T1>, arg1: u64) {
        assert!(arg1 == arg0.config_version, 11);
    }

    fun ast_performance(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = valuation(arg0, arg1);
        assert!(v0 >= arg2, 8);
        v0
    }

    public fun get_info<T0, T1>(arg0: &CopyOrderPool<T0, T1>) : (0x2::object::ID, address, bool, u64, vector<u64>, u64, u128, u128) {
        (arg0.swap_pool_id, arg0.ast_receiver, arg0.paused, arg0.config_version, arg0.product_keys, arg0.total_orders, arg0.total_ast_principal, arg0.total_performance_usdc)
    }

    public fun owner_create_pool<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg0);
        assert!(arg2 != @0x0 && arg3 != @0x0, 1);
        let (_, _, v2, v3, _, _, _, _, _, _, _, _) = 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::get_pool_info<T0, T1>(arg1);
        assert!(v2 == 9 && v3 == 6, 9);
        let v12 = CopyOrderPool<T0, T1>{
            id                     : 0x2::object::new(arg5),
            schema_version         : 1,
            swap_pool_id           : 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::get_pool_id<T0, T1>(arg1),
            ast_receiver           : arg2,
            admin                  : arg3,
            admin_version          : 1,
            paused                 : true,
            product_keys           : vector[],
            config_version         : 1,
            next_order_no          : 1,
            total_orders           : 0,
            total_ast_principal    : 0,
            total_performance_usdc : 0,
        };
        let v13 = 0x2::object::id<CopyOrderPool<T0, T1>>(&v12);
        let v14 = CopyOrderAdminCap<T0, T1>{
            id           : 0x2::object::new(arg5),
            pool_id      : v13,
            role_version : 1,
        };
        let v15 = CopyOrderPoolCreated{
            pool_id      : v13,
            swap_pool_id : v12.swap_pool_id,
            ast_receiver : arg2,
            admin        : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CopyOrderPoolCreated>(v15);
        0x2::transfer::share_object<CopyOrderPool<T0, T1>>(v12);
        0x2::transfer::transfer<CopyOrderAdminCap<T0, T1>>(v14, arg3);
    }

    public fun owner_replace_admin<T0, T1>(arg0: &mut CopyOrderPool<T0, T1>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg1);
        assert!(arg2 != @0x0, 1);
        arg0.admin = arg2;
        arg0.admin_version = arg0.admin_version + 1;
        let v0 = CopyOrderAdminCap<T0, T1>{
            id           : 0x2::object::new(arg4),
            pool_id      : 0x2::object::id<CopyOrderPool<T0, T1>>(arg0),
            role_version : arg0.admin_version,
        };
        let v1 = CopyAdminUpdated{
            pool_id       : 0x2::object::id<CopyOrderPool<T0, T1>>(arg0),
            admin         : arg2,
            admin_version : arg0.admin_version,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CopyAdminUpdated>(v1);
        0x2::transfer::transfer<CopyOrderAdminCap<T0, T1>>(v0, arg2);
    }

    public fun owner_set_paused<T0, T1>(arg0: &mut CopyOrderPool<T0, T1>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg1);
        assert_version<T0, T1>(arg0, arg2);
        arg0.paused = arg3;
        arg0.config_version = arg0.config_version + 1;
        let v0 = CopyPauseUpdated{
            pool_id        : 0x2::object::id<CopyOrderPool<T0, T1>>(arg0),
            paused         : arg3,
            config_version : arg0.config_version,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CopyPauseUpdated>(v0);
    }

    public fun owner_set_product<T0, T1>(arg0: &mut CopyOrderPool<T0, T1>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg1);
        set_product_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5);
    }

    fun record_funded_order<T0, T1>(arg0: &mut CopyOrderPool<T0, T1>, arg1: u64, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = record_order<T0, T1>(arg0, arg6, arg7);
        let v1 = CopyOrderFunded{
            pool_id           : 0x2::object::id<CopyOrderPool<T0, T1>>(arg0),
            swap_pool_id      : arg0.swap_pool_id,
            destination_id    : arg3,
            order_no          : v0,
            chain_product_key : arg1,
            owner             : arg2,
            payment_ast       : arg4,
            payment_usdc      : arg5,
            principal_ast     : arg6,
            performance_usdc  : arg7,
            price_e8          : arg8,
            price_version     : arg9,
            config_version    : arg0.config_version,
            created_at_ms     : arg10,
            maturity_at_ms    : arg10 + 34473600000,
        };
        0x2::event::emit<CopyOrderFunded>(v1);
    }

    fun record_order<T0, T1>(arg0: &mut CopyOrderPool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0.next_order_no;
        arg0.next_order_no = v0 + 1;
        arg0.total_orders = arg0.total_orders + 1;
        arg0.total_ast_principal = arg0.total_ast_principal + (arg1 as u128);
        arg0.total_performance_usdc = arg0.total_performance_usdc + (arg2 as u128);
        v0
    }

    public fun set_paused<T0, T1>(arg0: &mut CopyOrderPool<T0, T1>, arg1: &CopyOrderAdminCap<T0, T1>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        assert_version<T0, T1>(arg0, arg2);
        arg0.paused = arg3;
        arg0.config_version = arg0.config_version + 1;
        let v0 = CopyPauseUpdated{
            pool_id        : 0x2::object::id<CopyOrderPool<T0, T1>>(arg0),
            paused         : arg3,
            config_version : arg0.config_version,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CopyPauseUpdated>(v0);
    }

    public fun set_product<T0, T1>(arg0: &mut CopyOrderPool<T0, T1>, arg1: &CopyOrderAdminCap<T0, T1>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        set_product_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5);
    }

    fun set_product_internal<T0, T1>(arg0: &mut CopyOrderPool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg0, arg1);
        assert!(arg2 > 0, 4);
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.product_keys, &arg2);
        if (arg3 && !v0) {
            0x1::vector::push_back<u64>(&mut arg0.product_keys, arg2);
        } else if (!arg3 && v0) {
            0x1::vector::remove<u64>(&mut arg0.product_keys, v1);
        };
        arg0.config_version = arg0.config_version + 1;
        let v2 = CopyProductUpdated{
            pool_id           : 0x2::object::id<CopyOrderPool<T0, T1>>(arg0),
            chain_product_key : arg2,
            enabled           : arg3,
            config_version    : arg0.config_version,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CopyProductUpdated>(v2);
    }

    public entry fun stake<T0, T1>(arg0: &mut CopyOrderPool<T0, T1>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = validate_order<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg8, arg9);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = ast_performance(v1, arg5, arg7);
        let v3 = arg0.ast_receiver;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v3);
        let v4 = record_order<T0, T1>(arg0, v1, v2);
        let v5 = CopyOrderCreated{
            pool_id           : 0x2::object::id<CopyOrderPool<T0, T1>>(arg0),
            swap_pool_id      : arg0.swap_pool_id,
            order_no          : v4,
            chain_product_key : arg3,
            owner             : 0x2::tx_context::sender(arg10),
            ast_receiver      : v3,
            principal_ast     : v1,
            performance_usdc  : v2,
            price_e8          : arg5,
            price_version     : arg6,
            config_version    : arg0.config_version,
            created_at_ms     : v0,
            maturity_at_ms    : v0 + 34473600000,
        };
        0x2::event::emit<CopyOrderCreated>(v5);
    }

    public entry fun stake_ast_to_reserve<T0, T1>(arg0: &mut CopyOrderPool<T0, T1>, arg1: &mut 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = validate_order<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg8, arg9);
        let v1 = 0x2::coin::value<T0>(&arg2);
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::deposit_order_ast<T0, T1>(arg1, arg2);
        record_funded_order<T0, T1>(arg0, arg3, 0x2::tx_context::sender(arg10), 0x2::object::id<0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>>(arg1), v1, 0, v1, ast_performance(v1, arg5, arg7), arg5, arg6, v0);
    }

    public entry fun stake_usdc_to_navi<T0, T1>(arg0: &mut CopyOrderPool<T0, T1>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg2: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::navi_vault::Vault<T0, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = validate_order<T0, T1>(arg0, arg1, arg8, arg9, arg10, arg11, arg13, arg14);
        let v1 = 0x2::coin::value<T1>(&arg7);
        let v2 = (v1 as u128) * 100000000000 / (arg10 as u128);
        assert!(v2 > 0 && v2 <= 18446744073709551615, 7);
        let v3 = (v2 as u64);
        assert!(v3 >= arg12, 8);
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::navi_vault::deposit_bound_usdc<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg14);
        record_funded_order<T0, T1>(arg0, arg8, 0x2::tx_context::sender(arg15), 0x2::object::id<0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::navi_vault::Vault<T0, T1>>(arg2), 0, v1, v3, v1, arg10, arg11, v0);
    }

    fun validate_order<T0, T1>(arg0: &CopyOrderPool<T0, T1>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) : u64 {
        assert!(arg0.schema_version == 1 && arg0.swap_pool_id == 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::get_pool_id<T0, T1>(arg1), 2);
        assert_version<T0, T1>(arg0, arg3);
        assert!(!arg0.paused, 3);
        assert!(0x1::vector::contains<u64>(&arg0.product_keys, &arg2), 4);
        let (_, v1, v2, v3, v4, v5, _, _, _, _, _, _) = 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::get_pool_info<T0, T1>(arg1);
        assert!(!v1, 3);
        assert!(v2 == 9 && v3 == 6, 9);
        let v12 = if (v4 > 0) {
            if (v4 == arg4) {
                v5 == arg5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v12, 5);
        let v13 = 0x2::clock::timestamp_ms(arg7);
        assert!(v13 <= arg6, 6);
        v13
    }

    fun valuation(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / 100000000000;
        assert!(v0 > 0 && v0 <= 18446744073709551615, 7);
        (v0 as u64)
    }

    // decompiled from Move bytecode v7
}

