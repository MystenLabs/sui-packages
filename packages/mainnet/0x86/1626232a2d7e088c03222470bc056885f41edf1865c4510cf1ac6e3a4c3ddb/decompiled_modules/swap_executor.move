module 0xe48830fe3fe499720a339f05d0bc37f68fb8759e8d29d2198241c92742f69767::swap_executor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SwapExecutorConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        access_cap: 0x1::option::Option<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>,
        operators: 0x2::table::Table<address, bool>,
        max_slippage_bps: u64,
        max_swap_amount_usd: u64,
        deadline_time_duration: u64,
        last_request_expire_time: u64,
        enable: bool,
    }

    struct SecureSwapReceipt<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
        amount_withdrawn: u64,
        min_output_required: u64,
        slippage_bps: u64,
        deadline_ms: u64,
        coin_in_price: u64,
        coin_out_price: u64,
    }

    struct Pause has copy, drop {
        dummy_field: bool,
    }

    struct Resume has copy, drop {
        dummy_field: bool,
    }

    struct SetOperator has copy, drop {
        operator: address,
        allow: bool,
    }

    struct SwapInitiated has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        min_output: u64,
        slippage_bps: u64,
        coin_in_price: u64,
        coin_out_price: u64,
        coin_in: 0x1::ascii::String,
        coin_out: 0x1::ascii::String,
        timestamp: u64,
    }

    struct SwapCompleted has copy, drop {
        vault_id: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        actual_slippage_bps: u64,
        coin_in: 0x1::ascii::String,
        coin_out: 0x1::ascii::String,
        timestamp: u64,
    }

    struct UpdateMaxSlippage has copy, drop {
        old_max_slippage_bps: u64,
        new_max_slippage_bps: u64,
    }

    struct UpdateMaxSwapAmountUsd has copy, drop {
        old_max_swap_amount_usd: u64,
        new_max_swap_amount_usd: u64,
    }

    struct UpdateDeadlineTimeDuration has copy, drop {
        old_deadline_time_duration: u64,
        new_deadline_time_duration: u64,
    }

    entry fun add_access_cap(arg0: &AdminCap, arg1: &mut SwapExecutorConfig, arg2: 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap) {
        0x1::option::fill<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&mut arg1.access_cap, arg2);
    }

    fun calculate_min_output_with_oracle<T0, T1>(arg0: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (_, v1, v2) = get_price_oracle<T0>(arg0, arg1, arg5);
        let (_, v4, v5) = get_price_oracle<T1>(arg0, arg2, arg5);
        let (v6, v7) = if (v4 >= v1) {
            (v2 * 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::pow10((((v4 - v1) * 2) as u8)), v5)
        } else {
            (v2, v5 * 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::pow10((((v1 - v4) * 2) as u8)))
        };
        let v8 = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::safe_mul_div_u64(arg3, v6, v7);
        (v2, v5, v8 - v8 * arg4 / 10000)
    }

    public fun check_operator(arg0: &SwapExecutorConfig, arg1: address) : bool {
        if (!0x2::table::contains<address, bool>(&arg0.operators, arg1)) {
            return false
        };
        *0x2::table::borrow<address, bool>(&arg0.operators, arg1)
    }

    fun get_amount_usd<T0>(arg0: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let (_, v1, v2) = get_price_oracle<T0>(arg0, arg1, arg3);
        let (v3, v4) = if (6 >= v1) {
            (v2 * 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::pow10((((6 - v1) * 2) as u8)), 1000000)
        } else {
            (v2, 1000000 * 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::pow10((((v1 - 6) * 2) as u8)))
        };
        0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::safe_mul_div_u64(arg2, v3, v4)
    }

    fun get_price_oracle<T0>(arg0: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (vector<u8>, u64, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg0, v0);
        let (v2, v3) = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::get_price_guarded(arg1, v1, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_age(arg0), 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_conf(arg0), arg2);
        assert!(v2 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg0, v0), 9);
        assert!(v3 > 0, 10);
        (v2, v1, v3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = SwapExecutorConfig{
            id                       : 0x2::object::new(arg0),
            version                  : 1,
            access_cap               : 0x1::option::none<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(),
            operators                : 0x2::table::new<address, bool>(arg0),
            max_slippage_bps         : 500,
            max_swap_amount_usd      : 0,
            deadline_time_duration   : 300000,
            last_request_expire_time : 0,
            enable                   : true,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<SwapExecutorConfig>(v1);
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut SwapExecutorConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    entry fun pause(arg0: &AdminCap, arg1: &mut SwapExecutorConfig) {
        assert!(arg1.version == 1, 2);
        arg1.enable = false;
        let v0 = Pause{dummy_field: false};
        0x2::event::emit<Pause>(v0);
    }

    entry fun resume(arg0: &AdminCap, arg1: &mut SwapExecutorConfig) {
        assert!(arg1.version == 1, 2);
        arg1.enable = true;
        let v0 = Resume{dummy_field: false};
        0x2::event::emit<Resume>(v0);
    }

    public fun secure_deposit<T0, T1, T2, T3>(arg0: &SwapExecutorConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: 0x2::coin::Coin<T3>, arg4: SecureSwapReceipt<T2, T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 3);
        assert!(check_operator(arg0, 0x2::tx_context::sender(arg6)), 5);
        validate_receipt<T0, T1, T2, T3>(arg2, arg4, 0x2::coin::value<T3>(&arg3), arg5);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T3>(arg1, arg2, arg3, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap));
    }

    public fun secure_deposit_with_collateral<T0, T1, T2>(arg0: &SwapExecutorConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: SecureSwapReceipt<T2, T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 3);
        assert!(check_operator(arg0, 0x2::tx_context::sender(arg6)), 5);
        validate_receipt<T0, T1, T2, T0>(arg2, arg4, 0x2::coin::value<T0>(&arg3), arg5);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg2, arg3, arg6);
    }

    public fun secure_withdraw<T0, T1, T2, T3>(arg0: &mut SwapExecutorConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: u64, arg8: u64, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, SecureSwapReceipt<T2, T3>) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 3);
        assert!(check_operator(arg0, 0x2::tx_context::sender(arg12)), 5);
        assert!(arg7 >= 0 && arg7 <= 10000, 6);
        let v0 = 0x2::clock::timestamp_ms(arg11);
        assert!(arg8 >= v0, 7);
        assert!(arg8 > arg0.last_request_expire_time, 8);
        assert!(arg6 > 0, 4);
        if (arg0.max_swap_amount_usd > 0) {
            assert!(get_amount_usd<T0>(arg3, arg4, arg6, arg11) <= arg0.max_swap_amount_usd, 11);
        };
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v2 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>());
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0x2::object::id<SwapExecutorConfig>(arg0);
        let v5 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg1);
        let v6 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2);
        let v7 = 0x2::object::id<0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig>(arg3);
        let v8 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4);
        let v9 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg5);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x2::object::ID>(&v5));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x2::object::ID>(&v6));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x2::object::ID>(&v7));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x2::object::ID>(&v8));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x2::object::ID>(&v9));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::ascii::String>(&v1));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::ascii::String>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v3, arg9, arg10);
        let (v10, v11, v12) = calculate_min_output_with_oracle<T2, T3>(arg3, arg4, arg5, arg6, arg7, arg11);
        let v13 = SecureSwapReceipt<T2, T3>{
            vault_id            : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2),
            amount_withdrawn    : arg6,
            min_output_required : v12,
            slippage_bps        : arg7,
            deadline_ms         : v0 + arg0.deadline_time_duration,
            coin_in_price       : v10,
            coin_out_price      : v11,
        };
        arg0.last_request_expire_time = arg8;
        let v14 = SwapInitiated{
            vault_id       : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2),
            amount         : arg6,
            min_output     : v12,
            slippage_bps   : arg7,
            coin_in_price  : v10,
            coin_out_price : v11,
            coin_in        : v1,
            coin_out       : v2,
            timestamp      : v0,
        };
        0x2::event::emit<SwapInitiated>(v14);
        (0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T2>(arg1, arg2, arg6, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg12), v13)
    }

    public fun secure_withdraw_with_collateral<T0, T1, T2>(arg0: &mut SwapExecutorConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: u64, arg8: u64, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SecureSwapReceipt<T0, T2>) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 3);
        assert!(check_operator(arg0, 0x2::tx_context::sender(arg12)), 5);
        assert!(arg7 >= 0 && arg7 <= 10000, 6);
        let v0 = 0x2::clock::timestamp_ms(arg11);
        assert!(arg8 >= v0, 7);
        assert!(arg8 > arg0.last_request_expire_time, 8);
        assert!(arg6 > 0, 4);
        if (arg0.max_swap_amount_usd > 0) {
            assert!(get_amount_usd<T0>(arg3, arg4, arg6, arg11) <= arg0.max_swap_amount_usd, 11);
        };
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x2::object::id<SwapExecutorConfig>(arg0);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg1);
        let v5 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2);
        let v6 = 0x2::object::id<0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig>(arg3);
        let v7 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4);
        let v8 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg5);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v5));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v6));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v7));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v8));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::ascii::String>(&v1));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v2, arg9, arg10);
        let (v9, v10, v11) = calculate_min_output_with_oracle<T0, T2>(arg3, arg4, arg5, arg6, arg7, arg11);
        let v12 = SecureSwapReceipt<T0, T2>{
            vault_id            : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2),
            amount_withdrawn    : arg6,
            min_output_required : v11,
            slippage_bps        : arg7,
            deadline_ms         : v0 + arg0.deadline_time_duration,
            coin_in_price       : v9,
            coin_out_price      : v10,
        };
        arg0.last_request_expire_time = arg8;
        let v13 = SwapInitiated{
            vault_id       : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2),
            amount         : arg6,
            min_output     : v11,
            slippage_bps   : arg7,
            coin_in_price  : v9,
            coin_out_price : v10,
            coin_in        : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            coin_out       : v1,
            timestamp      : v0,
        };
        0x2::event::emit<SwapInitiated>(v13);
        (0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_vault_funds<T0, T1>(arg1, arg2, arg6, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg12), v12)
    }

    entry fun set_operator(arg0: &AdminCap, arg1: &mut SwapExecutorConfig, arg2: address, arg3: bool) {
        assert!(arg1.version == 1, 2);
        let v0 = false;
        if (0x2::table::contains<address, bool>(&arg1.operators, arg2)) {
            if (*0x2::table::borrow<address, bool>(&arg1.operators, arg2) != arg3) {
                *0x2::table::borrow_mut<address, bool>(&mut arg1.operators, arg2) = arg3;
                v0 = true;
            };
        } else {
            0x2::table::add<address, bool>(&mut arg1.operators, arg2, arg3);
            v0 = true;
        };
        if (v0) {
            let v1 = SetOperator{
                operator : arg2,
                allow    : arg3,
            };
            0x2::event::emit<SetOperator>(v1);
        };
    }

    entry fun update_deadline_time_duration(arg0: &AdminCap, arg1: &mut SwapExecutorConfig, arg2: u64) {
        assert!(arg1.version == 1, 2);
        assert!(arg2 > 0, 4);
        arg1.deadline_time_duration = arg2;
        let v0 = UpdateDeadlineTimeDuration{
            old_deadline_time_duration : arg1.deadline_time_duration,
            new_deadline_time_duration : arg2,
        };
        0x2::event::emit<UpdateDeadlineTimeDuration>(v0);
    }

    entry fun update_max_slippage_bps(arg0: &AdminCap, arg1: &mut SwapExecutorConfig, arg2: u64) {
        assert!(arg1.version == 1, 2);
        assert!(arg2 > 0 && arg2 <= 10000, 6);
        arg1.max_slippage_bps = arg2;
        let v0 = UpdateMaxSlippage{
            old_max_slippage_bps : arg1.max_slippage_bps,
            new_max_slippage_bps : arg2,
        };
        0x2::event::emit<UpdateMaxSlippage>(v0);
    }

    entry fun update_max_swap_amount_usd(arg0: &AdminCap, arg1: &mut SwapExecutorConfig, arg2: u64) {
        assert!(arg1.version == 1, 2);
        assert!(arg2 >= 100000000, 4);
        arg1.max_swap_amount_usd = arg2;
        let v0 = UpdateMaxSwapAmountUsd{
            old_max_swap_amount_usd : arg1.max_swap_amount_usd,
            new_max_swap_amount_usd : arg2,
        };
        0x2::event::emit<UpdateMaxSwapAmountUsd>(v0);
    }

    fun validate_receipt<T0, T1, T2, T3>(arg0: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg1: SecureSwapReceipt<T2, T3>, arg2: u64, arg3: &0x2::clock::Clock) {
        let SecureSwapReceipt {
            vault_id            : v0,
            amount_withdrawn    : v1,
            min_output_required : v2,
            slippage_bps        : v3,
            deadline_ms         : v4,
            coin_in_price       : v5,
            coin_out_price      : v6,
        } = arg1;
        assert!(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg0) == v0, 12);
        assert!(v5 > 0 && v6 > 0, 10);
        assert!(v3 <= 10000, 6);
        let v7 = 0x2::clock::timestamp_ms(arg3);
        assert!(v7 <= v4, 13);
        assert!(arg2 >= v2, 14);
        let v8 = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::safe_mul_div_u64(v2, 10000, 10000 - v3);
        let v9 = if (v8 > arg2) {
            (v8 - arg2) * 10000 / v8
        } else {
            0
        };
        assert!(v9 <= v3, 15);
        let v10 = SwapCompleted{
            vault_id            : v0,
            amount_in           : v1,
            amount_out          : arg2,
            actual_slippage_bps : v9,
            coin_in             : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
            coin_out            : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()),
            timestamp           : v7,
        };
        0x2::event::emit<SwapCompleted>(v10);
    }

    // decompiled from Move bytecode v6
}

