module 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_db_vault {
    struct LotusDBVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        incentive_acc: 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::AccumulationDistributor,
        farm_key: 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::FarmMemberKey,
        strategy_params: 0x2::table::Table<0x1::string::String, u64>,
        user_positions: 0x2::vec_map::VecMap<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>,
        user_cost: 0x2::vec_map::VecMap<address, u64>,
        user_last_interaction: 0x2::vec_map::VecMap<address, u64>,
        allowed_pool: 0x2::object::ID,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
        deposit_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        withdraw_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
        free_balances: 0x2::bag::Bag,
        collected_performance_fees: 0x2::bag::Bag,
        collected_strategy_fees: 0x2::bag::Bag,
        staked_deep_amount: u64,
    }

    struct LotusDBVaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        access_flag: u64,
    }

    struct OrderParams has copy, drop, store {
        client_order_id: u64,
        order_type: u8,
        self_matching_option: u8,
        price: u64,
        quantity: u64,
        is_bid: bool,
        pay_with_deep: bool,
        expire_timestamp: u64,
    }

    struct ActivateBotEvent has copy, drop {
        vault_id: 0x2::object::ID,
        trade_cap_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
    }

    struct DirectDepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user_address: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct PoolingDepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user_address: address,
        base_amount: u64,
        quote_amount: u64,
        deep_amount: u64,
    }

    struct PoolingWithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user_address: address,
        base_amount: u64,
        quote_amount: u64,
        deep_amount: u64,
        user_shares: u64,
        user_cost: u64,
        vault_total_shares: u64,
        if_update_order: bool,
    }

    struct RedeemAllFromVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        base_amount: u64,
        quote_amount: u64,
        deep_amount: u64,
    }

    struct RedeemIncentivesEvent has copy, drop {
        vault_id: 0x2::object::ID,
        incentive_type: 0x1::type_name::TypeName,
        incentive_value: u64,
    }

    struct ClaimRebateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        base_amount: u64,
        quote_amount: u64,
        deep_amount: u64,
    }

    struct UpdateStrategyParamsEvent has copy, drop {
        vault_id: 0x2::object::ID,
        key: 0x1::string::String,
        value: u64,
    }

    struct TopUpTDPoolEvent has copy, drop {
        vault_id: 0x2::object::ID,
        td_farm_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct DBStakeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        epoch: u64,
        amount: u64,
        stake: bool,
    }

    struct BatchLimitOrderEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        num_orders: u64,
        cancel_all_first: bool,
    }

    struct BBOLimitOrderEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        client_order_id: u64,
        requested_price: u64,
        actual_price: u64,
        quantity: u64,
        is_bid: bool,
    }

    struct ManagementFeeAccrueEvent has copy, drop {
        vault_id: 0x2::object::ID,
        fee_shares: u64,
        total_shares_after: u64,
        timestamp_ms: u64,
    }

    struct ManagementFeeWithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        base_amount: u64,
        quote_amount: u64,
        shares_withdrawn: u64,
    }

    struct TopUpTicket {
        withdraw_all_ticket: 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::MemberWithdrawAllTicket,
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : LotusDBVault<T0> {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg1);
        LotusDBVault<T0>{
            id                         : 0x2::object::new(arg1),
            incentive_acc              : 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::create(arg1),
            farm_key                   : 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::create_member_key(arg1),
            strategy_params            : 0x2::table::new<0x1::string::String, u64>(arg1),
            user_positions             : 0x2::vec_map::empty<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(),
            user_cost                  : 0x2::vec_map::empty<address, u64>(),
            user_last_interaction      : 0x2::vec_map::empty<address, u64>(),
            allowed_pool               : arg0,
            balance_manager            : v0,
            trade_cap                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v0, arg1),
            deposit_cap                : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_deposit_cap(&mut v0, arg1),
            withdraw_cap               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_withdraw_cap(&mut v0, arg1),
            free_balances              : 0x2::bag::new(arg1),
            collected_performance_fees : 0x2::bag::new(arg1),
            collected_strategy_fees    : 0x2::bag::new(arg1),
            staked_deep_amount         : 0,
        }
    }

    public fun top_up<T0, T1>(arg0: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>, arg1: &mut LotusDBVault<T0>, arg2: &mut TopUpTicket, arg3: &0x2::clock::Clock) {
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::top_up<T1>(&mut arg1.incentive_acc, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::member_withdraw_all_with_ticket<T1>(arg0, &mut arg2.withdraw_all_ticket, arg3));
    }

    public fun account<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::Account {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T1, T2>(arg1, &arg0.balance_manager)
    }

    public fun account_open_orders<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>) : 0x2::vec_set::VecSet<u128> {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T1, T2>(arg1, &arg0.balance_manager)
    }

    public fun cancel_all_orders<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4);
    }

    public fun cancel_order<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4, arg5);
    }

    public fun cancel_orders<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: vector<u128>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_orders<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4, arg5);
    }

    public fun get_account_order_details<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>) : vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order> {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T1, T2>(arg1, &arg0.balance_manager)
    }

    public fun place_limit_order<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_market_order<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: u64, arg4: u8, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg9);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun stake<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 16);
        let v0 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3);
        arg0.staked_deep_amount = arg0.staked_deep_amount + v0;
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance_manager, &arg0.deposit_cap, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::stake<T1, T2>(arg2, &mut arg0.balance_manager, &v1, v0, arg4);
        let v2 = DBStakeEvent{
            vault_id           : 0x2::object::id<LotusDBVault<T0>>(arg0),
            pool_id            : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg2),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg0.balance_manager),
            epoch              : 0x2::tx_context::epoch(arg4),
            amount             : v0,
            stake              : true,
        };
        0x2::event::emit<DBStakeEvent>(v2);
    }

    public fun unstake<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 16);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::unstake<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance_manager, arg0.staked_deep_amount, arg3);
        arg0.staked_deep_amount = 0;
        let v2 = DBStakeEvent{
            vault_id           : 0x2::object::id<LotusDBVault<T0>>(arg0),
            pool_id            : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg2),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg0.balance_manager),
            epoch              : 0x2::tx_context::epoch(arg3),
            amount             : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v1),
            stake              : false,
        };
        0x2::event::emit<DBStakeEvent>(v2);
        v1
    }

    public fun withdraw_settled_amounts<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T1, T2>(arg1, &mut arg0.balance_manager, &v0);
    }

    public fun GET_P_ASSET_ACCESS() : u64 {
        2
    }

    public fun GET_P_CREATOR_ACCESS() : u64 {
        16
    }

    public fun GET_P_MASTER_ACCESS() : u64 {
        1
    }

    public fun GET_P_STRATEGY_ACCESS() : u64 {
        4
    }

    public fun GET_P_TRADE_ACCESS() : u64 {
        8
    }

    public fun accrue_management_fee<T0>(arg0: &mut LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg2: &0x2::clock::Clock) {
        accrue_management_fee_internal<T0>(arg0, arg1, arg2);
    }

    fun accrue_management_fee_internal<T0>(arg0: &mut LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg2: &0x2::clock::Clock) {
        if (get_strategy_param_or_default<T0>(arg0, 0x1::string::utf8(b"mgmt_fee_enabled"), 0) == 0) {
            return
        };
        let v0 = 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::get_management_fee_bps(arg1);
        if (v0 == 0) {
            return
        };
        let v1 = 0x1::string::utf8(b"mgmt_fee_last_ts_ms");
        let v2 = get_strategy_param_or_default<T0>(arg0, v1, 0);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        if (v2 == 0) {
            set_strategy_param<T0>(arg0, v1, v3);
            return
        };
        if (v3 <= v2) {
            return
        };
        let v4 = 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc);
        if (v4 == 0) {
            set_strategy_param<T0>(arg0, v1, v3);
            return
        };
        let v5 = (((v4 as u128) * (v0 as u128) * ((v3 - v2) as u128) / 10000 * (0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::consts::GET_MS_PER_YEAR() as u128)) as u64);
        if (v5 == 0) {
            return
        };
        let v6 = @0xfee;
        if (0x2::vec_map::contains<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &v6)) {
            0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::deposit_shares(&mut arg0.incentive_acc, 0x2::vec_map::get_mut<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&mut arg0.user_positions, &v6), v5);
        } else {
            0x2::vec_map::insert<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&mut arg0.user_positions, v6, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::deposit_shares_new(&mut arg0.incentive_acc, v5));
        };
        set_strategy_param<T0>(arg0, v1, v3);
        let v7 = ManagementFeeAccrueEvent{
            vault_id           : 0x2::object::id<LotusDBVault<T0>>(arg0),
            fee_shares         : v5,
            total_shares_after : 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc),
            timestamp_ms       : v3,
        };
        0x2::event::emit<ManagementFeeAccrueEvent>(v7);
    }

    public fun add_to_td_farm<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>, arg2: &0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap, arg3: u32, arg4: &0x2::clock::Clock) {
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::add_member<T1>(arg2, arg1, &mut arg0.farm_key, arg3, arg4);
    }

    public fun admin_distribute_incentive_to_pooling_user_on_purge<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfigCap, arg2: address, arg3: TopUpTicket, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.farm_key;
        destroy_top_up_ticket_with_farm_key(v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::withdraw_all_rewards<T1>(&mut arg0.incentive_acc, 0x2::vec_map::get_mut<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&mut arg0.user_positions, &arg2)), arg4), arg2);
    }

    public fun admin_distribute_incentive_to_pooling_user_on_purge_direct<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfigCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::withdraw_all_rewards<T1>(&mut arg0.incentive_acc, 0x2::vec_map::get_mut<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&mut arg0.user_positions, &arg2)), arg3), arg2);
    }

    public fun admin_distribute_tokens_to_pooling_user_on_purge<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg2: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfigCap, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: address, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::OracleAggregator, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg3);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<T1>(arg8, arg5);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<T2>(arg8, arg6);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8, arg7);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_current_version(arg1);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_protocol_status_ok(arg1);
        accrue_management_fee_internal<T0>(arg0, arg1, arg9);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg10);
        let v1 = 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::position_shares(0x2::vec_map::get<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &arg4));
        let (_, v3) = 0x2::vec_map::remove<address, u64>(&mut arg0.user_cost, &arg4);
        let v4 = (((get_total_usd_value<T0, T1, T2>(arg0, arg3, arg5, arg6, arg7, arg8, arg9) as u128) * (v1 as u128) / (0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc) as u128)) as u64);
        let v5 = (((get_total_balance<T0, T1, T1, T2>(arg0, arg3) as u128) * (v1 as u128) / (0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc) as u128)) as u64);
        let v6 = (((get_total_balance<T0, T2, T1, T2>(arg0, arg3) as u128) * (v1 as u128) / (0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc) as u128)) as u64);
        let v7 = PoolingWithdrawEvent{
            vault_id           : 0x2::object::id<LotusDBVault<T0>>(arg0),
            user_address       : arg4,
            base_amount        : v5,
            quote_amount       : v6,
            deep_amount        : 0,
            user_shares        : v1,
            user_cost          : v3,
            vault_total_shares : 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc),
            if_update_order    : true,
        };
        0x2::event::emit<PoolingWithdrawEvent>(v7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T1, T2>(arg3, &mut arg0.balance_manager, &v0, arg9, arg10);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T1, T2>(arg3, &mut arg0.balance_manager, &v0);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(&mut arg0.balance_manager, &arg0.withdraw_cap, v5, arg10);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, v6, arg10);
        if (v4 > v3) {
            let v10 = 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::get_performance_fee_bps(arg1), (v4 - v3) * 10000, v4);
            let v11 = 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::get_strategy_fee_bps(arg1), (v4 - v3) * 10000, v4);
            if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>()))) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>())), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v8, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T1>(&v8), v10, 100000000), arg10)));
            } else {
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v8, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T1>(&v8), v10, 100000000), arg10)));
            };
            if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>()))) {
                0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>())), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v9, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T2>(&v9), v10, 100000000), arg10)));
            } else {
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>()), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v9, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T2>(&v9), v10, 100000000), arg10)));
            };
            if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_strategy_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>()))) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_strategy_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>())), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v8, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T1>(&v8), v11, 100000000), arg10)));
            } else {
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_strategy_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v8, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T1>(&v8), v11, 100000000), arg10)));
            };
            if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_strategy_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>()))) {
                0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.collected_strategy_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>())), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v9, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T2>(&v9), v11, 100000000), arg10)));
            } else {
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.collected_strategy_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>()), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v9, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T2>(&v9), v11, 100000000), arg10)));
            };
        };
        let (_, v13) = 0x2::vec_map::remove<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&mut arg0.user_positions, &arg4);
        let v14 = v13;
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::withdraw_shares(&mut arg0.incentive_acc, &mut v14, v1);
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::position_destroy_empty(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v9, arg4);
    }

    public fun admin_withdraw_management_fee_shares<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg2: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfigCap, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_lotus_config_cap(arg1, arg2);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_current_version(arg1);
        assert_db_pool<T0, T1, T2>(arg0, arg3);
        accrue_management_fee_internal<T0>(arg0, arg1, arg4);
        let v0 = @0xfee;
        if (!0x2::vec_map::contains<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &v0)) {
            return (0x2::coin::zero<T1>(arg5), 0x2::coin::zero<T2>(arg5))
        };
        let v1 = 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::position_shares(0x2::vec_map::get<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &v0));
        if (v1 == 0) {
            return (0x2::coin::zero<T1>(arg5), 0x2::coin::zero<T2>(arg5))
        };
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg5);
        let v3 = 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc);
        let v4 = (((get_total_balance<T0, T1, T1, T2>(arg0, arg3) as u128) * (v1 as u128) / (v3 as u128)) as u64);
        let v5 = (((get_total_balance<T0, T2, T1, T2>(arg0, arg3) as u128) * (v1 as u128) / (v3 as u128)) as u64);
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager) < v4 || 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(&arg0.balance_manager) < v5) {
            let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T1, T2>(arg3, &arg0.balance_manager);
            let v7 = 0;
            while (v7 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v6)) {
                let v8 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v6, v7);
                let (_, v10, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T1, T2>(arg3);
                let v12 = 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v8) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v8), v3 - v1, v3) / v10 * v10;
                if (v12 < v11) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T1, T2>(arg3, &mut arg0.balance_manager, &v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v8), arg4, arg5);
                } else {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::modify_order<T1, T2>(arg3, &mut arg0.balance_manager, &v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v8), v12 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v8), arg4, arg5);
                };
                v7 = v7 + 1;
            };
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T1, T2>(arg3, &mut arg0.balance_manager, &v2);
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(&mut arg0.balance_manager, &arg0.withdraw_cap, v4, arg5);
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, v5, arg5);
        let (_, v16) = 0x2::vec_map::remove<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&mut arg0.user_positions, &v0);
        let v17 = v16;
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::withdraw_shares(&mut arg0.incentive_acc, &mut v17, v1);
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::position_destroy_empty(v17);
        let v18 = ManagementFeeWithdrawEvent{
            vault_id         : 0x2::object::id<LotusDBVault<T0>>(arg0),
            base_amount      : 0x2::coin::value<T1>(&v13),
            quote_amount     : 0x2::coin::value<T2>(&v14),
            shares_withdrawn : v1,
        };
        0x2::event::emit<ManagementFeeWithdrawEvent>(v18);
        (v13, v14)
    }

    public(friend) fun assert_cold_down<T0>(arg0: &mut LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg2: address, arg3: &0x2::clock::Clock) {
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_current_version(arg1);
        if (0x2::vec_map::contains<address, u64>(&arg0.user_last_interaction, &arg2)) {
            let v0 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.user_last_interaction, &arg2);
            assert!(0x2::clock::timestamp_ms(arg3) - *v0 > 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::get_cold_down_ms(arg1), 2);
            *v0 = 0x2::clock::timestamp_ms(arg3);
        };
    }

    public(friend) fun assert_db_pool<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>) {
        assert!(arg0.allowed_pool == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), 1);
    }

    public(friend) fun assert_valid_strategy_params<T0>(arg0: &LotusDBVault<T0>) {
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"strategy_type")), 7);
        let v0 = 1;
        if (0x2::table::borrow<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"strategy_type")) == &v0) {
            assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"upper")), 7);
            assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"lower")), 7);
            assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"n-levels")), 7);
            assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"size")), 7);
        };
    }

    public(friend) fun assert_vault_cap_access<T0>(arg0: &LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: u64) {
        assert!(0x2::object::id<LotusDBVault<T0>>(arg0) == arg1.vault_id, 0);
        assert!(arg1.access_flag & 1 > 0 || arg1.access_flag & arg2 > 0, 0);
    }

    public fun balance_manager_id<T0>(arg0: &LotusDBVault<T0>) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg0.balance_manager)
    }

    public fun bm_balance<T0, T1>(arg0: &LotusDBVault<T0>) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager)
    }

    public fun buy_deep_fee<T0, T1, T2, T3>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T3>, arg5: u64, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::OracleAggregator, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_current_version(arg2);
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(), 0);
        assert!(0x1::type_name::get<T2>() != 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(), 0);
        assert!(0x1::type_name::get<T3>() == 0x1::type_name::get<T1>() || 0x1::type_name::get<T3>() == 0x1::type_name::get<T2>(), 0);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<T1>(arg9, arg6);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<T2>(arg9, arg7);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9, arg8);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        assert!(get_total_usd_value<T0, T1, T2>(arg0, arg3, arg6, arg7, arg8, arg9, arg10) * 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::get_max_deep_fee_bps(arg2) / 10000 > 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::calc_usd_value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9, arg8, arg5 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance_manager), arg10), 3);
        assert_db_pool<T0, T1, T2>(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T3>(arg4, &mut arg0.balance_manager, &v0, 1000, 0, arg5, true, true, arg10, arg11);
    }

    public fun cancel_all_and_place_limit_order<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: u64, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) {
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_current_version(arg2);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_protocol_status_ok(arg2);
        assert_db_pool<T0, T1, T2>(arg0, arg3);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T1, T2>(arg3, &mut arg0.balance_manager, &v0, arg12, arg13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T1, T2>(arg3, &mut arg0.balance_manager, &v0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun claim_rebates_permissionless<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::claim_rebates<T1, T2>(arg1, &mut arg0.balance_manager, &v0, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T1, T2>(arg1, &mut arg0.balance_manager, &v0);
        let v1 = ClaimRebateEvent{
            vault_id     : 0x2::object::id<LotusDBVault<T0>>(arg0),
            base_amount  : get_total_balance<T0, T1, T1, T2>(arg0, arg1) - get_total_balance<T0, T1, T1, T2>(arg0, arg1),
            quote_amount : get_total_balance<T0, T2, T1, T2>(arg0, arg1) - get_total_balance<T0, T2, T1, T2>(arg0, arg1),
            deep_amount  : get_total_balance<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T1, T2>(arg0, arg1) - get_total_balance<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T1, T2>(arg0, arg1),
        };
        0x2::event::emit<ClaimRebateEvent>(v1);
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut LotusDBVault<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(&mut arg0.balance_manager, &arg0.deposit_cap, arg1, arg2);
    }

    public fun destroy_top_up_ticket<T0>(arg0: &mut LotusDBVault<T0>, arg1: TopUpTicket) {
        let v0 = &mut arg0.farm_key;
        destroy_top_up_ticket_with_farm_key(v0, arg1);
    }

    fun destroy_top_up_ticket_with_farm_key(arg0: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::FarmMemberKey, arg1: TopUpTicket) {
        let TopUpTicket { withdraw_all_ticket: v0 } = arg1;
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::destroy_withdraw_all_ticket(v0, arg0);
    }

    public fun direct_deposit<T0, T1>(arg0: &mut LotusDBVault<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = DirectDepositEvent{
            vault_id     : 0x2::object::id<LotusDBVault<T1>>(arg0),
            user_address : 0x2::tx_context::sender(arg2),
            coin_type    : 0x1::type_name::get<T0>(),
            amount       : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DirectDepositEvent>(v0);
        deposit<T0, T1>(arg0, arg1, arg2);
    }

    public fun disable_management_fee<T0>(arg0: &mut LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg2: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfigCap, arg3: &0x2::clock::Clock) {
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_lotus_config_cap(arg1, arg2);
        accrue_management_fee_internal<T0>(arg0, arg1, arg3);
        set_strategy_param<T0>(arg0, 0x1::string::utf8(b"mgmt_fee_enabled"), 0);
    }

    public fun enable_management_fee<T0>(arg0: &mut LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg2: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfigCap, arg3: &0x2::clock::Clock) {
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_lotus_config_cap(arg1, arg2);
        assert!(get_strategy_param_or_default<T0>(arg0, 0x1::string::utf8(b"mgmt_fee_enabled"), 0) == 0, 13906841325463928831);
        set_strategy_param<T0>(arg0, 0x1::string::utf8(b"mgmt_fee_enabled"), 1);
        set_strategy_param<T0>(arg0, 0x1::string::utf8(b"mgmt_fee_last_ts_ms"), 0x2::clock::timestamp_ms(arg3));
    }

    public fun get_incentive_value<T0, T1>(arg0: &LotusDBVault<T0>) : u64 {
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::balance_value<T1>(&arg0.incentive_acc)
    }

    public fun get_incentive_value_for_user<T0, T1>(arg0: &LotusDBVault<T0>, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &arg1)) {
            0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::position_rewards_value_with_type<T1>(&arg0.incentive_acc, 0x2::vec_map::get<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &arg1))
        } else {
            0
        }
    }

    public fun get_management_fee_last_ts_ms<T0>(arg0: &LotusDBVault<T0>) : u64 {
        get_strategy_param_or_default<T0>(arg0, 0x1::string::utf8(b"mgmt_fee_last_ts_ms"), 0)
    }

    public fun get_management_fee_recipient() : address {
        @0xfee
    }

    public fun get_management_fee_shares<T0>(arg0: &LotusDBVault<T0>) : u64 {
        let v0 = @0xfee;
        if (0x2::vec_map::contains<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &v0)) {
            0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::position_shares(0x2::vec_map::get<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &v0))
        } else {
            0
        }
    }

    public fun get_max_tvl<T0>(arg0: &LotusDBVault<T0>) : u64 {
        let v0 = 0x1::string::utf8(b"max_tvl");
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, v0)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.strategy_params, v0)
        } else {
            18446744073709551615
        }
    }

    public fun get_seq<T0>(arg0: &LotusDBVault<T0>) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"seq"))) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"seq"))
        } else {
            0
        }
    }

    public fun get_shareholder_address_vec<T0>(arg0: &LotusDBVault<T0>) : vector<address> {
        0x2::vec_map::keys<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions)
    }

    fun get_strategy_param_or_default<T0>(arg0: &LotusDBVault<T0>, arg1: 0x1::string::String, arg2: u64) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.strategy_params, arg1)
        } else {
            arg2
        }
    }

    public fun get_strategy_params<T0>(arg0: &LotusDBVault<T0>) {
    }

    public fun get_td_farm_member_key_id<T0>(arg0: &LotusDBVault<T0>) : 0x2::object::ID {
        0x2::object::id<0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::FarmMemberKey>(&arg0.farm_key)
    }

    public fun get_total_balance<T0, T1, T2, T3>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>) : u64 {
        assert_db_pool<T0, T2, T3>(arg0, arg1);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<T2, T3>(arg1, &arg0.balance_manager);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T3>()) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager) + v1
        } else if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager) + v0
        } else if (0x1::type_name::get<T1>() == 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager) + v2
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager)
        }
    }

    public fun get_total_shares<T0>(arg0: &LotusDBVault<T0>) : u64 {
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc)
    }

    public fun get_total_usd_value<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::OracleAggregator, arg6: &0x2::clock::Clock) : u64 {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<T1>(arg5, arg2);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<T2>(arg5, arg3);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5, arg4);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>() || 0x1::type_name::get<T2>() == 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()) {
            0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::calc_usd_value<T1>(arg5, arg2, get_total_balance<T0, T1, T1, T2>(arg0, arg1), arg6) + 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::calc_usd_value<T2>(arg5, arg3, get_total_balance<T0, T2, T1, T2>(arg0, arg1), arg6)
        } else {
            0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::calc_usd_value<T1>(arg5, arg2, get_total_balance<T0, T1, T1, T2>(arg0, arg1), arg6) + 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::calc_usd_value<T2>(arg5, arg3, get_total_balance<T0, T2, T1, T2>(arg0, arg1), arg6) + 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::calc_usd_value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5, arg4, get_total_balance<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T1, T2>(arg0, arg1), arg6)
        }
    }

    public fun get_user_and_total_shares<T0>(arg0: &LotusDBVault<T0>, arg1: address) : (u64, u64) {
        let v0 = if (0x2::vec_map::contains<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &arg1)) {
            0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::position_shares(0x2::vec_map::get<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &arg1))
        } else {
            0
        };
        (v0, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc))
    }

    public fun get_user_cost<T0>(arg0: &LotusDBVault<T0>, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.user_cost, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.user_cost, &arg1)
        } else {
            0
        }
    }

    public fun get_user_last_interaction<T0>(arg0: &LotusDBVault<T0>, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.user_last_interaction, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.user_last_interaction, &arg1)
        } else {
            0
        }
    }

    public fun is_management_fee_enabled<T0>(arg0: &LotusDBVault<T0>) : bool {
        get_strategy_param_or_default<T0>(arg0, 0x1::string::utf8(b"mgmt_fee_enabled"), 0) == 1
    }

    public(friend) fun is_strategy_in_range<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::OracleAggregator, arg5: &0x2::clock::Clock) : bool {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<T1>(arg4, arg2);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<T2>(arg4, arg3);
        assert_valid_strategy_params<T0>(arg0);
        let v0 = 1;
        assert!(0x2::table::borrow<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"strategy_type")) == &v0, 13906842983321305087);
        let (v1, v2, _) = 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::get_price<T1>(arg4, arg2, arg5);
        let (v4, v5, _) = 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::get_price<T2>(arg4, arg3, arg5);
        let v7 = (v1 as u256) * 0x1::u256::pow(10, (((v5 as u8) + 9) as u8) + 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::get_coin_decimal<T2>(arg4)) / (v4 as u256) * 0x1::u256::pow(10, (((v2 as u8) + 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::get_coin_decimal<T1>(arg4)) as u8));
        assert!(v7 < 18446744073709551615, 7);
        ((v7 as u64) > *0x2::table::borrow<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"upper")) || (v7 as u64) < *0x2::table::borrow<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"lower"))) && false || true
    }

    public fun mint_lotus_vault_cap_with_config_cap<T0>(arg0: &LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfigCap, arg2: &mut 0x2::tx_context::TxContext) : LotusDBVaultCap {
        LotusDBVaultCap{
            id          : 0x2::object::new(arg2),
            vault_id    : 0x2::object::id<LotusDBVault<T0>>(arg0),
            access_flag : 1,
        }
    }

    public(friend) fun new_for_pooling<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (LotusDBVault<T0>, LotusDBVaultCap, LotusDBVaultCap) {
        let v0 = new<T0>(arg0, arg3);
        let v1 = LotusDBVaultCap{
            id          : 0x2::object::new(arg3),
            vault_id    : 0x2::object::id<LotusDBVault<T0>>(&v0),
            access_flag : 16,
        };
        let v2 = LotusDBVaultCap{
            id          : 0x2::object::new(arg3),
            vault_id    : 0x2::object::id<LotusDBVault<T0>>(&v0),
            access_flag : 8,
        };
        0x2::vec_map::insert<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&mut v0.user_positions, 0x2::tx_context::sender(arg3), 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::deposit_shares_new(&mut v0.incentive_acc, arg1));
        0x2::vec_map::insert<address, u64>(&mut v0.user_cost, 0x2::tx_context::sender(arg3), arg1);
        (v0, v1, v2)
    }

    public fun new_order_params(arg0: u64, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: u64) : OrderParams {
        OrderParams{
            client_order_id      : arg0,
            order_type           : arg1,
            self_matching_option : arg2,
            price                : arg3,
            quantity             : arg4,
            is_bid               : arg5,
            pay_with_deep        : arg6,
            expire_timestamp     : arg7,
        }
    }

    public fun new_top_up_ticket<T0>(arg0: &mut LotusDBVault<T0>) : TopUpTicket {
        let v0 = &mut arg0.farm_key;
        new_top_up_ticket_with_farm_key(v0)
    }

    fun new_top_up_ticket_with_farm_key(arg0: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::FarmMemberKey) : TopUpTicket {
        TopUpTicket{withdraw_all_ticket: 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::new_withdraw_all_ticket(arg0)}
    }

    public fun place_batch_limit_orders<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: vector<OrderParams>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_current_version(arg2);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_protocol_status_ok(arg2);
        assert_db_pool<T0, T1, T2>(arg0, arg3);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg7);
        if (arg5) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T1, T2>(arg3, &mut arg0.balance_manager, &v0, arg6, arg7);
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<OrderParams>(&arg4)) {
            let v2 = 0x1::vector::borrow<OrderParams>(&arg4, v1);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T1, T2>(arg3, &mut arg0.balance_manager, &v0, v2.client_order_id, v2.order_type, v2.self_matching_option, v2.price, v2.quantity, v2.is_bid, v2.pay_with_deep, v2.expire_timestamp, arg6, arg7);
            v1 = v1 + 1;
        };
        let v3 = BatchLimitOrderEvent{
            vault_id         : 0x2::object::id<LotusDBVault<T0>>(arg0),
            pool_id          : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg3),
            num_orders       : 0x1::vector::length<OrderParams>(&arg4),
            cancel_all_first : arg5,
        };
        0x2::event::emit<BatchLimitOrderEvent>(v3);
    }

    public fun place_batch_limit_orders_pure<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: vector<u64>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<bool>, arg10: vector<bool>, arg11: vector<u64>, arg12: bool, arg13: &0x2::clock::Clock, arg14: &0x2::tx_context::TxContext) {
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_current_version(arg2);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_protocol_status_ok(arg2);
        assert_db_pool<T0, T1, T2>(arg0, arg3);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x1::vector::length<u64>(&arg4);
        assert!(0x1::vector::length<u8>(&arg5) == v0, 7);
        assert!(0x1::vector::length<u8>(&arg6) == v0, 7);
        assert!(0x1::vector::length<u64>(&arg7) == v0, 7);
        assert!(0x1::vector::length<u64>(&arg8) == v0, 7);
        assert!(0x1::vector::length<bool>(&arg9) == v0, 7);
        assert!(0x1::vector::length<bool>(&arg10) == v0, 7);
        assert!(0x1::vector::length<u64>(&arg11) == v0, 7);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg14);
        if (arg12) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T1, T2>(arg3, &mut arg0.balance_manager, &v1, arg13, arg14);
        };
        let v2 = false;
        let v3 = 0;
        while (v3 < v0) {
            if (*0x1::vector::borrow<u8>(&arg5, v3) == 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::consts::GET_ORDER_TYPE_BBO()) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        let (v4, v5) = if (v2) {
            let (v6, _, v8, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T1, T2>(arg3, 1, arg13);
            let v10 = v8;
            let v11 = v6;
            let v12 = if (0x1::vector::length<u64>(&v11) > 0) {
                *0x1::vector::borrow<u64>(&v11, 0)
            } else {
                0
            };
            let v13 = if (0x1::vector::length<u64>(&v10) > 0) {
                *0x1::vector::borrow<u64>(&v10, 0)
            } else {
                0
            };
            (v12, v13)
        } else {
            (0, 0)
        };
        let v14 = 0;
        while (v14 < v0) {
            let (v15, v16) = if (*0x1::vector::borrow<u8>(&arg5, v14) == 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::consts::GET_ORDER_TYPE_BBO()) {
                let v17 = *0x1::vector::borrow<u64>(&arg7, v14);
                let v18 = if (*0x1::vector::borrow<bool>(&arg9, v14)) {
                    if (v4 > 0 && v4 <= v17) {
                        v4
                    } else {
                        v17
                    }
                } else if (v5 > 0 && v5 >= v17) {
                    v5
                } else {
                    v17
                };
                (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), v18)
            } else {
                (*0x1::vector::borrow<u8>(&arg5, v14), *0x1::vector::borrow<u64>(&arg7, v14))
            };
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T1, T2>(arg3, &mut arg0.balance_manager, &v1, *0x1::vector::borrow<u64>(&arg4, v14), v15, *0x1::vector::borrow<u8>(&arg6, v14), v16, *0x1::vector::borrow<u64>(&arg8, v14), *0x1::vector::borrow<bool>(&arg9, v14), *0x1::vector::borrow<bool>(&arg10, v14), *0x1::vector::borrow<u64>(&arg11, v14), arg13, arg14);
            v14 = v14 + 1;
        };
        let v19 = BatchLimitOrderEvent{
            vault_id         : 0x2::object::id<LotusDBVault<T0>>(arg0),
            pool_id          : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg3),
            num_orders       : v0,
            cancel_all_first : arg12,
        };
        0x2::event::emit<BatchLimitOrderEvent>(v19);
    }

    public fun place_batch_limit_orders_pure_seq<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: u64, arg5: vector<u64>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<bool>, arg11: vector<bool>, arg12: vector<u64>, arg13: bool, arg14: &0x2::clock::Clock, arg15: &0x2::tx_context::TxContext) {
        let v0 = if (0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"seq"))) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"seq"))
        } else {
            0
        };
        if (arg4 <= v0) {
            return
        };
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"seq"))) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.strategy_params, 0x1::string::utf8(b"seq")) = arg4;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.strategy_params, 0x1::string::utf8(b"seq"), arg4);
        };
        place_batch_limit_orders_pure<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public fun place_bbo_limit_order<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: u64, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) {
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_current_version(arg2);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_protocol_status_ok(arg2);
        assert_db_pool<T0, T1, T2>(arg0, arg3);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let (v0, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T1, T2>(arg3, 1, arg12);
        let v4 = v2;
        let v5 = v0;
        let v6 = if (arg9) {
            if (0x1::vector::length<u64>(&v5) > 0 && *0x1::vector::borrow<u64>(&v5, 0) <= arg7) {
                *0x1::vector::borrow<u64>(&v5, 0)
            } else {
                arg7
            }
        } else if (0x1::vector::length<u64>(&v4) > 0 && *0x1::vector::borrow<u64>(&v4, 0) >= arg7) {
            *0x1::vector::borrow<u64>(&v4, 0)
        } else {
            arg7
        };
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T1, T2>(arg3, &mut arg0.balance_manager, &v7, arg4, arg5, arg6, v6, arg8, arg9, arg10, arg11, arg12, arg13);
        let v8 = BBOLimitOrderEvent{
            vault_id        : 0x2::object::id<LotusDBVault<T0>>(arg0),
            pool_id         : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg3),
            client_order_id : arg4,
            requested_price : arg7,
            actual_price    : v6,
            quantity        : arg8,
            is_bid          : arg9,
        };
        0x2::event::emit<BBOLimitOrderEvent>(v8);
    }

    public fun pooling_deposit<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::OracleAggregator, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg4);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<T1>(arg8, arg5);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<T2>(arg8, arg6);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8, arg7);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_current_version(arg1);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_protocol_status_ok(arg1);
        assert_cold_down<T0>(arg0, arg1, 0x2::tx_context::sender(arg10), arg9);
        accrue_management_fee_internal<T0>(arg0, arg1, arg9);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = get_total_usd_value<T0, T1, T2>(arg0, arg4, arg5, arg6, arg7, arg8, arg9);
        let v2 = 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::calc_usd_value<T1>(arg8, arg5, 0x2::coin::value<T1>(&arg2), arg9) + 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::calc_usd_value<T2>(arg8, arg6, 0x2::coin::value<T2>(&arg3), arg9);
        assert!(v1 + v2 <= get_max_tvl<T0>(arg0), 12);
        assert!(v2 > 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::get_min_pooling_deposit_value(arg1), 4);
        assert!(v1 > 0, 6);
        let v3 = get_total_balance<T0, T1, T1, T2>(arg0, arg4);
        let v4 = get_total_balance<T0, T2, T1, T2>(arg0, arg4);
        if (v3 == 0) {
            assert!(0x2::coin::value<T1>(&arg2) == 0, 8);
        };
        if (v4 == 0) {
            assert!(0x2::coin::value<T2>(&arg3) == 0, 8);
        };
        if (v3 > 0 && v4 > 0) {
            let v5 = (0x2::coin::value<T1>(&arg2) as u128) * (v4 as u128);
            let v6 = (0x2::coin::value<T2>(&arg3) as u128) * (v3 as u128);
            let v7 = if (v5 > v6) {
                (v5 - v6) * 10000 / v5
            } else {
                (v6 - v5) * 10000 / v6
            };
            assert!(v7 < 18446744073709551615, 9);
            assert!((v7 as u64) < 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::get_max_deposit_token_ratio_diff_bps(arg1), 8);
        };
        let v8 = PoolingDepositEvent{
            vault_id     : 0x2::object::id<LotusDBVault<T0>>(arg0),
            user_address : v0,
            base_amount  : 0x2::coin::value<T1>(&arg2),
            quote_amount : 0x2::coin::value<T2>(&arg3),
            deep_amount  : 0,
        };
        0x2::event::emit<PoolingDepositEvent>(v8);
        let v9 = 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(v2, get_total_shares<T0>(arg0), v1);
        assert!(v9 > 0, 4);
        if (0x2::vec_map::contains<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &v0)) {
            0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::deposit_shares(&mut arg0.incentive_acc, 0x2::vec_map::get_mut<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&mut arg0.user_positions, &v0), v9);
        } else {
            0x2::vec_map::insert<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&mut arg0.user_positions, v0, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::deposit_shares_new(&mut arg0.incentive_acc, v9));
        };
        if (0x2::vec_map::contains<address, u64>(&arg0.user_cost, &v0)) {
            let v10 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.user_cost, &v0);
            *v10 = *v10 + v2;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.user_cost, v0, v2);
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T1>(&mut arg0.balance_manager, &arg0.deposit_cap, arg2, arg10);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T2>(&mut arg0.balance_manager, &arg0.deposit_cap, arg3, arg10);
        update_user_last_interaction<T0>(arg0, 0x2::tx_context::sender(arg10), arg9);
    }

    public fun pooling_redeem_incentive<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: TopUpTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = &mut arg0.farm_key;
        destroy_top_up_ticket_with_farm_key(v0, arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::withdraw_all_rewards<T1>(&mut arg0.incentive_acc, 0x2::vec_map::get_mut<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&mut arg0.user_positions, &v1));
        let v3 = RedeemIncentivesEvent{
            vault_id        : 0x2::object::id<LotusDBVault<T0>>(arg0),
            incentive_type  : 0x1::type_name::get<T1>(),
            incentive_value : 0x2::balance::value<T1>(&v2),
        };
        0x2::event::emit<RedeemIncentivesEvent>(v3);
        0x2::coin::from_balance<T1>(v2, arg2)
    }

    public fun pooling_withdraw<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::OracleAggregator, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<T1>(arg6, arg3);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<T2>(arg6, arg4);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::oracle_ag::assert_price_object_type<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6, arg5);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_current_version(arg1);
        0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::assert_protocol_status_ok(arg1);
        assert_cold_down<T0>(arg0, arg1, 0x2::tx_context::sender(arg8), arg7);
        accrue_management_fee_internal<T0>(arg0, arg1, arg7);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::vec_map::contains<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &v0), 5);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg8);
        let v3 = 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::position_shares(0x2::vec_map::get<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&arg0.user_positions, &v1));
        let (_, v5) = 0x2::vec_map::remove<address, u64>(&mut arg0.user_cost, &v1);
        let v6 = (((get_total_usd_value<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7) as u128) * (v3 as u128) / (0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc) as u128)) as u64);
        let v7 = (((get_total_balance<T0, T1, T1, T2>(arg0, arg2) as u128) * (v3 as u128) / (0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc) as u128)) as u64);
        let v8 = (((get_total_balance<T0, T2, T1, T2>(arg0, arg2) as u128) * (v3 as u128) / (0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc) as u128)) as u64);
        let v9 = false;
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager) < v7 || 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(&arg0.balance_manager) < v8) {
            let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T1, T2>(arg2, &arg0.balance_manager);
            let v11 = 0;
            while (v11 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v10)) {
                let v12 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v10, v11);
                let (_, v14, v15) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T1, T2>(arg2);
                let v16 = 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v12) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v12), get_total_shares<T0>(arg0) - v3, get_total_shares<T0>(arg0)) / v14 * v14;
                if (v16 < v15) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T1, T2>(arg2, &mut arg0.balance_manager, &v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v12), arg7, arg8);
                } else {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::modify_order<T1, T2>(arg2, &mut arg0.balance_manager, &v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v12), v16 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v12), arg7, arg8);
                };
                v11 = v11 + 1;
            };
            v9 = true;
        };
        let v17 = PoolingWithdrawEvent{
            vault_id           : 0x2::object::id<LotusDBVault<T0>>(arg0),
            user_address       : v1,
            base_amount        : v7,
            quote_amount       : v8,
            deep_amount        : 0,
            user_shares        : v3,
            user_cost          : v5,
            vault_total_shares : 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::total_shares(&arg0.incentive_acc),
            if_update_order    : v9,
        };
        0x2::event::emit<PoolingWithdrawEvent>(v17);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T1, T2>(arg2, &mut arg0.balance_manager, &v2);
        let v18 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(&mut arg0.balance_manager, &arg0.withdraw_cap, v7, arg8);
        let v19 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, v8, arg8);
        if (v6 > v5) {
            let v20 = 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::get_performance_fee_bps(arg1), (v6 - v5) * 10000, v6);
            let v21 = 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::get_strategy_fee_bps(arg1), (v6 - v5) * 10000, v6);
            if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>()))) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>())), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v18, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T1>(&v18), v20, 100000000), arg8)));
            } else {
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v18, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T1>(&v18), v20, 100000000), arg8)));
            };
            if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>()))) {
                0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>())), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v19, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T2>(&v19), v20, 100000000), arg8)));
            } else {
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>()), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v19, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T2>(&v19), v20, 100000000), arg8)));
            };
            if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_strategy_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>()))) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_strategy_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>())), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v18, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T1>(&v18), v21, 100000000), arg8)));
            } else {
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_strategy_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v18, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T1>(&v18), v21, 100000000), arg8)));
            };
            if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_strategy_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>()))) {
                0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.collected_strategy_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>())), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v19, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T2>(&v19), v21, 100000000), arg8)));
            } else {
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.collected_strategy_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>()), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v19, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T2>(&v19), v21, 100000000), arg8)));
            };
        };
        if (0x2::clock::timestamp_ms(arg7) < get_user_last_interaction<T0>(arg0, v1) + 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::consts::GET_EARLY_WITHDRAWAL_TIMEOUT()) {
            let v22 = 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::get_early_withdrawal_fee_bps(arg1);
            if (v22 > 0) {
                if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>()))) {
                    0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>())), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v18, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T1>(&v18), v22, 10000), arg8)));
                } else {
                    0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v18, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T1>(&v18), v22, 10000), arg8)));
                };
                if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>()))) {
                    0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>())), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v19, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T2>(&v19), v22, 10000), arg8)));
                } else {
                    0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.collected_performance_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>()), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v19, 0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_math::mul_div_u64(0x2::coin::value<T2>(&v19), v22, 10000), arg8)));
                };
            };
        };
        let (_, v24) = 0x2::vec_map::remove<address, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position>(&mut arg0.user_positions, &v1);
        let v25 = v24;
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::withdraw_shares(&mut arg0.incentive_acc, &mut v25, v3);
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::position_destroy_empty(v25);
        update_user_last_interaction<T0>(arg0, 0x2::tx_context::sender(arg8), arg7);
        (v18, v19)
    }

    public(friend) fun remove_farm_key_from_td_farm<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>, arg2: &0x2::clock::Clock) {
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::top_up<T1>(&mut arg0.incentive_acc, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::remove_member<T1>(arg1, &mut arg0.farm_key, arg2));
    }

    public fun reset_seq<T0>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap) {
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, 0x1::string::utf8(b"seq"))) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.strategy_params, 0x1::string::utf8(b"seq")) = 0;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.strategy_params, 0x1::string::utf8(b"seq"), 0);
        };
    }

    public fun sell_deep_fee<T0, T1, T2, T3>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T3>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(), 0);
        assert!(0x1::type_name::get<T2>() != 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(), 0);
        assert!(0x1::type_name::get<T3>() == 0x1::type_name::get<T1>() || 0x1::type_name::get<T3>() == 0x1::type_name::get<T2>(), 0);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T3>(arg3, &mut arg0.balance_manager, &v0, 1000, 0, arg4, false, true, arg5, arg6);
    }

    public fun set_max_tvl<T0>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: u64) {
        update_strategy_params<T0>(arg0, arg1, 0x1::string::utf8(b"max_tvl"), arg2);
    }

    fun set_strategy_param<T0>(arg0: &mut LotusDBVault<T0>, arg1: 0x1::string::String, arg2: u64) {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, arg1)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.strategy_params, arg1) = arg2;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.strategy_params, arg1, arg2);
        };
    }

    public fun td_pool_top_up<T0, T1>(arg0: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>, arg1: &mut LotusDBVault<T0>, arg2: &mut TopUpTicket, arg3: &0x2::clock::Clock) {
        let v0 = &mut arg1.incentive_acc;
        top_up_with_acc<T1>(arg0, v0, arg2, arg3);
        let v1 = TopUpTDPoolEvent{
            vault_id   : 0x2::object::id<LotusDBVault<T0>>(arg1),
            td_farm_id : 0x2::object::id<0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(arg0),
            coin_type  : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<TopUpTDPoolEvent>(v1);
    }

    fun top_up_with_acc<T0>(arg0: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T0>, arg1: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::AccumulationDistributor, arg2: &mut TopUpTicket, arg3: &0x2::clock::Clock) {
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::top_up<T0>(arg1, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::member_withdraw_all_with_ticket<T0>(arg0, &mut arg2.withdraw_all_ticket, arg3));
    }

    public fun update_strategy_params<T0>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: 0x1::string::String, arg3: u64) {
        assert_vault_cap_access<T0>(arg0, arg1, 16);
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.strategy_params, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.strategy_params, arg2, arg3);
        };
        let v0 = UpdateStrategyParamsEvent{
            vault_id : 0x2::object::id<LotusDBVault<T0>>(arg0),
            key      : arg2,
            value    : arg3,
        };
        0x2::event::emit<UpdateStrategyParamsEvent>(v0);
    }

    public(friend) fun update_user_last_interaction<T0>(arg0: &mut LotusDBVault<T0>, arg1: address, arg2: &0x2::clock::Clock) {
        if (0x2::vec_map::contains<address, u64>(&arg0.user_last_interaction, &arg1)) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.user_last_interaction, &arg1) = 0x2::clock::timestamp_ms(arg2);
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.user_last_interaction, arg1, 0x2::clock::timestamp_ms(arg2));
        };
    }

    public fun withdraw_collected_performance_fees<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &0x36f32a7cf0db611fa9751d351387490bb610bcee3593bc2591615a35a9241952::lotus_config::LotusConfigCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_performance_fees, v0)) {
            0x2::coin::from_balance<T1>(0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_performance_fees, v0), arg2)
        } else {
            0x2::coin::zero<T1>(arg2)
        }
    }

    public fun withdraw_collected_strategy_fees<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault_cap_access<T0>(arg0, arg1, 16);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_strategy_fees, v0)) {
            0x2::coin::from_balance<T1>(0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_strategy_fees, v0), arg2)
        } else {
            0x2::coin::zero<T1>(arg2)
        }
    }

    // decompiled from Move bytecode v6
}

