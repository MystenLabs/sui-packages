module 0xa975de08bff84bf711a711ae95249e0d1358c60c01bafd78f8f251923cf5c774::lotus_db_vault {
    struct LotusDBVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        td_pool: 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::Pool<T0>,
        td_pool_admin_cap: 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::AdminCap,
        stake: 0x1::option::Option<0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::Stake<T0>>,
        allowed_pool: 0x2::object::ID,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
        incentive_balances: 0x2::bag::Bag,
        free_balances: 0x2::bag::Bag,
        performance_fee: u64,
        collected_fees: 0x2::bag::Bag,
    }

    struct LotusDBVaultCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        access_flag: u64,
    }

    struct ActivateBotEvent has copy, drop {
        vault_id: 0x2::object::ID,
        trade_cap_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
    }

    public fun new<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : (LotusDBVault<T0>, LotusDBVaultCap) {
        let (v0, v1) = 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::create<T0>(arg1);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg1);
        let v3 = LotusDBVault<T0>{
            id                 : 0x2::object::new(arg1),
            td_pool            : v0,
            td_pool_admin_cap  : v1,
            stake              : 0x1::option::none<0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::Stake<T0>>(),
            allowed_pool       : arg0,
            balance_manager    : v2,
            trade_cap          : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v2, arg1),
            incentive_balances : 0x2::bag::new(arg1),
            free_balances      : 0x2::bag::new(arg1),
            performance_fee    : 0,
            collected_fees     : 0x2::bag::new(arg1),
        };
        let v4 = LotusDBVaultCap{
            id          : 0x2::object::new(arg1),
            pool_id     : 0x2::object::id<LotusDBVault<T0>>(&v3),
            access_flag : 1,
        };
        (v3, v4)
    }

    public fun deposit<T0, T1>(arg0: &mut LotusDBVault<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
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
        assert_vault_cap_access(arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4);
    }

    public fun cancel_order<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access(arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4, arg5);
    }

    public fun cancel_orders<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: vector<u128>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access(arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_orders<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4, arg5);
    }

    public fun get_account_order_details<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>) : vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order> {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T1, T2>(arg1, &arg0.balance_manager)
    }

    public fun place_limit_order<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access(arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_market_order<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: u64, arg4: u8, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg2);
        assert_vault_cap_access(arg1, 8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg9);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T1, T2>(arg2, &mut arg0.balance_manager, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun withdraw_settled_amounts<T0, T1, T2>(arg0: &mut LotusDBVault<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_db_pool<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T1, T2>(arg1, &mut arg0.balance_manager, &v0);
    }

    public fun add_to_td_farm<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &mut 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::farm::Farm<T1>, arg2: &0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::farm::AdminCap, arg3: u32, arg4: &0x2::clock::Clock) {
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::add_to_farm<T1, T0>(arg2, arg1, &arg0.td_pool_admin_cap, &mut arg0.td_pool, arg3, arg4);
    }

    fun assert_db_pool<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>) {
        assert!(arg0.allowed_pool == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), 1);
    }

    fun assert_vault_cap_access(arg0: &LotusDBVaultCap, arg1: u64) {
        assert!(arg0.access_flag & 1 > 0 || arg0.access_flag & arg1 > 0, 0);
    }

    public fun balance_manager_id<T0>(arg0: &LotusDBVault<T0>) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg0.balance_manager)
    }

    public fun bm_balance<T0, T1>(arg0: &LotusDBVault<T0>) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager)
    }

    public fun collect_incentive_rewards_to_vault<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &mut 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::farm::Farm<T1>, arg2: 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::TopUpTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.incentive_balances, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.incentive_balances, v0), 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::collect_all_rewards<T1, T0>(&mut arg0.td_pool, 0x1::option::borrow_mut<0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::Stake<T0>>(&mut arg0.stake), arg2));
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.incentive_balances, v0, 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::collect_all_rewards<T1, T0>(&mut arg0.td_pool, 0x1::option::borrow_mut<0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::Stake<T0>>(&mut arg0.stake), arg2));
        };
    }

    public fun deposit_shares<T0>(arg0: &mut LotusDBVault<T0>, arg1: &mut 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::Stake<T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::TopUpTicket, arg4: &mut 0x2::tx_context::TxContext) {
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::deposit_shares<T0>(&mut arg0.td_pool, arg1, 0x2::coin::into_balance<T0>(arg2), arg3);
    }

    public fun deposit_shares_new<T0>(arg0: &mut LotusDBVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::TopUpTicket, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::option::fill<0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::Stake<T0>>(&mut arg0.stake, 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::deposit_shares_new<T0>(&mut arg0.td_pool, 0x2::coin::into_balance<T0>(arg1), arg2, arg3));
    }

    public fun get_incentive_value<T0, T1>(arg0: &LotusDBVault<T0>) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.incentive_balances, v0)) {
            0x2::balance::value<T1>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T1>>(&arg0.incentive_balances, v0))
        } else {
            0
        }
    }

    public fun get_stake_value<T0>(arg0: &LotusDBVault<T0>) : u64 {
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::stake_balance<T0>(0x1::option::borrow<0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::Stake<T0>>(&arg0.stake))
    }

    public fun get_td_farm_member_key_id<T0>(arg0: &LotusDBVault<T0>) : 0x2::object::ID {
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::farm_key_id<T0>(&arg0.td_pool)
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

    public fun get_total_usd_value<T0, T1, T2>(arg0: &LotusDBVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xa975de08bff84bf711a711ae95249e0d1358c60c01bafd78f8f251923cf5c774::oracle_ag::OracleAggregator, arg6: &0x2::clock::Clock) : u64 {
        0xa975de08bff84bf711a711ae95249e0d1358c60c01bafd78f8f251923cf5c774::oracle_ag::calc_usd_value<T1>(arg5, arg2, get_total_balance<T0, T1, T1, T2>(arg0, arg1), arg6) + 0xa975de08bff84bf711a711ae95249e0d1358c60c01bafd78f8f251923cf5c774::oracle_ag::calc_usd_value<T2>(arg5, arg3, get_total_balance<T0, T2, T1, T2>(arg0, arg1), arg6) + 0xa975de08bff84bf711a711ae95249e0d1358c60c01bafd78f8f251923cf5c774::oracle_ag::calc_usd_value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5, arg4, get_total_balance<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T1, T2>(arg0, arg1), arg6)
    }

    fun mint_cap<T0>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : LotusDBVaultCap {
        assert_vault_cap_access(arg1, 1);
        assert!(arg2 & 1 == 0, 0);
        LotusDBVaultCap{
            id          : 0x2::object::new(arg3),
            pool_id     : 0x2::object::id<LotusDBVault<T0>>(arg0),
            access_flag : arg2,
        }
    }

    public fun mint_lotus_trade_cap<T0>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2::tx_context::TxContext) : LotusDBVaultCap {
        mint_cap<T0>(arg0, arg1, 8, arg2)
    }

    public fun new_top_up_ticket<T0>(arg0: &mut LotusDBVault<T0>) : 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::TopUpTicket {
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::new_top_up_ticket<T0>(&mut arg0.td_pool)
    }

    public fun redeem_all<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault_cap_access(arg1, 2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(&mut arg0.balance_manager, arg2)
    }

    public fun redeem_incentive<T0, T1>(arg0: &mut LotusDBVault<T0>, arg1: &LotusDBVaultCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault_cap_access(arg1, 2);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.incentive_balances, v0)) {
            0x2::coin::from_balance<T1>(0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.incentive_balances, v0), arg2)
        } else {
            0x2::coin::zero<T1>(arg2)
        }
    }

    public fun td_pool_top_up<T0, T1>(arg0: &mut 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::farm::Farm<T1>, arg1: &mut LotusDBVault<T0>, arg2: &mut 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::TopUpTicket, arg3: &0x2::clock::Clock) {
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::pool::top_up<T1, T0>(arg0, &mut arg1.td_pool, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

