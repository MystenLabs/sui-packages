module 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_manager {
    struct MarginManager<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        deepbook_pool: 0x2::object::ID,
        margin_pool_id: 0x1::option::Option<0x2::object::ID>,
        balance_manager: 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::BalanceManager,
        deposit_cap: 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::DepositCap,
        withdraw_cap: 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::WithdrawCap,
        trade_cap: 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::TradeCap,
        base_borrowed_shares: u64,
        quote_borrowed_shares: u64,
        active_liquidation: bool,
    }

    struct Request {
        margin_manager_id: 0x2::object::ID,
        request_type: u8,
    }

    struct ManagerInitializer {
        margin_manager_id: 0x2::object::ID,
    }

    struct MarginManagerEvent has copy, drop {
        margin_manager_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct LoanBorrowedEvent has copy, drop {
        margin_manager_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        loan_amount: u64,
        loan_shares: u64,
        timestamp: u64,
    }

    struct LoanRepaidEvent has copy, drop {
        margin_manager_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        repay_amount: u64,
        repay_shares: u64,
        timestamp: u64,
    }

    struct LiquidationEvent has copy, drop {
        margin_manager_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        liquidation_amount: u64,
        pool_reward_amount: u64,
        default_amount: u64,
        risk_ratio: u64,
        timestamp: u64,
    }

    fun borrow<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Request {
        let v0 = id<T0, T1>(arg0);
        let v1 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::borrow<T2>(arg2, arg3, arg4, arg5);
        deposit<T0, T1, T2>(arg0, arg1, v1, arg5);
        Request{
            margin_manager_id : v0,
            request_type      : 1,
        }
    }

    public(friend) fun id<T0, T1>(arg0: &MarginManager<T0, T1>) : 0x2::object::ID {
        0x2::object::id<MarginManager<T0, T1>>(arg0)
    }

    public fun new<T0, T1>(arg0: &0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MarginManager<T0, T1>>(new_margin_manager<T0, T1>(arg0, arg1, arg2, arg3));
    }

    public(friend) fun balance_manager<T0, T1>(arg0: &MarginManager<T0, T1>) : &0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::BalanceManager {
        &arg0.balance_manager
    }

    public fun set_referral<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::DeepBookReferral, arg2: &mut 0x2::tx_context::TxContext) {
        validate_owner<T0, T1>(arg0, arg2);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::set_referral(&mut arg0.balance_manager, arg1, &arg0.trade_cap);
    }

    public fun unset_referral<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        validate_owner<T0, T1>(arg0, arg1);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::unset_referral(&mut arg0.balance_manager, &arg0.trade_cap);
    }

    public fun manager_info<T0, T1, T2>(arg0: &MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T2>, arg3: &0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: 0x2::object::ID) : 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::ManagerInfo {
        let v0 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T2>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0), 13);
        assert!(arg0.deepbook_pool == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg3), 5);
        let (v1, v2) = calculate_debts<T0, T1, T2>(arg0, arg2);
        let (v3, v4) = calculate_assets<T0, T1>(arg0, arg3);
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::new_manager_info<T0, T1>(v3, v4, v1, v2, arg1, arg4, arg5, arg6, arg7)
    }

    public(friend) fun balance_manager_mut<T0, T1>(arg0: &mut MarginManager<T0, T1>) : &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::BalanceManager {
        &mut arg0.balance_manager
    }

    public(friend) fun balance_manager_trading_mut<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0x2::tx_context::TxContext) : &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::BalanceManager {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 3);
        &mut arg0.balance_manager
    }

    public(friend) fun base_borrowed_shares<T0, T1>(arg0: &MarginManager<T0, T1>) : u64 {
        arg0.base_borrowed_shares
    }

    public fun borrow_base<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Request {
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg5);
        assert!(can_borrow<T0, T1, T0>(arg0, arg2), 4);
        assert!(0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::deepbook_pool_allowed<T0>(arg2, arg0.deepbook_pool), 6);
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::update_state<T0>(arg2, arg4);
        let v0 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::to_borrow_shares<T0>(arg2, arg3);
        increase_borrowed_shares<T0, T1>(arg0, true, v0);
        arg0.margin_pool_id = 0x1::option::some<0x2::object::ID>(0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T0>(arg2));
        let v1 = LoanBorrowedEvent{
            margin_manager_id : id<T0, T1>(arg0),
            margin_pool_id    : 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T0>(arg2),
            loan_amount       : arg3,
            loan_shares       : v0,
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LoanBorrowedEvent>(v1);
        borrow<T0, T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun borrow_quote<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Request {
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg5);
        assert!(can_borrow<T0, T1, T1>(arg0, arg2), 4);
        assert!(0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::deepbook_pool_allowed<T1>(arg2, arg0.deepbook_pool), 6);
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::update_state<T1>(arg2, arg4);
        let v0 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::to_borrow_shares<T1>(arg2, arg3);
        increase_borrowed_shares<T0, T1>(arg0, false, v0);
        arg0.margin_pool_id = 0x1::option::some<0x2::object::ID>(0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T1>(arg2));
        let v1 = LoanBorrowedEvent{
            margin_manager_id : id<T0, T1>(arg0),
            margin_pool_id    : 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T1>(arg2),
            loan_amount       : arg3,
            loan_shares       : v0,
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LoanBorrowedEvent>(v1);
        borrow<T0, T1, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun calculate_assets<T0, T1>(arg0: &MarginManager<T0, T1>, arg1: &0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>) : (u64, u64) {
        let v0 = balance_manager<T0, T1>(arg0);
        let (v1, v2, _) = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::locked_balance<T0, T1>(arg1, v0);
        (v1 + 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::balance<T0>(v0), v2 + 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::balance<T1>(v0))
    }

    public fun calculate_debts<T0, T1, T2>(arg0: &MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T2>) : (u64, u64) {
        let v0 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T2>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0), 13);
        let v1 = has_base_debt<T0, T1>(arg0);
        let v2 = if (v1) {
            arg0.base_borrowed_shares
        } else {
            arg0.quote_borrowed_shares
        };
        let v3 = if (v1) {
            assert!(0x1::type_name::with_defining_ids<T2>() == 0x1::type_name::with_defining_ids<T0>(), 10);
            0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::to_borrow_amount<T2>(arg1, v2)
        } else {
            0
        };
        let v4 = if (v1) {
            0
        } else {
            assert!(0x1::type_name::with_defining_ids<T2>() == 0x1::type_name::with_defining_ids<T1>(), 10);
            0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::to_borrow_amount<T2>(arg1, v2)
        };
        (v3, v4)
    }

    fun can_borrow<T0, T1, T2>(arg0: &MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T2>) : bool {
        let v0 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T2>(arg1);
        0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0) || 0x1::option::is_none<0x2::object::ID>(&arg0.margin_pool_id)
    }

    fun decrease_borrowed_shares<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: bool, arg2: u64) {
        if (arg1) {
            arg0.base_borrowed_shares = arg0.base_borrowed_shares - arg2;
        } else {
            arg0.quote_borrowed_shares = arg0.quote_borrowed_shares - arg2;
        };
    }

    public fun deepbook_pool<T0, T1>(arg0: &MarginManager<T0, T1>) : 0x2::object::ID {
        arg0.deepbook_pool
    }

    public fun deposit<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg3);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = if (v0 == 0x1::type_name::with_defining_ids<T0>()) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<T1>()) {
            true
        } else {
            v0 == 0x1::type_name::with_defining_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()
        };
        assert!(v1, 1);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::deposit_with_cap<T2>(&mut arg0.balance_manager, &arg0.deposit_cap, arg2, arg3);
    }

    fun has_base_debt<T0, T1>(arg0: &MarginManager<T0, T1>) : bool {
        arg0.base_borrowed_shares > 0
    }

    fun increase_borrowed_shares<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: bool, arg2: u64) {
        if (arg1) {
            arg0.base_borrowed_shares = arg0.base_borrowed_shares + arg2;
        } else {
            arg0.quote_borrowed_shares = arg0.quote_borrowed_shares + arg2;
        };
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T2>, arg5: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::Fulfillment, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg5);
        let v1 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T2>(arg4);
        assert!(arg0.deepbook_pool == v0, 5);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v1), 13);
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::update_state<T2>(arg4, arg6);
        let v2 = manager_info<T0, T1, T2>(arg0, arg1, arg4, arg5, arg2, arg3, arg6, v0);
        assert!(0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::can_liquidate(arg1, v0, 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::risk_ratio(&v2)), 11);
        assert!(!arg0.active_liquidation, 11);
        arg0.active_liquidation = true;
        let v3 = trade_proof<T0, T1>(arg0, arg7);
        let v4 = balance_manager_mut<T0, T1>(arg0);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::cancel_all_orders<T0, T1>(arg5, v4, &v3, arg6, arg7);
        let v5 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::produce_fulfillment(&v2, id<T0, T1>(arg0));
        let v6 = liquidation_withdraw_base<T0, T1>(arg0, 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::base_exit_amount(&v5), arg7);
        (v5, v6, liquidation_withdraw_quote<T0, T1>(arg0, 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::quote_exit_amount(&v5), arg7))
    }

    public fun liquidate_base_loan<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T0>, arg3: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = liquidate_loan<T0, T1, T0>(arg0, arg1, arg4, arg5, arg2, arg3, arg6, arg7, arg8);
        let v3 = v0;
        0x2::coin::join<T0>(&mut v3, v2);
        (v3, v1)
    }

    public fun liquidate_loan<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T2>, arg5: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let (v0, v1, v2) = liquidate<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        repay_liquidation_int<T0, T1, T2>(arg0, arg1, arg4, arg6, v1, v2, v0, arg7, arg8)
    }

    public fun liquidate_quote_loan<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T1>, arg3: &mut 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = liquidate_loan<T0, T1, T1>(arg0, arg1, arg4, arg5, arg2, arg3, arg6, arg7, arg8);
        let v3 = v1;
        0x2::coin::join<T1>(&mut v3, v2);
        (v0, v3)
    }

    fun liquidation_deposit<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::tx_context::TxContext) {
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::deposit_with_cap<T2>(&mut arg0.balance_manager, &arg0.deposit_cap, arg1, arg2);
    }

    fun liquidation_deposit_base<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        liquidation_deposit<T0, T1, T0>(arg0, arg1, arg2);
    }

    fun liquidation_deposit_quote<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        liquidation_deposit<T0, T1, T1>(arg0, arg1, arg2);
    }

    fun liquidation_withdraw<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg1, arg2)
    }

    fun liquidation_withdraw_base<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        liquidation_withdraw<T0, T1, T0>(arg0, arg1, arg2)
    }

    fun liquidation_withdraw_quote<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        liquidation_withdraw<T0, T1, T1>(arg0, arg1, arg2)
    }

    fun new_margin_manager<T0, T1>(arg0: &0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : MarginManager<T0, T1> {
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::load_inner(arg1);
        assert!(0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::pool_enabled<T0, T1>(arg1, arg0), 2);
        let v0 = 0x2::object::new(arg3);
        let (v1, v2, v3, v4) = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::new_with_custom_owner_and_caps(0x2::object::uid_to_address(&v0), arg3);
        let v5 = v1;
        let v6 = MarginManagerEvent{
            margin_manager_id  : 0x2::object::uid_to_inner(&v0),
            balance_manager_id : 0x2::object::id<0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::BalanceManager>(&v5),
            owner              : 0x2::tx_context::sender(arg3),
            timestamp          : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MarginManagerEvent>(v6);
        MarginManager<T0, T1>{
            id                    : v0,
            owner                 : 0x2::tx_context::sender(arg3),
            deepbook_pool         : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg0),
            margin_pool_id        : 0x1::option::none<0x2::object::ID>(),
            balance_manager       : v5,
            deposit_cap           : v2,
            withdraw_cap          : v3,
            trade_cap             : v4,
            base_borrowed_shares  : 0,
            quote_borrowed_shares : 0,
            active_liquidation    : false,
        }
    }

    public fun new_with_initializer<T0, T1>(arg0: &0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (MarginManager<T0, T1>, ManagerInitializer) {
        let v0 = new_margin_manager<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = ManagerInitializer{margin_manager_id: id<T0, T1>(&v0)};
        (v0, v1)
    }

    public fun prove_and_destroy_request<T0, T1, T2>(arg0: &MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T2>, arg3: &0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::Pool<T0, T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: Request) {
        let v0 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T2>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0), 13);
        assert!(arg7.margin_manager_id == id<T0, T1>(arg0), 7);
        assert!(arg0.deepbook_pool == 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg3), 5);
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::update_state<T2>(arg2, arg6);
        let v1 = manager_info<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg3));
        if (arg7.request_type == 1) {
            assert!(0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::can_borrow(arg1, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg3), 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::risk_ratio(&v1)), 8);
        } else if (arg7.request_type == 0) {
            assert!(0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::can_withdraw(arg1, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::pool::id<T0, T1>(arg3), 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::risk_ratio(&v1)), 9);
        };
        let Request {
            margin_manager_id : _,
            request_type      : _,
        } = arg7;
    }

    public(friend) fun quote_borrowed_shares<T0, T1>(arg0: &MarginManager<T0, T1>) : u64 {
        arg0.quote_borrowed_shares
    }

    fun repay<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T2>, arg2: 0x1::option::Option<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::update_state<T2>(arg1, arg3);
        let v0 = has_base_debt<T0, T1>(arg0);
        let v1 = if (0x1::option::is_some<u64>(&arg2)) {
            0x1::option::destroy_some<u64>(arg2)
        } else if (v0) {
            0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::to_borrow_amount<T2>(arg1, arg0.base_borrowed_shares)
        } else {
            0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::to_borrow_amount<T2>(arg1, arg0.quote_borrowed_shares)
        };
        let v2 = 0x1::u64::min(v1, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::balance<T2>(balance_manager<T0, T1>(arg0)));
        let v3 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::to_borrow_shares<T2>(arg1, v2);
        decrease_borrowed_shares<T0, T1>(arg0, v0, v3);
        reset_margin_pool_id<T0, T1>(arg0);
        let v4 = repay_withdraw<T0, T1, T2>(arg0, v2, arg4);
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::repay<T2>(arg1, v4, arg3);
        let v5 = LoanRepaidEvent{
            margin_manager_id : id<T0, T1>(arg0),
            margin_pool_id    : 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T2>(arg1),
            repay_amount      : v2,
            repay_shares      : v3,
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LoanRepaidEvent>(v5);
        v2
    }

    public fun repay_base<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T0>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg5);
        let v0 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T0>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0), 13);
        repay<T0, T1, T0>(arg0, arg2, arg3, arg4, arg5)
    }

    public fun repay_liquidation<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T2>, arg3: 0x2::coin::Coin<T2>, arg4: 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::Fulfillment, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::coin::value<T2>(&arg3) >= 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::repay_amount(&arg4) + 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::pool_reward_amount(&arg4), 12);
        let v0 = 0x2::coin::zero<T0>(arg6);
        let v1 = 0x2::coin::zero<T1>(arg6);
        let (v2, v3, v4) = repay_liquidation_int<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, v1, arg4, arg5, arg6);
        0x2::coin::destroy_zero<T0>(v2);
        0x2::coin::destroy_zero<T1>(v3);
        v4
    }

    fun repay_liquidation_int<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T2>, arg3: 0x2::coin::Coin<T2>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::Fulfillment, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::load_inner(arg1);
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::update_state<T2>(arg2, arg7);
        assert!(0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::manager_id(&arg6) == id<T0, T1>(arg0), 7);
        assert!(arg0.active_liquidation, 11);
        arg0.active_liquidation = false;
        let v0 = id<T0, T1>(arg0);
        let v1 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T2>(arg2);
        let v2 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::update_fulfillment(&mut arg6, 0x2::coin::value<T2>(&arg3));
        let v3 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::repay_amount(&arg6);
        let v4 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::pool_reward_amount(&arg6);
        let v5 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::default_amount(&arg6);
        let v6 = has_base_debt<T0, T1>(arg0);
        let v7 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::to_borrow_shares<T2>(arg2, v3);
        decrease_borrowed_shares<T0, T1>(arg0, v6, v7);
        decrease_borrowed_shares<T0, T1>(arg0, v6, 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::to_borrow_shares<T2>(arg2, 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::default_amount(&arg6)));
        reset_margin_pool_id<T0, T1>(arg0);
        let v8 = 0x1::u64::min(v4, v5);
        let v9 = v4 - v8;
        let v10 = v5 - v8;
        let v11 = 0x2::clock::timestamp_ms(arg7);
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::repay_with_reward<T2>(arg2, 0x2::coin::split<T2>(&mut arg3, v3 + v4, arg8), v3, v9, v10, arg7);
        if (v2 > 0) {
            let (v12, v13) = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::calculate_return_amounts(v2, 0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&arg5));
            liquidation_deposit_base<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg4, v12, arg8), arg8);
            liquidation_deposit_quote<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg5, v13, arg8), arg8);
        };
        let v14 = LoanRepaidEvent{
            margin_manager_id : v0,
            margin_pool_id    : v1,
            repay_amount      : v3,
            repay_shares      : v7,
            timestamp         : v11,
        };
        0x2::event::emit<LoanRepaidEvent>(v14);
        let v15 = LiquidationEvent{
            margin_manager_id  : v0,
            margin_pool_id     : v1,
            liquidation_amount : v3,
            pool_reward_amount : v9,
            default_amount     : v10,
            risk_ratio         : 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::fulfillment_risk_ratio(&arg6),
            timestamp          : v11,
        };
        0x2::event::emit<LiquidationEvent>(v15);
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::manager_info::drop(arg6);
        (arg4, arg5, arg3)
    }

    public fun repay_quote<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: &mut 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::MarginPool<T1>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg5);
        let v0 = 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_pool::id<T1>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0), 13);
        repay<T0, T1, T1>(arg0, arg2, arg3, arg4, arg5)
    }

    fun repay_withdraw<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        validate_owner<T0, T1>(arg0, arg2);
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg1, arg2)
    }

    fun reset_margin_pool_id<T0, T1>(arg0: &mut MarginManager<T0, T1>) {
        if (arg0.base_borrowed_shares == 0 && arg0.quote_borrowed_shares == 0) {
            arg0.margin_pool_id = 0x1::option::none<0x2::object::ID>();
        };
    }

    public fun share<T0, T1>(arg0: MarginManager<T0, T1>, arg1: ManagerInitializer) {
        assert!(id<T0, T1>(&arg0) == arg1.margin_manager_id, 14);
        0x2::transfer::share_object<MarginManager<T0, T1>>(arg0);
        let ManagerInitializer {  } = arg1;
    }

    public(friend) fun trade_proof<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0x2::tx_context::TxContext) : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::TradeProof {
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg1)
    }

    fun validate_owner<T0, T1>(arg0: &MarginManager<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::MarginRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, Request) {
        0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg3);
        let v0 = Request{
            margin_manager_id : id<T0, T1>(arg0),
            request_type      : 0,
        };
        (0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg2, arg3), v0)
    }

    // decompiled from Move bytecode v6
}

