module 0x85b03a5a3dbc3c1f475ef1454e4a9f2fc2dd15c5de037884ba5adfe7ddd29cf2::swap_router {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Store has key {
        id: 0x2::object::UID,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
        deposit_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        withdraw_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
    }

    struct ConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ActiveTradeCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GlobalUsageKey has copy, drop, store {
        dummy_field: bool,
    }

    struct UserUsageKey has copy, drop, store {
        user: address,
    }

    struct LegacyCapRevokedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Config has store {
        version: u64,
        public_on: bool,
        window_ms: u64,
        max_gas_bps: u64,
        addr_swaps: u64,
        addr_deep: u64,
        swap_deep: u64,
        global_deep: u64,
        gross_bps: u64,
        whitelist: 0x2::table::Table<address, bool>,
    }

    struct GlobalUsage has store {
        window: u64,
        deep: u64,
    }

    struct UserUsage has store {
        window: u64,
        count: u64,
        deep: u64,
    }

    struct Sponsored has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        deep: u64,
        window: u64,
    }

    struct Denied has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        reason: u8,
    }

    entry fun balance<T0>(arg0: &Store) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager)
    }

    entry fun deposit<T0>(arg0: &mut Store, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(&mut arg0.balance_manager, arg1, arg2);
    }

    entry fun set_balance_manager_referral(arg0: &AdminCap, arg1: &mut Store, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral) {
        let v0 = ActiveTradeCapKey{dummy_field: false};
        let v1 = if (0x2::dynamic_object_field::exists_with_type<ActiveTradeCapKey, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg1.id, v0)) {
            let v2 = ActiveTradeCapKey{dummy_field: false};
            0x2::dynamic_object_field::borrow<ActiveTradeCapKey, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg1.id, v2)
        } else {
            &arg1.trade_cap
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::set_balance_manager_referral(&mut arg1.balance_manager, arg2, v1);
    }

    entry fun unset_balance_manager_referral(arg0: &AdminCap, arg1: &mut Store, arg2: 0x2::object::ID) {
        let v0 = ActiveTradeCapKey{dummy_field: false};
        let v1 = if (0x2::dynamic_object_field::exists_with_type<ActiveTradeCapKey, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg1.id, v0)) {
            let v2 = ActiveTradeCapKey{dummy_field: false};
            0x2::dynamic_object_field::borrow<ActiveTradeCapKey, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg1.id, v2)
        } else {
            &arg1.trade_cap
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::unset_balance_manager_referral(&mut arg1.balance_manager, arg2, v1);
    }

    entry fun withdraw_with_cap<T0>(arg0: &AdminCap, arg1: &mut Store, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(&mut arg1.balance_manager, &arg1.withdraw_cap, arg2, arg4), arg3);
    }

    entry fun stake<T0, T1>(arg0: &AdminCap, arg1: &mut Store, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = ActiveTradeCapKey{dummy_field: false};
        let v1 = if (0x2::dynamic_object_field::exists_with_type<ActiveTradeCapKey, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg1.id, v0)) {
            let v2 = ActiveTradeCapKey{dummy_field: false};
            0x2::dynamic_object_field::borrow<ActiveTradeCapKey, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg1.id, v2)
        } else {
            &arg1.trade_cap
        };
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg1.balance_manager, v1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::stake<T0, T1>(arg2, &mut arg1.balance_manager, &v3, arg3, arg4);
    }

    entry fun unstake<T0, T1>(arg0: &AdminCap, arg1: &mut Store, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        let v0 = ActiveTradeCapKey{dummy_field: false};
        let v1 = if (0x2::dynamic_object_field::exists_with_type<ActiveTradeCapKey, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg1.id, v0)) {
            let v2 = ActiveTradeCapKey{dummy_field: false};
            0x2::dynamic_object_field::borrow<ActiveTradeCapKey, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg1.id, v2)
        } else {
            &arg1.trade_cap
        };
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg1.balance_manager, v1, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::unstake<T0, T1>(arg2, &mut arg1.balance_manager, &v3, arg3);
    }

    entry fun allow(arg0: &AdminCap, arg1: &mut Store, arg2: address) {
        let v0 = ConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<ConfigKey, Config>(&arg1.id, v0), 3);
        let v1 = ConfigKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<ConfigKey, Config>(&mut arg1.id, v1);
        if (!0x2::table::contains<address, bool>(&v2.whitelist, arg2)) {
            0x2::table::add<address, bool>(&mut v2.whitelist, arg2, true);
        };
    }

    public(friend) fun check_sponsorship(arg0: &Store, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = ConfigKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<ConfigKey, Config>(&arg0.id, v1)) {
            let v2 = Denied{
                sender  : v0,
                pool_id : arg1,
                reason  : 1,
            };
            0x2::event::emit<Denied>(v2);
            return false
        };
        let v3 = ConfigKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow<ConfigKey, Config>(&arg0.id, v3);
        assert!(v4.version == 2, 1);
        let v5 = (((arg2 as u128) * (v4.gross_bps as u128) / 10000) as u64);
        if (arg2 == 0) {
            return true
        };
        if ((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance_manager) as u128) < (v5 as u128) * 2) {
            let v6 = Denied{
                sender  : v0,
                pool_id : arg1,
                reason  : 3,
            };
            0x2::event::emit<Denied>(v6);
            return false
        };
        if (0x2::table::contains<address, bool>(&v4.whitelist, v0)) {
            return true
        };
        if (!v4.public_on) {
            let v7 = Denied{
                sender  : v0,
                pool_id : arg1,
                reason  : 5,
            };
            0x2::event::emit<Denied>(v7);
            return false
        };
        if ((0x2::tx_context::gas_price(arg4) as u128) * 10000 > (v4.max_gas_bps as u128) * (0x2::tx_context::reference_gas_price(arg4) as u128)) {
            let v8 = Denied{
                sender  : v0,
                pool_id : arg1,
                reason  : 6,
            };
            0x2::event::emit<Denied>(v8);
            return false
        };
        if (v5 > v4.swap_deep) {
            let v9 = Denied{
                sender  : v0,
                pool_id : arg1,
                reason  : 7,
            };
            0x2::event::emit<Denied>(v9);
            return false
        };
        let v10 = 0x2::clock::timestamp_ms(arg3) / v4.window_ms;
        let v11 = GlobalUsageKey{dummy_field: false};
        let v12 = if (0x2::dynamic_field::exists_with_type<GlobalUsageKey, GlobalUsage>(&arg0.id, v11)) {
            let v13 = GlobalUsageKey{dummy_field: false};
            let v14 = 0x2::dynamic_field::borrow<GlobalUsageKey, GlobalUsage>(&arg0.id, v13);
            if (v14.window == v10) {
                v14.deep
            } else {
                0
            }
        } else {
            0
        };
        if ((v12 as u128) + (v5 as u128) > (v4.global_deep as u128)) {
            let v15 = Denied{
                sender  : v0,
                pool_id : arg1,
                reason  : 8,
            };
            0x2::event::emit<Denied>(v15);
            return false
        };
        let v16 = UserUsageKey{user: v0};
        if (0x2::dynamic_field::exists_with_type<UserUsageKey, UserUsage>(&arg0.id, v16)) {
            let v17 = 0x2::dynamic_field::borrow<UserUsageKey, UserUsage>(&arg0.id, v16);
            if (v17.window == v10) {
                if (v17.count >= v4.addr_swaps || (v17.deep as u128) + (v5 as u128) > (v4.addr_deep as u128)) {
                    let v18 = Denied{
                        sender  : v0,
                        pool_id : arg1,
                        reason  : 9,
                    };
                    0x2::event::emit<Denied>(v18);
                    return false
                };
            };
        };
        true
    }

    entry fun disallow(arg0: &AdminCap, arg1: &mut Store, arg2: address) {
        let v0 = ConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<ConfigKey, Config>(&arg1.id, v0), 3);
        let v1 = ConfigKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<ConfigKey, Config>(&mut arg1.id, v1);
        if (0x2::table::contains<address, bool>(&v2.whitelist, arg2)) {
            0x2::table::remove<address, bool>(&mut v2.whitelist, arg2);
        };
    }

    public fun global_spent_in_current_window(arg0: &Store, arg1: &0x2::clock::Clock) : u64 {
        if (!is_setup(arg0)) {
            return 0
        };
        let v0 = ConfigKey{dummy_field: false};
        let v1 = GlobalUsageKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<GlobalUsageKey, GlobalUsage>(&arg0.id, v1)) {
            let v3 = GlobalUsageKey{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow<GlobalUsageKey, GlobalUsage>(&arg0.id, v3);
            if (v4.window == 0x2::clock::timestamp_ms(arg1) / 0x2::dynamic_field::borrow<ConfigKey, Config>(&arg0.id, v0).window_ms) {
                v4.deep
            } else {
                0
            }
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0);
        let v1 = Store{
            id              : 0x2::object::new(arg0),
            balance_manager : v0,
            trade_cap       : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v0, arg0),
            deposit_cap     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_deposit_cap(&mut v0, arg0),
            withdraw_cap    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_withdraw_cap(&mut v0, arg0),
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Store>(v1);
    }

    public fun is_public(arg0: &Store) : bool {
        if (!is_setup(arg0)) {
            return false
        };
        let v0 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow<ConfigKey, Config>(&arg0.id, v0).public_on
    }

    public fun is_setup(arg0: &Store) : bool {
        let v0 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<ConfigKey, Config>(&arg0.id, v0)
    }

    public fun is_whitelisted(arg0: &Store, arg1: address) : bool {
        if (!is_setup(arg0)) {
            return false
        };
        let v0 = ConfigKey{dummy_field: false};
        0x2::table::contains<address, bool>(&0x2::dynamic_field::borrow<ConfigKey, Config>(&arg0.id, v0).whitelist, arg1)
    }

    entry fun migrate_config(arg0: &AdminCap, arg1: &mut Store) {
        let v0 = ConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<ConfigKey, Config>(&arg1.id, v0), 3);
        let v1 = ConfigKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<ConfigKey, Config>(&mut arg1.id, v1);
        assert!(v2.version < 2, 1);
        v2.version = 2;
    }

    public(friend) fun post_swap_record(arg0: &mut Store, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = ConfigKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<ConfigKey, Config>(&arg0.id, v0);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x2::clock::timestamp_ms(arg4) / v1.window_ms;
        if (!0x2::table::contains<address, bool>(&v1.whitelist, v2) && arg2 > 0) {
            record_usage(arg0, v2, arg3, v3);
        };
        let v4 = Sponsored{
            sender  : v2,
            pool_id : arg1,
            deep    : arg3,
            window  : v3,
        };
        0x2::event::emit<Sponsored>(v4);
    }

    public(friend) fun record_usage(arg0: &mut Store, arg1: address, arg2: u64, arg3: u64) {
        let v0 = GlobalUsageKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<GlobalUsageKey, GlobalUsage>(&arg0.id, v0)) {
            let v1 = GlobalUsageKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<GlobalUsageKey, GlobalUsage>(&mut arg0.id, v1);
            if (v2.window == arg3) {
                v2.deep = v2.deep + arg2;
            } else {
                v2.window = arg3;
                v2.deep = arg2;
            };
        } else {
            let v3 = GlobalUsageKey{dummy_field: false};
            let v4 = GlobalUsage{
                window : arg3,
                deep   : arg2,
            };
            0x2::dynamic_field::add<GlobalUsageKey, GlobalUsage>(&mut arg0.id, v3, v4);
        };
        let v5 = UserUsageKey{user: arg1};
        if (0x2::dynamic_field::exists_with_type<UserUsageKey, UserUsage>(&arg0.id, v5)) {
            let v6 = 0x2::dynamic_field::borrow_mut<UserUsageKey, UserUsage>(&mut arg0.id, v5);
            if (v6.window == arg3) {
                v6.count = v6.count + 1;
                v6.deep = v6.deep + arg2;
            } else {
                v6.window = arg3;
                v6.count = 1;
                v6.deep = arg2;
            };
        } else {
            let v7 = UserUsage{
                window : arg3,
                count  : 1,
                deep   : arg2,
            };
            0x2::dynamic_field::add<UserUsageKey, UserUsage>(&mut arg0.id, v5, v7);
        };
    }

    entry fun revoke_legacy_cap(arg0: &AdminCap, arg1: &mut Store, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<ConfigKey, Config>(&arg1.id, v0), 3);
        let v1 = LegacyCapRevokedKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_with_type<LegacyCapRevokedKey, bool>(&arg1.id, v1), 4);
        let v2 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg1.trade_cap);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::revoke_trade_cap(&mut arg1.balance_manager, &v2, arg2);
        let v3 = LegacyCapRevokedKey{dummy_field: false};
        0x2::dynamic_field::add<LegacyCapRevokedKey, bool>(&mut arg1.id, v3, true);
    }

    entry fun set_limits(arg0: &AdminCap, arg1: &mut Store, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = ConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<ConfigKey, Config>(&arg1.id, v0), 3);
        assert!(arg2 > 0, 5);
        assert!(arg8 >= 10000 && arg8 <= 1000000, 6);
        let v1 = ConfigKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<ConfigKey, Config>(&mut arg1.id, v1);
        v2.window_ms = arg2;
        v2.max_gas_bps = arg3;
        v2.addr_swaps = arg4;
        v2.addr_deep = arg5;
        v2.swap_deep = arg6;
        v2.global_deep = arg7;
        v2.gross_bps = arg8;
    }

    entry fun set_public(arg0: &AdminCap, arg1: &mut Store, arg2: bool) {
        let v0 = ConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<ConfigKey, Config>(&arg1.id, v0), 3);
        let v1 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ConfigKey, Config>(&mut arg1.id, v1).public_on = arg2;
    }

    entry fun setup(arg0: &AdminCap, arg1: &mut Store, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ConfigKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_with_type<ConfigKey, Config>(&arg1.id, v0), 2);
        let v1 = ActiveTradeCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<ActiveTradeCapKey, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg1.id, v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut arg1.balance_manager, arg2));
        let v2 = Config{
            version     : 2,
            public_on   : false,
            window_ms   : 3600000,
            max_gas_bps : 15000,
            addr_swaps  : 5,
            addr_deep   : 150000000,
            swap_deep   : 150000000,
            global_deep : 300000000,
            gross_bps   : 25000,
            whitelist   : 0x2::table::new<address, bool>(arg2),
        };
        let v3 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::add<ConfigKey, Config>(&mut arg1.id, v3, v2);
    }

    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut Store, arg1: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T0, T1>(arg1);
        let v1 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T0, T1>(v0);
        let v2 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2);
        let (_, _, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg2, 0x2::coin::value<T0>(&v1), arg4);
        if (check_sponsorship(arg0, v2, v5, arg4, arg5)) {
            let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance_manager);
            let v7 = ActiveTradeCapKey{dummy_field: false};
            let (v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote_with_manager<T0, T1>(arg2, &mut arg0.balance_manager, 0x2::dynamic_object_field::borrow<ActiveTradeCapKey, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.id, v7), &arg0.deposit_cap, &arg0.withdraw_cap, v1, 0, arg4, arg5);
            let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance_manager);
            let v11 = if (v6 > v10) {
                v6 - v10
            } else {
                0
            };
            post_swap_record(arg0, v2, v5, v11, arg4, arg5);
            0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<T0>(v8, 0x2::tx_context::sender(arg5));
            0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T0, T1>(v0, v9);
        } else {
            let (v12, v13, v14) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg2, v1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), 0, arg4, arg5);
            0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v14, 0x2::tx_context::sender(arg5));
            0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<T0>(v12, 0x2::tx_context::sender(arg5));
            0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T0, T1>(v0, v13);
        };
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut Store, arg1: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T1, T0>(arg1);
        let v1 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T1, T0>(v0);
        let v2 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2);
        let (_, _, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg2, 0x2::coin::value<T1>(&v1), arg4);
        if (check_sponsorship(arg0, v2, v5, arg4, arg5)) {
            let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance_manager);
            let v7 = ActiveTradeCapKey{dummy_field: false};
            let (v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base_with_manager<T0, T1>(arg2, &mut arg0.balance_manager, 0x2::dynamic_object_field::borrow<ActiveTradeCapKey, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.id, v7), &arg0.deposit_cap, &arg0.withdraw_cap, v1, 0, arg4, arg5);
            let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance_manager);
            let v11 = if (v6 > v10) {
                v6 - v10
            } else {
                0
            };
            post_swap_record(arg0, v2, v5, v11, arg4, arg5);
            0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<T1>(v9, 0x2::tx_context::sender(arg5));
            0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T1, T0>(v0, v8);
        } else {
            let (v12, v13, v14) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg2, v1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), 0, arg4, arg5);
            0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v14, 0x2::tx_context::sender(arg5));
            0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<T1>(v13, 0x2::tx_context::sender(arg5));
            0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T1, T0>(v0, v12);
        };
    }

    public fun user_usage_in_current_window(arg0: &Store, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64) {
        if (!is_setup(arg0)) {
            return (0, 0)
        };
        let v0 = ConfigKey{dummy_field: false};
        let v1 = UserUsageKey{user: arg1};
        if (0x2::dynamic_field::exists_with_type<UserUsageKey, UserUsage>(&arg0.id, v1)) {
            let v4 = 0x2::dynamic_field::borrow<UserUsageKey, UserUsage>(&arg0.id, v1);
            if (v4.window == 0x2::clock::timestamp_ms(arg2) / 0x2::dynamic_field::borrow<ConfigKey, Config>(&arg0.id, v0).window_ms) {
                (v4.count, v4.deep)
            } else {
                (0, 0)
            }
        } else {
            (0, 0)
        }
    }

    // decompiled from Move bytecode v7
}

