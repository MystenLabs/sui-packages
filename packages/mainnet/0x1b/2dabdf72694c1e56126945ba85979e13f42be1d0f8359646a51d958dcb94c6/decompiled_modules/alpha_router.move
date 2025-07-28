module 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::alpha_router {
    struct ALPHA_ROUTER has drop {
        dummy_field: bool,
    }

    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
        manager_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        manager_id: 0x2::object::ID,
        admin_address: address,
    }

    struct TradeStep has copy, drop, store {
        dex: u8,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct TradeReceipt has copy, drop, store {
        id: 0x2::object::ID,
        from: 0x1::type_name::TypeName,
        from_amount: u64,
        steps: vector<TradeStep>,
        to: 0x1::type_name::TypeName,
        to_amount: u64,
    }

    struct None {
        dummy_field: bool,
    }

    struct IntermediateStorage has key {
        id: 0x2::object::UID,
        receipts: 0x2::table::Table<0x2::object::ID, TradeReceipt>,
    }

    struct MemeboxManager has key {
        id: 0x2::object::UID,
        super_admin: address,
        revoked_caps: 0x2::table::Table<0x2::object::ID, bool>,
        created_at: u64,
        intermediate_storage_id: 0x2::object::ID,
        usdc_vault_admin_cap: 0x1::option::Option<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::AdminCap>,
        meme_vault_admin_cap: 0x1::option::Option<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::AdminCap>,
    }

    struct SuperAdminCapTransferred has copy, drop {
        manager_id: 0x2::object::ID,
        old_super_admin: address,
        new_super_admin: address,
        timestamp: u64,
    }

    struct AdminCapCreated has copy, drop {
        admin_cap_id: 0x2::object::ID,
        admin: address,
        manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct AdminCapRevoked has copy, drop {
        admin_cap_id: 0x2::object::ID,
        admin: address,
        manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct MemeboxManagerCreated has copy, drop {
        manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct Traded has copy, drop {
        trade_id: 0x2::object::ID,
        from: 0x1::type_name::TypeName,
        from_amount: u64,
        steps: vector<TradeStep>,
        to: 0x1::type_name::TypeName,
        to_amount: u64,
        timestamp: u64,
    }

    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun after_execute<T0>(arg0: &MemeboxManager, arg1: &AdminCap, arg2: &mut 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::USDCVault, arg3: &mut 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::VaultManager, arg4: &mut IntermediateStorage, arg5: 0x2::object::ID, arg6: u8, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::option::is_some<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::AdminCap>(&arg0.usdc_vault_admin_cap) && 0x1::option::is_some<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::AdminCap>(&arg0.meme_vault_admin_cap), 9);
        let v0 = 0x1::option::borrow<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::AdminCap>(&arg0.usdc_vault_admin_cap);
        let v1 = 0x1::option::borrow<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::AdminCap>(&arg0.meme_vault_admin_cap);
        verify_admin_permission(arg0, arg1, 0x2::tx_context::sender(arg9));
        assert!(0x2::object::id<IntermediateStorage>(arg4) == arg0.intermediate_storage_id, 1);
        assert!(exists_trade_receipt(arg4, arg5), 6);
        let v2 = get_trade_receipt(arg4, arg5);
        let v3 = 0x2::coin::value<T0>(&arg7);
        let v4 = v2.id;
        let v5 = 0x1::type_name::get<T0>();
        store_intermediate_coin<T0>(arg4, arg7);
        let v6 = TradeStep{
            dex    : arg6,
            coin   : v5,
            amount : v3,
        };
        0x1::vector::push_back<TradeStep>(&mut v2.steps, v6);
        update_trade_receipt(arg4, v2);
        if (arg8 != 0) {
            assert!(v3 >= arg8, 7);
            v2.to = v5;
            v2.to_amount = v3;
            let v7 = Traded{
                trade_id    : v4,
                from        : v2.from,
                from_amount : v2.from_amount,
                steps       : v2.steps,
                to          : v2.to,
                to_amount   : v3,
                timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg9),
            };
            0x2::event::emit<Traded>(v7);
            delete_trade_receipt(arg4, v4);
            if (is_usdc<T0>()) {
                let v8 = extract_intermediate_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v3, arg9);
                0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::deposit_with_admin(arg2, v0, v8, arg9);
            } else {
                let v9 = extract_intermediate_coin<T0>(arg4, v3, arg9);
                0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::deposit_with_admin<T0>(arg3, v1, v9, arg9);
            };
        };
        v4
    }

    public entry fun approve(arg0: &mut MemeboxManager, arg1: &SuperAdminCap, arg2: &0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::USDCVault, arg3: &0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::SuperAdminCap, arg4: &0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::VaultManager, arg5: &0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::SuperAdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::AdminCap>(&arg0.usdc_vault_admin_cap) && 0x1::option::is_none<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::AdminCap>(&arg0.meme_vault_admin_cap), 8);
        verify_super_admin_cap(arg0, arg1);
        0x1::option::fill<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::AdminCap>(&mut arg0.usdc_vault_admin_cap, 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::create_admin_cap(arg2, arg3, arg6));
        0x1::option::fill<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::AdminCap>(&mut arg0.meme_vault_admin_cap, 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::create_admin_cap(arg4, arg5, arg6));
    }

    fun before_execute<T0>(arg0: &MemeboxManager, arg1: &AdminCap, arg2: &mut 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::USDCVault, arg3: &mut 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::VaultManager, arg4: &mut IntermediateStorage, arg5: 0x2::object::ID, arg6: u8, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::object::ID) {
        assert!(0x1::option::is_some<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::AdminCap>(&arg0.usdc_vault_admin_cap) && 0x1::option::is_some<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::AdminCap>(&arg0.meme_vault_admin_cap), 9);
        let v0 = 0x1::option::borrow<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::AdminCap>(&arg0.usdc_vault_admin_cap);
        let v1 = 0x1::option::borrow<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::AdminCap>(&arg0.meme_vault_admin_cap);
        verify_admin_permission(arg0, arg1, 0x2::tx_context::sender(arg8));
        assert!(0x2::object::id<IntermediateStorage>(arg4) == arg0.intermediate_storage_id, 1);
        assert!(arg7 > 0, 3);
        let v2 = arg5;
        if (!exists_trade_receipt(arg4, arg5)) {
            if (is_usdc<T0>()) {
                store_intermediate_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::withdraw_with_admin(arg2, v0, arg7, arg8));
            } else {
                store_intermediate_coin<T0>(arg4, 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::withdraw_with_admin<T0>(arg3, v1, arg7, arg8));
            };
            v2 = create_trade_receipt(arg4, 0x1::type_name::get<T0>(), arg7, arg8);
        };
        let v3 = extract_intermediate_coin<T0>(arg4, arg7, arg8);
        let v4 = get_trade_receipt(arg4, v2);
        (v3, v4.id)
    }

    public entry fun create_admin_caps_batch(arg0: &MemeboxManager, arg1: &SuperAdminCap, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            let v2 = AdminCap{
                id            : 0x2::object::new(arg3),
                manager_id    : 0x2::object::id<MemeboxManager>(arg0),
                admin_address : v1,
            };
            let v3 = AdminCapCreated{
                admin_cap_id : 0x2::object::id<AdminCap>(&v2),
                admin        : v1,
                manager_id   : 0x2::object::id<MemeboxManager>(arg0),
                timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
            };
            0x2::event::emit<AdminCapCreated>(v3);
            0x2::transfer::transfer<AdminCap>(v2, v1);
            v0 = v0 + 1;
        };
    }

    fun create_manager(arg0: &mut 0x2::tx_context::TxContext) : (MemeboxManager, SuperAdminCap) {
        let v0 = IntermediateStorage{
            id       : 0x2::object::new(arg0),
            receipts : 0x2::table::new<0x2::object::ID, TradeReceipt>(arg0),
        };
        let v1 = MemeboxManager{
            id                      : 0x2::object::new(arg0),
            super_admin             : 0x2::tx_context::sender(arg0),
            revoked_caps            : 0x2::table::new<0x2::object::ID, bool>(arg0),
            created_at              : 0x2::tx_context::epoch_timestamp_ms(arg0),
            intermediate_storage_id : 0x2::object::id<IntermediateStorage>(&v0),
            usdc_vault_admin_cap    : 0x1::option::none<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::AdminCap>(),
            meme_vault_admin_cap    : 0x1::option::none<0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::AdminCap>(),
        };
        let v2 = SuperAdminCap{
            id         : 0x2::object::new(arg0),
            manager_id : 0x2::object::id<MemeboxManager>(&v1),
        };
        0x2::transfer::share_object<IntermediateStorage>(v0);
        let v3 = MemeboxManagerCreated{
            manager_id : 0x2::object::id<MemeboxManager>(&v1),
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<MemeboxManagerCreated>(v3);
        (v1, v2)
    }

    fun create_trade_receipt(arg0: &mut IntermediateStorage, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg3);
        let v1 = TradeReceipt{
            id          : *0x2::object::uid_as_inner(&v0),
            from        : arg1,
            from_amount : arg2,
            steps       : 0x1::vector::empty<TradeStep>(),
            to          : 0x1::type_name::get<None>(),
            to_amount   : 0,
        };
        0x2::object::delete(v0);
        0x2::table::add<0x2::object::ID, TradeReceipt>(&mut arg0.receipts, v1.id, v1);
        v1.id
    }

    fun delete_trade_receipt(arg0: &mut IntermediateStorage, arg1: 0x2::object::ID) {
        assert!(exists_trade_receipt(arg0, arg1), 6);
        0x2::table::remove<0x2::object::ID, TradeReceipt>(&mut arg0.receipts, arg1);
    }

    public entry fun execute_bluefin_swap<T0, T1>(arg0: &mut MemeboxManager, arg1: &AdminCap, arg2: &mut 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::USDCVault, arg3: &mut 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::VaultManager, arg4: &mut IntermediateStorage, arg5: bool, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg11: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg12: &mut 0x2::tx_context::TxContext) : (u64, 0x2::object::ID) {
        if (arg5) {
            let (v2, v3) = before_execute<T0>(arg0, arg1, arg2, arg3, arg4, arg7, 4, arg6, arg12);
            let v4 = 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::bluefin_wrapper::swap_a2b<T0, T1>(arg9, arg10, arg11, v2, arg12);
            after_execute<T1>(arg0, arg1, arg2, arg3, arg4, v3, 4, v4, arg8, arg12);
            (0x2::coin::value<T1>(&v4), v3)
        } else {
            let (v5, v6) = before_execute<T1>(arg0, arg1, arg2, arg3, arg4, arg7, 4, arg6, arg12);
            let v7 = 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::bluefin_wrapper::swap_b2a<T0, T1>(arg9, arg10, arg11, v5, arg12);
            after_execute<T0>(arg0, arg1, arg2, arg3, arg4, v6, 4, v7, arg8, arg12);
            (0x2::coin::value<T0>(&v7), v6)
        }
    }

    public entry fun execute_cetus_swap<T0, T1>(arg0: &mut MemeboxManager, arg1: &AdminCap, arg2: &mut 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::USDCVault, arg3: &mut 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::VaultManager, arg4: &mut IntermediateStorage, arg5: bool, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (u64, 0x2::object::ID) {
        if (arg5) {
            let (v2, v3) = before_execute<T0>(arg0, arg1, arg2, arg3, arg4, arg7, 1, arg6, arg13);
            let v4 = 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::cetus_wrapper::swap_a2b<T0, T1>(arg9, arg10, arg11, v2, arg12, arg13);
            after_execute<T1>(arg0, arg1, arg2, arg3, arg4, v3, 1, v4, arg8, arg13);
            (0x2::coin::value<T1>(&v4), v3)
        } else {
            let (v5, v6) = before_execute<T1>(arg0, arg1, arg2, arg3, arg4, arg7, 1, arg6, arg13);
            let v7 = 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::cetus_wrapper::swap_b2a<T0, T1>(arg9, arg10, arg11, v5, arg12, arg13);
            after_execute<T0>(arg0, arg1, arg2, arg3, arg4, v6, 1, v7, arg8, arg13);
            (0x2::coin::value<T0>(&v7), v6)
        }
    }

    public entry fun execute_flowx_swap<T0, T1>(arg0: &mut MemeboxManager, arg1: &AdminCap, arg2: &mut 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::USDCVault, arg3: &mut 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::VaultManager, arg4: &mut IntermediateStorage, arg5: bool, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg10: &mut 0x2::tx_context::TxContext) : (u64, 0x2::object::ID) {
        if (arg5) {
            let (v2, v3) = before_execute<T0>(arg0, arg1, arg2, arg3, arg4, arg7, 3, arg6, arg10);
            let v4 = 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::flowx_wrapper::swap_a2b<T0, T1>(arg9, v2, arg10);
            after_execute<T1>(arg0, arg1, arg2, arg3, arg4, v3, 3, v4, arg8, arg10);
            (0x2::coin::value<T1>(&v4), v3)
        } else {
            let (v5, v6) = before_execute<T1>(arg0, arg1, arg2, arg3, arg4, arg7, 3, arg6, arg10);
            let v7 = 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::flowx_wrapper::swap_b2a<T0, T1>(arg9, v5, arg10);
            after_execute<T0>(arg0, arg1, arg2, arg3, arg4, v6, 3, v7, arg8, arg10);
            (0x2::coin::value<T0>(&v7), v6)
        }
    }

    public entry fun execute_turbos_swap<T0, T1, T2>(arg0: &mut MemeboxManager, arg1: &AdminCap, arg2: &mut 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::usdc_vault::USDCVault, arg3: &mut 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::meme_vault::VaultManager, arg4: &mut IntermediateStorage, arg5: bool, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) : (u64, 0x2::object::ID) {
        if (arg5) {
            let (v2, v3) = before_execute<T0>(arg0, arg1, arg2, arg3, arg4, arg7, 2, arg6, arg12);
            let v4 = 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::turbos_wrapper::swap_a2b<T0, T1, T2>(arg9, v2, arg10, arg11, arg12);
            after_execute<T1>(arg0, arg1, arg2, arg3, arg4, v3, 2, v4, arg8, arg12);
            (0x2::coin::value<T1>(&v4), v3)
        } else {
            let (v5, v6) = before_execute<T1>(arg0, arg1, arg2, arg3, arg4, arg7, 2, arg6, arg12);
            let v7 = 0xa8a3844bed9583b593d98a122940ad9f937ba5d992bb3f5137ce740bee9cb6f::turbos_wrapper::swap_b2a<T0, T1, T2>(arg9, v5, arg10, arg11, arg12);
            after_execute<T0>(arg0, arg1, arg2, arg3, arg4, v6, 2, v7, arg8, arg12);
            (0x2::coin::value<T0>(&v7), v6)
        }
    }

    fun exists_trade_receipt(arg0: &IntermediateStorage, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, TradeReceipt>(&arg0.receipts, arg1)
    }

    fun extract_intermediate_coin<T0>(arg0: &mut IntermediateStorage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = CoinKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0), 2);
        let v1 = 0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0);
        assert!(0x2::coin::value<T0>(v1) >= arg1, 2);
        0x2::coin::split<T0>(v1, arg1, arg2)
    }

    public fun get_intermediate_balance<T0>(arg0: &IntermediateStorage) : u64 {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            0x2::coin::value<T0>(0x2::dynamic_field::borrow<CoinKey<T0>, 0x2::coin::Coin<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun get_intermediate_storage_id(arg0: &MemeboxManager) : 0x2::object::ID {
        arg0.intermediate_storage_id
    }

    public fun get_super_admin(arg0: &MemeboxManager) : address {
        arg0.super_admin
    }

    fun get_trade_receipt(arg0: &IntermediateStorage, arg1: 0x2::object::ID) : TradeReceipt {
        assert!(exists_trade_receipt(arg0, arg1), 6);
        *0x2::table::borrow<0x2::object::ID, TradeReceipt>(&arg0.receipts, arg1)
    }

    fun init(arg0: ALPHA_ROUTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_manager(arg1);
        0x2::transfer::share_object<MemeboxManager>(v0);
        0x2::transfer::transfer<SuperAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_admin_cap_id_revoked(arg0: &MemeboxManager, arg1: 0x2::object::ID) : bool {
        is_admin_cap_revoked(arg0, arg1)
    }

    fun is_admin_cap_revoked(arg0: &MemeboxManager, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_caps, arg1)
    }

    fun is_usdc<T0>() : bool {
        0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::type_name::into_string(0x1::type_name::get<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>())
    }

    public fun is_valid_admin_cap(arg0: &MemeboxManager, arg1: &AdminCap) : bool {
        arg1.manager_id == 0x2::object::id<MemeboxManager>(arg0) && !is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1))
    }

    public entry fun revoke_admin_permissions_batch(arg0: &mut MemeboxManager, arg1: &SuperAdminCap, arg2: vector<0x2::object::ID>, arg3: &0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            if (!0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_caps, v1)) {
                0x2::table::add<0x2::object::ID, bool>(&mut arg0.revoked_caps, v1, true);
                let v2 = AdminCapRevoked{
                    admin_cap_id : v1,
                    admin        : @0x0,
                    manager_id   : 0x2::object::id<MemeboxManager>(arg0),
                    timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
                };
                0x2::event::emit<AdminCapRevoked>(v2);
            };
            v0 = v0 + 1;
        };
    }

    fun store_intermediate_coin<T0>(arg0: &mut IntermediateStorage, arg1: 0x2::coin::Coin<T0>) {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<CoinKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, arg1);
        };
    }

    public entry fun transfer_super_admin_cap(arg0: &mut MemeboxManager, arg1: SuperAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, &arg1);
        let v0 = SuperAdminCapTransferred{
            manager_id      : 0x2::object::id<MemeboxManager>(arg0),
            old_super_admin : arg0.super_admin,
            new_super_admin : arg2,
            timestamp       : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<SuperAdminCapTransferred>(v0);
        arg0.super_admin = arg2;
        0x2::transfer::public_transfer<SuperAdminCap>(arg1, arg2);
    }

    fun update_trade_receipt(arg0: &mut IntermediateStorage, arg1: TradeReceipt) {
        assert!(exists_trade_receipt(arg0, arg1.id), 6);
        0x2::table::remove<0x2::object::ID, TradeReceipt>(&mut arg0.receipts, arg1.id);
        0x2::table::add<0x2::object::ID, TradeReceipt>(&mut arg0.receipts, arg1.id, arg1);
    }

    fun verify_admin_permission(arg0: &MemeboxManager, arg1: &AdminCap, arg2: address) {
        assert!(arg1.manager_id == 0x2::object::id<MemeboxManager>(arg0), 1);
        assert!(arg1.admin_address == arg2, 1);
        assert!(!is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1)), 4);
    }

    fun verify_super_admin_cap(arg0: &MemeboxManager, arg1: &SuperAdminCap) {
        assert!(arg1.manager_id == 0x2::object::id<MemeboxManager>(arg0), 5);
    }

    // decompiled from Move bytecode v6
}

