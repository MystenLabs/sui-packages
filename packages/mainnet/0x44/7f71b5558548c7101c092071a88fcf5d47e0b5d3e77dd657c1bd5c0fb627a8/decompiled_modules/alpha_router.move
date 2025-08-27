module 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::alpha_router {
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
        index: u64,
        steps: vector<TradeStep>,
    }

    struct TradeData has copy, drop, store {
        trade_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        from_amount: u64,
        receipts: vector<TradeReceipt>,
        to: 0x1::type_name::TypeName,
        to_amount: u64,
    }

    struct ClearingTrade has store {
        trade_id: 0x1::string::String,
        amounts: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    struct None {
        dummy_field: bool,
    }

    struct IntermediateStorage has key {
        id: 0x2::object::UID,
        trade_data: 0x2::table::Table<0x1::string::String, TradeData>,
        clearing_trades: 0x2::table::Table<0x1::string::String, ClearingTrade>,
    }

    struct MemeboxManager has key {
        id: 0x2::object::UID,
        revoked_caps: 0x2::table::Table<0x2::object::ID, bool>,
        created_at: u64,
        intermediate_storage_id: 0x2::object::ID,
        usdc_vault_admin_cap: 0x1::option::Option<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::AdminCap>,
        meme_vault_admin_cap: 0x1::option::Option<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::AdminCap>,
        paused: bool,
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

    struct Paused has copy, drop {
        manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct Unpaused has copy, drop {
        manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct Traded has copy, drop {
        trade_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        from_amount: u64,
        receipts: vector<TradeReceipt>,
        to: 0x1::type_name::TypeName,
        to_amount: u64,
        timestamp: u64,
    }

    struct TradeCleared has copy, drop {
        trade_id: 0x1::string::String,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
        timestamp: u64,
        clearable_count: u64,
        cleared_count: u64,
    }

    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun after_execute<T0>(arg0: &MemeboxManager, arg1: &mut IntermediateStorage, arg2: &AdminCap, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::tx_context::TxContext) {
        verify_state(arg0);
        assert!(0x2::object::id<IntermediateStorage>(arg1) == arg0.intermediate_storage_id, 1);
        verify_admin_permission(arg0, arg2, 0x2::tx_context::sender(arg7));
        assert!(exists_trade_receipt(arg1, arg3, arg4), 9);
        let v0 = borrow_mut_trade(arg1, arg3);
        let v1 = 0x2::coin::value<T0>(&arg6);
        let v2 = 0x1::type_name::get<T0>();
        if (v2 == v0.to) {
            v0.to_amount = v0.to_amount + v1;
        };
        let v3 = borrow_mut_trade_receipt(arg1, arg3, arg4);
        let v4 = TradeStep{
            dex    : arg5,
            coin   : v2,
            amount : v1,
        };
        0x1::vector::push_back<TradeStep>(&mut v3.steps, v4);
        store_intermediate_coin<T0>(arg1, arg6);
    }

    public entry fun approve(arg0: &mut MemeboxManager, arg1: &SuperAdminCap, arg2: &0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::USDCVault, arg3: &0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::SuperAdminCap, arg4: &0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::VaultManager, arg5: &0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::SuperAdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::AdminCap>(&arg0.usdc_vault_admin_cap) && 0x1::option::is_none<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::AdminCap>(&arg0.meme_vault_admin_cap), 11);
        verify_super_admin_cap(arg0, arg1);
        0x1::option::fill<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::AdminCap>(&mut arg0.usdc_vault_admin_cap, 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::create_admin_cap(arg2, arg3, arg6));
        0x1::option::fill<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::AdminCap>(&mut arg0.meme_vault_admin_cap, 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::create_admin_cap(arg4, arg5, arg6));
    }

    fun before_execute<T0>(arg0: &MemeboxManager, arg1: &mut IntermediateStorage, arg2: &AdminCap, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_state(arg0);
        verify_trade_is_clearing(arg1, arg3);
        assert!(0x2::object::id<IntermediateStorage>(arg1) == arg0.intermediate_storage_id, 1);
        verify_admin_permission(arg0, arg2, 0x2::tx_context::sender(arg7));
        assert!(exists_trade(arg1, arg3), 7);
        assert!(arg6 > 0, 3);
        if (0x1::type_name::get<T0>() == borrow_trade(arg1, arg3).from) {
            assert!(!exists_trade_receipt(arg1, arg3, arg4), 8);
            let v0 = create_trade_receipt(arg1, arg3, 0x1::type_name::get<T0>(), arg6, arg7);
            assert!(v0 == arg4, 13);
        };
        extract_intermediate_coin<T0>(arg1, arg6, arg7)
    }

    fun borrow_mut_trade(arg0: &mut IntermediateStorage, arg1: 0x1::string::String) : &mut TradeData {
        assert!(exists_trade(arg0, arg1), 7);
        0x2::table::borrow_mut<0x1::string::String, TradeData>(&mut arg0.trade_data, arg1)
    }

    fun borrow_mut_trade_receipt(arg0: &mut IntermediateStorage, arg1: 0x1::string::String, arg2: u64) : &mut TradeReceipt {
        assert!(exists_trade_receipt(arg0, arg1, arg2), 9);
        0x1::vector::borrow_mut<TradeReceipt>(&mut borrow_mut_trade(arg0, arg1).receipts, arg2)
    }

    fun borrow_trade(arg0: &IntermediateStorage, arg1: 0x1::string::String) : &TradeData {
        assert!(exists_trade(arg0, arg1), 7);
        0x2::table::borrow<0x1::string::String, TradeData>(&arg0.trade_data, arg1)
    }

    fun borrow_trade_receipt(arg0: &IntermediateStorage, arg1: 0x1::string::String, arg2: u64) : &TradeReceipt {
        assert!(exists_trade_receipt(arg0, arg1, arg2), 9);
        0x1::vector::borrow<TradeReceipt>(&borrow_trade(arg0, arg1).receipts, arg2)
    }

    public entry fun clear_trade_data<T0>(arg0: &mut MemeboxManager, arg1: &mut IntermediateStorage, arg2: &SuperAdminCap, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<IntermediateStorage>(arg1) == arg0.intermediate_storage_id, 1);
        verify_super_admin_cap(arg0, arg2);
        assert!(exists_trade(arg1, arg3), 7);
        if (!0x2::table::contains<0x1::string::String, ClearingTrade>(&arg1.clearing_trades, arg3)) {
            let v0 = ClearingTrade{
                trade_id : arg3,
                amounts  : 0x2::table::new<0x1::type_name::TypeName, u64>(arg5),
            };
            0x2::table::add<0x1::string::String, ClearingTrade>(&mut arg1.clearing_trades, arg3, v0);
        };
        let v1 = *borrow_trade(arg1, arg3);
        let v2 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, u64>(&0x2::table::borrow<0x1::string::String, ClearingTrade>(&arg1.clearing_trades, arg3).amounts, v2), 16);
        let v3 = 0;
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v5 = 0x2::table::new<0x1::type_name::TypeName, u64>(arg5);
        while (v3 < 0x1::vector::length<TradeReceipt>(&v1.receipts)) {
            let v6 = *0x1::vector::borrow<TradeReceipt>(&v1.receipts, v3);
            let v7 = 0x1::vector::borrow<TradeStep>(&v6.steps, 0x1::vector::length<TradeStep>(&v6.steps) - 1);
            let v8 = 0;
            if (0x2::table::contains<0x1::type_name::TypeName, u64>(&v5, v7.coin)) {
                v8 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&v5, v7.coin);
                0x2::table::remove<0x1::type_name::TypeName, u64>(&mut v5, v7.coin);
            } else {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, v7.coin);
            };
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut v5, v7.coin, v8 + v7.amount);
            v3 = v3 + 1;
        };
        let v9 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&v5, 0x1::type_name::get<T0>());
        let v10 = extract_intermediate_coin<T0>(arg1, v9, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, arg4);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut 0x2::table::borrow_mut<0x1::string::String, ClearingTrade>(&mut arg1.clearing_trades, arg3).amounts, v2, v9);
        let v11 = 0x1::vector::length<0x1::type_name::TypeName>(&v4);
        let v12 = 0x2::table::length<0x1::type_name::TypeName, u64>(&0x2::table::borrow<0x1::string::String, ClearingTrade>(&arg1.clearing_trades, arg3).amounts);
        let v13 = TradeCleared{
            trade_id        : arg3,
            coin            : v2,
            amount          : v9,
            recipient       : arg4,
            timestamp       : 0x2::tx_context::epoch_timestamp_ms(arg5),
            clearable_count : v11,
            cleared_count   : v12,
        };
        0x2::event::emit<TradeCleared>(v13);
        if (v11 == v12) {
            delete_trade(arg1, arg3);
        };
        let v14 = 0;
        while (v14 < 0x1::vector::length<0x1::type_name::TypeName>(&v4)) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut v5, *0x1::vector::borrow<0x1::type_name::TypeName>(&v4, v14));
            v14 = v14 + 1;
        };
        0x2::table::destroy_empty<0x1::type_name::TypeName, u64>(v5);
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
            id              : 0x2::object::new(arg0),
            trade_data      : 0x2::table::new<0x1::string::String, TradeData>(arg0),
            clearing_trades : 0x2::table::new<0x1::string::String, ClearingTrade>(arg0),
        };
        let v1 = MemeboxManager{
            id                      : 0x2::object::new(arg0),
            revoked_caps            : 0x2::table::new<0x2::object::ID, bool>(arg0),
            created_at              : 0x2::tx_context::epoch_timestamp_ms(arg0),
            intermediate_storage_id : 0x2::object::id<IntermediateStorage>(&v0),
            usdc_vault_admin_cap    : 0x1::option::none<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::AdminCap>(),
            meme_vault_admin_cap    : 0x1::option::none<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::AdminCap>(),
            paused                  : false,
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

    fun create_trade_receipt(arg0: &mut IntermediateStorage, arg1: 0x1::string::String, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: &0x2::tx_context::TxContext) : u64 {
        assert!(exists_trade(arg0, arg1), 7);
        let v0 = 0x1::vector::length<TradeReceipt>(&0x2::table::borrow<0x1::string::String, TradeData>(&arg0.trade_data, arg1).receipts);
        let v1 = 0x1::vector::empty<TradeStep>();
        let v2 = TradeStep{
            dex    : 0,
            coin   : arg2,
            amount : arg3,
        };
        0x1::vector::push_back<TradeStep>(&mut v1, v2);
        let v3 = TradeReceipt{
            index : v0,
            steps : v1,
        };
        0x1::vector::push_back<TradeReceipt>(&mut 0x2::table::borrow_mut<0x1::string::String, TradeData>(&mut arg0.trade_data, arg1).receipts, v3);
        v0
    }

    fun delete_trade(arg0: &mut IntermediateStorage, arg1: 0x1::string::String) {
        assert!(exists_trade(arg0, arg1), 7);
        0x2::table::remove<0x1::string::String, TradeData>(&mut arg0.trade_data, arg1);
    }

    public entry fun end_trade<T0, T1>(arg0: &MemeboxManager, arg1: &mut IntermediateStorage, arg2: &AdminCap, arg3: &mut 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::USDCVault, arg4: &mut 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::VaultManager, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        verify_state(arg0);
        verify_trade_is_clearing(arg1, arg5);
        assert!(0x2::object::id<IntermediateStorage>(arg1) == arg0.intermediate_storage_id, 1);
        verify_admin_permission(arg0, arg2, 0x2::tx_context::sender(arg7));
        assert!(exists_trade(arg1, arg5), 7);
        let v0 = borrow_trade(arg1, arg5);
        if (arg6 != 0) {
            assert!(v0.to_amount >= arg6, 10);
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<TradeReceipt>(&v0.receipts)) {
            let v2 = *0x1::vector::borrow<TradeReceipt>(&v0.receipts, v1);
            assert!(0x1::vector::borrow<TradeStep>(&v2.steps, 0x1::vector::length<TradeStep>(&v2.steps) - 1).coin == v0.to, 14);
            v1 = v1 + 1;
        };
        let v3 = Traded{
            trade_id    : v0.trade_id,
            from        : v0.from,
            from_amount : v0.from_amount,
            receipts    : v0.receipts,
            to          : v0.to,
            to_amount   : v0.to_amount,
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg7),
        };
        0x2::event::emit<Traded>(v3);
        let v4 = 0x1::option::borrow<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::AdminCap>(&arg0.usdc_vault_admin_cap);
        let v5 = 0x1::option::borrow<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::AdminCap>(&arg0.meme_vault_admin_cap);
        if (is_usdc<T1>()) {
            let v6 = extract_intermediate_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, v0.to_amount, arg7);
            0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::deposit_with_admin(arg3, v4, v6, arg7);
        } else {
            let v7 = extract_intermediate_coin<T1>(arg1, v0.to_amount, arg7);
            0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::deposit_with_admin<T1>(arg4, v5, v7, arg7);
        };
        delete_trade(arg1, arg5);
    }

    public entry fun execute_bluefin_swap<T0, T1>(arg0: &mut MemeboxManager, arg1: &mut IntermediateStorage, arg2: &AdminCap, arg3: 0x1::string::String, arg4: u64, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5) {
            let v1 = before_execute<T0>(arg0, arg1, arg2, arg3, arg4, 4, arg6, arg10);
            let v2 = 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::bluefin_wrapper::swap_a2b<T0, T1>(arg7, arg8, arg9, v1, arg10);
            after_execute<T1>(arg0, arg1, arg2, arg3, arg4, 4, v2, arg10);
            0x2::coin::value<T1>(&v2)
        } else {
            let v3 = before_execute<T1>(arg0, arg1, arg2, arg3, arg4, 4, arg6, arg10);
            let v4 = 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::bluefin_wrapper::swap_b2a<T0, T1>(arg7, arg8, arg9, v3, arg10);
            after_execute<T0>(arg0, arg1, arg2, arg3, arg4, 4, v4, arg10);
            0x2::coin::value<T0>(&v4)
        }
    }

    public entry fun execute_cetus_swap<T0, T1>(arg0: &mut MemeboxManager, arg1: &mut IntermediateStorage, arg2: &AdminCap, arg3: 0x1::string::String, arg4: u64, arg5: bool, arg6: u64, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5) {
            let v1 = before_execute<T0>(arg0, arg1, arg2, arg3, arg4, 1, arg6, arg11);
            let v2 = 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::cetus_wrapper::swap_a2b<T0, T1>(arg7, arg8, arg9, v1, arg10, arg11);
            after_execute<T1>(arg0, arg1, arg2, arg3, arg4, 1, v2, arg11);
            0x2::coin::value<T1>(&v2)
        } else {
            let v3 = before_execute<T1>(arg0, arg1, arg2, arg3, arg4, 1, arg6, arg11);
            let v4 = 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::cetus_wrapper::swap_b2a<T0, T1>(arg7, arg8, arg9, v3, arg10, arg11);
            after_execute<T0>(arg0, arg1, arg2, arg3, arg4, 1, v4, arg11);
            0x2::coin::value<T0>(&v4)
        }
    }

    public entry fun execute_flowx_v3_swap<T0, T1>(arg0: &mut MemeboxManager, arg1: &mut IntermediateStorage, arg2: &AdminCap, arg3: 0x1::string::String, arg4: u64, arg5: bool, arg6: u64, arg7: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg8: u64, arg9: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5) {
            let v1 = before_execute<T0>(arg0, arg1, arg2, arg3, arg4, 3, arg6, arg11);
            let v2 = 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::flowx_v3_wrapper::swap_a2b<T0, T1>(arg7, arg8, v1, arg9, arg10, arg11);
            after_execute<T1>(arg0, arg1, arg2, arg3, arg4, 3, v2, arg11);
            0x2::coin::value<T1>(&v2)
        } else {
            let v3 = before_execute<T1>(arg0, arg1, arg2, arg3, arg4, 3, arg6, arg11);
            let v4 = 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::flowx_v3_wrapper::swap_b2a<T0, T1>(arg7, arg8, v3, arg9, arg10, arg11);
            after_execute<T0>(arg0, arg1, arg2, arg3, arg4, 3, v4, arg11);
            0x2::coin::value<T0>(&v4)
        }
    }

    public entry fun execute_turbos_swap<T0, T1, T2>(arg0: &mut MemeboxManager, arg1: &mut IntermediateStorage, arg2: &AdminCap, arg3: 0x1::string::String, arg4: u64, arg5: bool, arg6: u64, arg7: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5) {
            let v1 = before_execute<T0>(arg0, arg1, arg2, arg3, arg4, 2, arg6, arg10);
            let v2 = 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::turbos_wrapper::swap_a2b<T0, T1, T2>(arg7, v1, arg8, arg9, arg10);
            after_execute<T1>(arg0, arg1, arg2, arg3, arg4, 2, v2, arg10);
            0x2::coin::value<T1>(&v2)
        } else {
            let v3 = before_execute<T1>(arg0, arg1, arg2, arg3, arg4, 2, arg6, arg10);
            let v4 = 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::turbos_wrapper::swap_b2a<T0, T1, T2>(arg7, v3, arg8, arg9, arg10);
            after_execute<T0>(arg0, arg1, arg2, arg3, arg4, 2, v4, arg10);
            0x2::coin::value<T0>(&v4)
        }
    }

    fun exists_trade(arg0: &IntermediateStorage, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, TradeData>(&arg0.trade_data, arg1)
    }

    fun exists_trade_receipt(arg0: &IntermediateStorage, arg1: 0x1::string::String, arg2: u64) : bool {
        let v0 = 0x2::table::borrow<0x1::string::String, TradeData>(&arg0.trade_data, arg1);
        exists_trade(arg0, arg1) && arg2 < 0x1::vector::length<TradeReceipt>(&v0.receipts)
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

    public entry fun pause(arg0: &mut MemeboxManager, arg1: &SuperAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        arg0.paused = true;
        let v0 = Paused{
            manager_id : 0x2::object::id<MemeboxManager>(arg0),
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<Paused>(v0);
    }

    public entry fun query_trade_data(arg0: &MemeboxManager, arg1: &IntermediateStorage, arg2: 0x1::string::String) : TradeData {
        assert!(0x2::object::id<IntermediateStorage>(arg1) == arg0.intermediate_storage_id, 1);
        *borrow_trade(arg1, arg2)
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

    public entry fun start_trade<T0, T1>(arg0: &MemeboxManager, arg1: &mut IntermediateStorage, arg2: &AdminCap, arg3: &mut 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::USDCVault, arg4: &mut 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::VaultManager, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        verify_state(arg0);
        verify_trade_is_clearing(arg1, arg5);
        assert!(0x2::object::id<IntermediateStorage>(arg1) == arg0.intermediate_storage_id, 1);
        verify_admin_permission(arg0, arg2, 0x2::tx_context::sender(arg7));
        assert!(!exists_trade(arg1, arg5), 6);
        assert!(arg6 > 0, 3);
        let v0 = TradeData{
            trade_id    : arg5,
            from        : 0x1::type_name::get<T0>(),
            from_amount : arg6,
            receipts    : 0x1::vector::empty<TradeReceipt>(),
            to          : 0x1::type_name::get<T1>(),
            to_amount   : 0,
        };
        0x2::table::add<0x1::string::String, TradeData>(&mut arg1.trade_data, arg5, v0);
        let v1 = 0x1::option::borrow<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::AdminCap>(&arg0.usdc_vault_admin_cap);
        let v2 = 0x1::option::borrow<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::AdminCap>(&arg0.meme_vault_admin_cap);
        if (is_usdc<T0>()) {
            store_intermediate_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::withdraw_with_admin(arg3, v1, arg6, arg7));
        } else {
            store_intermediate_coin<T0>(arg1, 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::withdraw_with_admin<T0>(arg4, v2, arg6, arg7));
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

    public entry fun unpause(arg0: &mut MemeboxManager, arg1: &SuperAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        arg0.paused = false;
        let v0 = Unpaused{
            manager_id : 0x2::object::id<MemeboxManager>(arg0),
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<Unpaused>(v0);
    }

    fun verify_admin_permission(arg0: &MemeboxManager, arg1: &AdminCap, arg2: address) {
        assert!(arg1.manager_id == 0x2::object::id<MemeboxManager>(arg0), 1);
        assert!(arg1.admin_address == arg2, 1);
        assert!(!is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1)), 4);
    }

    fun verify_state(arg0: &MemeboxManager) {
        assert!(!arg0.paused, 15);
        assert!(0x1::option::is_some<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::usdc_vault::AdminCap>(&arg0.usdc_vault_admin_cap) && 0x1::option::is_some<0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault::AdminCap>(&arg0.meme_vault_admin_cap), 12);
    }

    fun verify_super_admin_cap(arg0: &MemeboxManager, arg1: &SuperAdminCap) {
        assert!(arg1.manager_id == 0x2::object::id<MemeboxManager>(arg0), 5);
    }

    fun verify_trade_is_clearing(arg0: &IntermediateStorage, arg1: 0x1::string::String) {
        assert!(!0x2::table::contains<0x1::string::String, ClearingTrade>(&arg0.clearing_trades, arg1), 17);
    }

    // decompiled from Move bytecode v6
}

