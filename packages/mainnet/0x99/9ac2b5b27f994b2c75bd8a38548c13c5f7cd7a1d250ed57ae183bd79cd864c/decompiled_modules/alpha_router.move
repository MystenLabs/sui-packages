module 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::alpha_router {
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
        total_trades: u64,
        total_volume_usdc: u64,
        intermediate_storage_id: 0x2::object::ID,
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
        trade_id: u64,
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

    fun after_execute<T0>(arg0: &MemeboxManager, arg1: &AdminCap, arg2: &mut 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::USDCVault, arg3: &0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::AdminCap, arg4: &mut 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::VaultManager, arg5: &0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::AdminCap, arg6: &mut IntermediateStorage, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::object::ID, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        verify_admin_permission(arg0, arg1, 0x2::tx_context::sender(arg10));
        assert!(0x2::object::id<IntermediateStorage>(arg6) == arg0.intermediate_storage_id, 1);
        assert!(exists_trade_receipt(arg6, arg8), 6);
        let v0 = get_trade_receipt(arg6, arg8);
        let v1 = 0x2::coin::value<T0>(&arg7);
        let v2 = v0.id;
        let v3 = 0x1::type_name::get<T0>();
        store_intermediate_coin<T0>(arg6, arg7);
        let v4 = TradeStep{
            dex    : 1,
            coin   : v3,
            amount : v1,
        };
        0x1::vector::push_back<TradeStep>(&mut v0.steps, v4);
        update_trade_receipt(arg6, v0);
        if (arg9 != 0) {
            assert!(v1 >= arg9, 7);
            v0.to = v3;
            v0.to_amount = v1;
            let v5 = Traded{
                trade_id    : arg0.total_trades,
                from        : v0.from,
                from_amount : v0.from_amount,
                steps       : v0.steps,
                to          : v0.to,
                to_amount   : v1,
                timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg10),
            };
            0x2::event::emit<Traded>(v5);
            delete_trade_receipt(arg6, v2);
            if (is_usdc<T0>()) {
                let v6 = extract_intermediate_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6, v1, arg10);
                0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::deposit(arg2, arg3, v6, arg10);
            } else {
                let v7 = extract_intermediate_coin<T0>(arg6, v1, arg10);
                0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::deposit<T0>(arg4, arg5, v7, arg10);
            };
        };
        v2
    }

    fun before_execute<T0>(arg0: &MemeboxManager, arg1: &AdminCap, arg2: &mut 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::USDCVault, arg3: &0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::AdminCap, arg4: &mut 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::VaultManager, arg5: &0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::AdminCap, arg6: &mut IntermediateStorage, arg7: u64, arg8: 0x2::object::ID, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::object::ID) {
        verify_admin_permission(arg0, arg1, 0x2::tx_context::sender(arg9));
        assert!(0x2::object::id<IntermediateStorage>(arg6) == arg0.intermediate_storage_id, 1);
        assert!(arg7 > 0, 3);
        let v0 = arg8;
        if (!exists_trade_receipt(arg6, arg8)) {
            if (is_usdc<T0>()) {
                store_intermediate_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6, 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::withdraw(arg2, arg3, arg7, arg9));
            } else {
                store_intermediate_coin<T0>(arg6, 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::withdraw<T0>(arg4, arg5, arg7, arg9));
            };
            v0 = create_trade_receipt(arg6, 0x1::type_name::get<T0>(), arg7, arg9);
        };
        let v1 = extract_intermediate_coin<T0>(arg6, arg7, arg9);
        let v2 = get_trade_receipt(arg6, v0);
        (v1, v2.id)
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
            total_trades            : 0,
            total_volume_usdc       : 0,
            intermediate_storage_id : 0x2::object::id<IntermediateStorage>(&v0),
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

    public entry fun execute_cetus_swap<T0, T1>(arg0: &mut MemeboxManager, arg1: &AdminCap, arg2: &mut 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::USDCVault, arg3: &0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::AdminCap, arg4: &mut 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::VaultManager, arg5: &0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::AdminCap, arg6: &mut IntermediateStorage, arg7: bool, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (u64, 0x2::object::ID) {
        if (arg7) {
            let (v2, v3) = before_execute<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg15);
            let v4 = 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::cetus_wrapper::swap_a2b<T0, T1>(arg11, arg12, arg13, v2, arg14, arg15);
            after_execute<T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v4, v3, arg10, arg15);
            (0x2::coin::value<T1>(&v4), v3)
        } else {
            let (v5, v6) = before_execute<T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg15);
            let v7 = 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::cetus_wrapper::swap_b2a<T0, T1>(arg11, arg12, arg13, v5, arg14, arg15);
            after_execute<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v7, v6, arg10, arg15);
            (0x2::coin::value<T0>(&v7), v6)
        }
    }

    public entry fun execute_flowx_swap<T0, T1>(arg0: &mut MemeboxManager, arg1: &AdminCap, arg2: &mut 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::USDCVault, arg3: &0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::AdminCap, arg4: &mut 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::VaultManager, arg5: &0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::AdminCap, arg6: &mut IntermediateStorage, arg7: bool, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg12: &mut 0x2::tx_context::TxContext) : (u64, 0x2::object::ID) {
        if (arg7) {
            let (v2, v3) = before_execute<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg12);
            let v4 = 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::flowx_wrapper::swap_a2b<T0, T1>(arg11, v2, arg12);
            after_execute<T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v4, v3, arg10, arg12);
            (0x2::coin::value<T1>(&v4), v3)
        } else {
            let (v5, v6) = before_execute<T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg12);
            let v7 = 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::flowx_wrapper::swap_b2a<T0, T1>(arg11, v5, arg12);
            after_execute<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v7, v6, arg10, arg12);
            (0x2::coin::value<T0>(&v7), v6)
        }
    }

    public entry fun execute_turbos_swap<T0, T1, T2>(arg0: &mut MemeboxManager, arg1: &AdminCap, arg2: &mut 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::USDCVault, arg3: &0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::AdminCap, arg4: &mut 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::VaultManager, arg5: &0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::AdminCap, arg6: &mut IntermediateStorage, arg7: bool, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg12: &0x2::clock::Clock, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x2::tx_context::TxContext) : (u64, 0x2::object::ID) {
        if (arg7) {
            let (v2, v3) = before_execute<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg14);
            let v4 = 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::turbos_wrapper::swap_a2b<T0, T1, T2>(arg11, v2, arg12, arg13, arg14);
            after_execute<T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v4, v3, arg10, arg14);
            (0x2::coin::value<T1>(&v4), v3)
        } else {
            let (v5, v6) = before_execute<T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg14);
            let v7 = 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::turbos_wrapper::swap_b2a<T0, T1, T2>(arg11, v5, arg12, arg13, arg14);
            after_execute<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v7, v6, arg10, arg14);
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

    public fun get_manager_info(arg0: &MemeboxManager) : (address, u64, u64, u64) {
        (arg0.super_admin, arg0.total_trades, arg0.total_volume_usdc, arg0.created_at)
    }

    public fun get_super_admin(arg0: &MemeboxManager) : address {
        arg0.super_admin
    }

    fun get_trade_receipt(arg0: &IntermediateStorage, arg1: 0x2::object::ID) : TradeReceipt {
        assert!(exists_trade_receipt(arg0, arg1), 6);
        *0x2::table::borrow<0x2::object::ID, TradeReceipt>(&arg0.receipts, arg1)
    }

    public fun get_trading_stats<T0>(arg0: &MemeboxManager, arg1: &0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::USDCVault, arg2: &0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::VaultManager) : (u64, u64, u64, u64) {
        (0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault::get_balance(arg1), 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::meme_vault::get_vault_info<T0>(arg2), arg0.total_trades, arg0.total_volume_usdc)
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

