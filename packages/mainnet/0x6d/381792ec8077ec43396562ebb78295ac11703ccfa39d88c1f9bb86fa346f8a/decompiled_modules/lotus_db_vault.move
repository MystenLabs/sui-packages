module 0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::lotus_db_vault {
    struct LotusDBVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        acc: 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::AccumulationDistributor,
        farm_key: 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::FarmMemberKey,
        position: 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::Position,
        allowed_pool: 0x2::object::ID,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
        incentive_balances: 0x2::bag::Bag,
        free_balances: 0x2::bag::Bag,
        collected_fees: 0x2::bag::Bag,
        deposit_cost: u64,
        last_operation_timestamp: u64,
    }

    struct LotusDBVaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        access_flag: u64,
    }

    struct DepositIntoVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    struct RedeemAllFromVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct CollectIncentiveRewardsEvent has copy, drop {
        farm_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        incentive_type: 0x1::type_name::TypeName,
        incentive_value: u64,
    }

    struct TopUpTicket {
        withdraw_all_ticket: 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::MemberWithdrawAllTicket,
    }

    struct ActivateBotEvent has copy, drop {
        vault_id: 0x2::object::ID,
        trade_cap_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
    }

    public fun new<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : (LotusDBVault<T0>, LotusDBVaultCap) {
        let v0 = 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::create(arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg1);
        let v2 = LotusDBVault<T0>{
            id                       : 0x2::object::new(arg1),
            acc                      : v0,
            farm_key                 : 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::create_member_key(arg1),
            position                 : 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::deposit_shares_new(&mut v0, 1),
            allowed_pool             : arg0,
            balance_manager          : v1,
            trade_cap                : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v1, arg1),
            incentive_balances       : 0x2::bag::new(arg1),
            free_balances            : 0x2::bag::new(arg1),
            collected_fees           : 0x2::bag::new(arg1),
            deposit_cost             : 0,
            last_operation_timestamp : 0,
        };
        let v3 = LotusDBVaultCap{
            id          : 0x2::object::new(arg1),
            vault_id    : 0x2::object::id<LotusDBVault<T0>>(&v2),
            access_flag : 1,
        };
        (v2, v3)
    }

    public fun account<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::Account {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T1, T2>(arg1, &arg0.balance_manager)
    }

    public fun deposit<T0, T1>(arg0: &mut LotusDBVault<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositIntoVaultEvent{
            vault_id       : 0x2::object::id<LotusDBVault<T1>>(arg0),
            deposit_type   : 0x1::type_name::get<T0>(),
            deposit_amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DepositIntoVaultEvent>(v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(&mut arg0.balance_manager, arg1, arg2);
    }

    fun mint_trade_cap<T0>(arg0: &mut LotusDBVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        let v0 = ActivateBotEvent{
            vault_id           : 0x2::object::id<LotusDBVault<T0>>(arg0),
            trade_cap_id       : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg0.balance_manager),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg0.balance_manager),
        };
        0x2::event::emit<ActivateBotEvent>(v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut arg0.balance_manager, arg1)
    }

    public fun account_open_orders<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>) : 0x2::vec_set::VecSet<u128> {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T1, T2>(arg1, &arg0.balance_manager)
    }

    public fun cancel_all_orders<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4);
    }

    public fun cancel_order<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4, arg5);
    }

    public fun cancel_orders<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: vector<u128>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_orders<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4, arg5);
    }

    public fun get_account_order_details<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>) : vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order> {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T1, T2>(arg1, &arg0.balance_manager)
    }

    public fun place_limit_order<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_market_order<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: u64, arg4: u8, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg9);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun withdraw_settled_amounts<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T1, T2>(arg1, &mut arg0.balance_manager, &v0);
    }

    public fun add_to_td_farm<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>, arg2: &0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap, arg3: u32, arg4: &0x2::clock::Clock) {
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::add_member<T1>(arg2, arg1, &mut arg0.farm_key, arg3, arg4);
    }

    public fun assert_cold_down<T0>(arg0: &LotusDBVault<T0>, arg1: &0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::lotus_config::LotusConfig, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) - arg0.last_operation_timestamp > 0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::lotus_config::get_cold_down_ms(arg1), 2);
    }

    public fun assert_db_pool<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>) {
        assert!(arg0.allowed_pool == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), 1);
    }

    fun assert_vault_cap_access<T0>(arg0: &LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: u64) {
        assert!(0x2::object::id<LotusDBVault<T0>>(arg0) == arg1.vault_id, 0);
        assert!(arg1.access_flag & 1 > 0 || arg1.access_flag & arg2 > 0, 0);
    }

    public fun balance_manager_id<T0>(arg0: &LotusDBVault<T0>) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg0.balance_manager)
    }

    public fun bm_balance<T0, T1>(arg0: &LotusDBVault<T0>) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager)
    }

    public fun buy_deep_fee<T0, T1, T2, T3>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T3>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(), 0);
        assert!(0x1::type_name::get<T2>() != 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(), 0);
        assert!(0x1::type_name::get<T3>() == 0x1::type_name::get<T1>() || 0x1::type_name::get<T3>() == 0x1::type_name::get<T2>(), 0);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        assert!(arg4 < 0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::consts::GET_MAX_DEEP_FEE_SIZE(), 3);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance_manager) < 0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::consts::GET_MAX_DEEP_FEE_SIZE(), 3);
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T3>(arg3, &mut arg0.balance_manager, &v0, 1000, 0, arg4, true, true, arg5, arg6);
    }

    public fun collect_incentive_rewards_to_vault<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>, arg2: TopUpTicket, arg3: &0x2::clock::Clock) {
        let v0 = &mut arg0.farm_key;
        destroy_top_up_ticket_with_farm_key(v0, arg2);
        let v1 = 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::withdraw_all_rewards<T1>(&mut arg0.acc, &mut arg0.position);
        let v2 = CollectIncentiveRewardsEvent{
            farm_id         : 0x2::object::id<0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(arg1),
            vault_id        : 0x2::object::id<LotusDBVault<T0>>(arg0),
            incentive_type  : 0x1::type_name::get<T1>(),
            incentive_value : 0x2::balance::value<T1>(&v1),
        };
        0x2::event::emit<CollectIncentiveRewardsEvent>(v2);
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.incentive_balances, v3)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.incentive_balances, v3), v1);
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.incentive_balances, v3, v1);
        };
    }

    public fun destroy_top_up_ticket<T0>(arg0: &mut LotusDBVault<T0>, arg1: TopUpTicket) {
        let v0 = &mut arg0.farm_key;
        destroy_top_up_ticket_with_farm_key(v0, arg1);
    }

    fun destroy_top_up_ticket_with_farm_key(arg0: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::FarmMemberKey, arg1: TopUpTicket) {
        let TopUpTicket { withdraw_all_ticket: v0 } = arg1;
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::destroy_withdraw_all_ticket(v0, arg0);
    }

    public fun get_incentive_value<T0, T1>(arg0: &LotusDBVault<T0>) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.incentive_balances, v0)) {
            0x2::balance::value<T1>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T1>>(&arg0.incentive_balances, v0))
        } else {
            0
        }
    }

    public fun get_td_farm_member_key_id<T0>(arg0: &LotusDBVault<T0>) : 0x2::object::ID {
        0x2::object::id<0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::FarmMemberKey>(&arg0.farm_key)
    }

    public fun get_total_balance<T0, T1, T2, T3>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>) : u64 {
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

    public fun get_total_usd_value<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::oracle_ag::OracleAggregator, arg6: &0x2::clock::Clock) : u64 {
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>() || 0x1::type_name::get<T2>() == 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()) {
            0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::oracle_ag::calc_usd_value<T1>(arg5, arg2, get_total_balance<T0, T1, T1, T2>(arg0, arg1), arg6) + 0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::oracle_ag::calc_usd_value<T2>(arg5, arg3, get_total_balance<T0, T2, T1, T2>(arg0, arg1), arg6)
        } else {
            0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::oracle_ag::calc_usd_value<T1>(arg5, arg2, get_total_balance<T0, T1, T1, T2>(arg0, arg1), arg6) + 0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::oracle_ag::calc_usd_value<T2>(arg5, arg3, get_total_balance<T0, T2, T1, T2>(arg0, arg1), arg6) + 0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::oracle_ag::calc_usd_value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5, arg4, get_total_balance<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T1, T2>(arg0, arg1), arg6)
        }
    }

    fun mint_cap<T0>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : LotusDBVaultCap {
        assert_vault_cap_access<T0>(arg0, arg1, 1);
        assert!(arg2 & 1 == 0, 0);
        LotusDBVaultCap{
            id          : 0x2::object::new(arg3),
            vault_id    : 0x2::object::id<LotusDBVault<T0>>(arg0),
            access_flag : arg2,
        }
    }

    public fun mint_lotus_trade_cap<T0>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2::tx_context::TxContext) : LotusDBVaultCap {
        mint_cap<T0>(arg0, arg1, 8, arg2)
    }

    public fun mint_lotus_vault_cap_with_config_cap<T0>(arg0: &mut LotusDBVault<T0>, arg1: &0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::lotus_config::LotusConfigCap, arg2: &mut 0x2::tx_context::TxContext) : LotusDBVaultCap {
        LotusDBVaultCap{
            id          : 0x2::object::new(arg2),
            vault_id    : 0x2::object::id<LotusDBVault<T0>>(arg0),
            access_flag : 1,
        }
    }

    public fun new_for_farm<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (LotusDBVault<T0>, LotusDBVaultCap) {
        let (v0, v1) = new<T0>(arg0, arg3);
        let v2 = v0;
        v2.deposit_cost = arg1;
        v2.last_operation_timestamp = 0x2::clock::timestamp_ms(arg2);
        (v2, v1)
    }

    public fun new_top_up_ticket<T0>(arg0: &mut LotusDBVault<T0>) : TopUpTicket {
        let v0 = &mut arg0.farm_key;
        new_top_up_ticket_with_farm_key(v0)
    }

    fun new_top_up_ticket_with_farm_key(arg0: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::FarmMemberKey) : TopUpTicket {
        TopUpTicket{withdraw_all_ticket: 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::new_withdraw_all_ticket(arg0)}
    }

    public fun redeem_all_token_base_quote<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::lotus_config::LotusConfig, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::oracle_ag::OracleAggregator, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::lotus_config::assert_protocol_status_ok(arg2);
        assert_vault_cap_access<T0>(arg0, arg1, 2);
        0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::oracle_ag::assert_price_object_type<T1>(arg7, arg4);
        0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::oracle_ag::assert_price_object_type<T2>(arg7, arg5);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(&mut arg0.balance_manager, arg9);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T2>(&mut arg0.balance_manager, arg9);
        let v2 = get_total_usd_value<T0, T1, T2>(arg0, arg3, arg4, arg5, arg6, arg7, arg8);
        if (v2 > arg0.deposit_cost) {
            let v3 = 0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::lotus_config::get_performance_fee_bps(arg2) * (v2 - arg0.deposit_cost) / v2;
            let v4 = 0x2::coin::value<T1>(&v0) * v3 / 10000;
            if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>()))) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>())), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v0, v4, arg9)));
            } else {
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_fees, 0x1::type_name::into_string(0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v0, v4, arg9)));
            };
            if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>()))) {
                0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.collected_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>())), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v1, 0x2::coin::value<T2>(&v1) * v3 / 10000, arg9)));
            } else {
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.collected_fees, 0x1::type_name::into_string(0x1::type_name::get<T2>()), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v1, 0x2::coin::value<T2>(&v1) * v3 / 10000, arg9)));
            };
            0x1::debug::print<u64>(&v3);
            0x1::debug::print<u64>(&v4);
        };
        let v5 = 0x2::coin::value<T1>(&v0);
        0x1::debug::print<u64>(&v5);
        let v6 = RedeemAllFromVaultEvent{vault_id: 0x2::object::id<LotusDBVault<T0>>(arg0)};
        0x2::event::emit<RedeemAllFromVaultEvent>(v6);
        (v0, v1)
    }

    public fun redeem_incentive<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault_cap_access<T0>(arg0, arg1, 2);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.incentive_balances, v0)) {
            0x2::coin::from_balance<T1>(0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.incentive_balances, v0), arg2)
        } else {
            0x2::coin::zero<T1>(arg2)
        }
    }

    public fun sell_deep_fee<T0, T1, T2, T3>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T3>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(), 0);
        assert!(0x1::type_name::get<T2>() != 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(), 0);
        assert!(0x1::type_name::get<T3>() == 0x1::type_name::get<T1>() || 0x1::type_name::get<T3>() == 0x1::type_name::get<T2>(), 0);
        assert_vault_cap_access<T0>(arg0, arg1, 8);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance_manager) < 0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::consts::GET_MAX_DEEP_FEE_SIZE(), 3);
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T3>(arg3, &mut arg0.balance_manager, &v0, 1000, 0, arg4, false, true, arg5, arg6);
    }

    public fun td_pool_top_up<T0, T1>(arg0: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>, arg1: &mut LotusDBVault<T0>, arg2: &mut TopUpTicket, arg3: &0x2::clock::Clock) {
        let v0 = &mut arg1.acc;
        top_up_with_acc<T1>(arg0, v0, arg2, arg3);
    }

    fun top_up_with_acc<T0>(arg0: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T0>, arg1: &mut 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::AccumulationDistributor, arg2: &mut TopUpTicket, arg3: &0x2::clock::Clock) {
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::accumulation_distributor::top_up<T0>(arg1, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::member_withdraw_all_with_ticket<T0>(arg0, &mut arg2.withdraw_all_ticket, arg3));
    }

    public fun withdraw_collected_fees<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &0x6d381792ec8077ec43396562ebb78295ac11703ccfa39d88c1f9bb86fa346f8a::lotus_config::LotusConfigCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.collected_fees, v0)) {
            0x2::coin::from_balance<T1>(0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.collected_fees, v0), arg2)
        } else {
            0x2::coin::zero<T1>(arg2)
        }
    }

    // decompiled from Move bytecode v6
}

