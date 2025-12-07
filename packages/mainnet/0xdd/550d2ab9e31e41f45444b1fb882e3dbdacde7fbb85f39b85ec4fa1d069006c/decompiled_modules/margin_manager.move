module 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_manager {
    struct MarginApp has drop {
        dummy_field: bool,
    }

    struct MarginManager<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        deepbook_pool: 0x2::object::ID,
        margin_pool_id: 0x1::option::Option<0x2::object::ID>,
        balance_manager: 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::BalanceManager,
        deposit_cap: 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::DepositCap,
        withdraw_cap: 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::WithdrawCap,
        trade_cap: 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::TradeCap,
        borrowed_base_shares: u64,
        borrowed_quote_shares: u64,
        take_profit_stop_loss: 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::TakeProfitStopLoss,
        extra_fields: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct ManagerInitializer {
        margin_manager_id: 0x2::object::ID,
    }

    struct MarginManagerCreatedEvent has copy, drop {
        margin_manager_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        deepbook_pool_id: 0x2::object::ID,
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
        pool_reward: u64,
        pool_default: u64,
        risk_ratio: u64,
        remaining_base_asset: u64,
        remaining_quote_asset: u64,
        remaining_base_debt: u64,
        remaining_quote_debt: u64,
        base_pyth_price: u64,
        base_pyth_decimals: u8,
        quote_pyth_price: u64,
        quote_pyth_decimals: u8,
        timestamp: u64,
    }

    struct DepositCollateralEvent has copy, drop {
        margin_manager_id: 0x2::object::ID,
        amount: u64,
        asset: 0x1::type_name::TypeName,
        pyth_price: u64,
        pyth_decimals: u8,
        timestamp: u64,
    }

    struct WithdrawCollateralEvent has copy, drop {
        margin_manager_id: 0x2::object::ID,
        amount: u64,
        asset: 0x1::type_name::TypeName,
        withdraw_base_asset: bool,
        remaining_base_asset: u64,
        remaining_quote_asset: u64,
        remaining_base_debt: u64,
        remaining_quote_debt: u64,
        base_pyth_price: u64,
        base_pyth_decimals: u8,
        quote_pyth_price: u64,
        quote_pyth_decimals: u8,
        timestamp: u64,
    }

    public fun new<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::registry::Registry, arg2: &mut 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_margin_manager<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::share_object<MarginManager<T0, T1>>(v0);
        id<T0, T1>(&v0)
    }

    public fun add_conditional_order<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg5: u64, arg6: 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::Condition, arg7: 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::PendingOrder, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        validate_owner<T0, T1>(arg0, arg9);
        assert!(0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg1) == deepbook_pool<T0, T1>(arg0), 5);
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::add_conditional_order<T0, T1>(&mut arg0.take_profit_stop_loss, arg1, id<T0, T1>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun assets_in_debt_unit<T0, T1>(arg0: &MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = calculate_assets<T0, T1>(arg0, arg2);
        if (0x1::option::is_none<0x2::object::ID>(&arg0.margin_pool_id)) {
            return (0, v0, v1)
        };
        let v2 = if (arg0.borrowed_base_shares > 0) {
            0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::oracle::calculate_target_currency<T1, T0>(arg1, arg4, arg3, v1, arg5) + v0
        } else {
            0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::oracle::calculate_target_currency<T0, T1>(arg1, arg3, arg4, v0, arg5) + v1
        };
        (v2, v0, v1)
    }

    public fun balance_manager<T0, T1>(arg0: &MarginManager<T0, T1>) : &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::BalanceManager {
        &arg0.balance_manager
    }

    public(friend) fun balance_manager_trading_mut<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0x2::tx_context::TxContext) : &mut 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::BalanceManager {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 3);
        &mut arg0.balance_manager
    }

    fun balance_manager_unsafe_mut<T0, T1>(arg0: &mut MarginManager<T0, T1>) : &mut 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::BalanceManager {
        &mut arg0.balance_manager
    }

    public fun base_balance<T0, T1>(arg0: &MarginManager<T0, T1>) : u64 {
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::balance<T0>(&arg0.balance_manager)
    }

    public fun borrow_base<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &mut 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T0>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg8);
        assert!(can_borrow<T0, T1, T0>(arg0, arg2), 4);
        assert!(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::deepbook_pool_allowed<T0>(arg2, arg0.deepbook_pool), 6);
        let (v0, v1) = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::borrow<T0>(arg2, arg6, arg7, arg8);
        arg0.borrowed_base_shares = arg0.borrowed_base_shares + v1;
        arg0.margin_pool_id = 0x1::option::some<0x2::object::ID>(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T0>(arg2));
        deposit_int<T0, T1, T0>(arg0, v0, arg8);
        assert!(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::can_borrow(arg1, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg5), risk_ratio_int<T0, T1, T0>(arg0, arg1, arg3, arg4, arg5, arg2, arg7)), 7);
        let v2 = LoanBorrowedEvent{
            margin_manager_id : id<T0, T1>(arg0),
            margin_pool_id    : 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T0>(arg2),
            loan_amount       : arg6,
            loan_shares       : v1,
            timestamp         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<LoanBorrowedEvent>(v2);
    }

    public fun borrow_quote<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &mut 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg8);
        assert!(can_borrow<T0, T1, T1>(arg0, arg2), 4);
        assert!(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::deepbook_pool_allowed<T1>(arg2, arg0.deepbook_pool), 6);
        let (v0, v1) = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::borrow<T1>(arg2, arg6, arg7, arg8);
        arg0.borrowed_quote_shares = arg0.borrowed_quote_shares + v1;
        arg0.margin_pool_id = 0x1::option::some<0x2::object::ID>(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T1>(arg2));
        deposit_int<T0, T1, T1>(arg0, v0, arg8);
        assert!(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::can_borrow(arg1, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg5), risk_ratio_int<T0, T1, T1>(arg0, arg1, arg3, arg4, arg5, arg2, arg7)), 7);
        let v2 = LoanBorrowedEvent{
            margin_manager_id : id<T0, T1>(arg0),
            margin_pool_id    : 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T1>(arg2),
            loan_amount       : arg6,
            loan_shares       : v1,
            timestamp         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<LoanBorrowedEvent>(v2);
    }

    public fun borrowed_base_shares<T0, T1>(arg0: &MarginManager<T0, T1>) : u64 {
        arg0.borrowed_base_shares
    }

    public fun borrowed_quote_shares<T0, T1>(arg0: &MarginManager<T0, T1>) : u64 {
        arg0.borrowed_quote_shares
    }

    public fun borrowed_shares<T0, T1>(arg0: &MarginManager<T0, T1>) : (u64, u64) {
        (arg0.borrowed_base_shares, arg0.borrowed_quote_shares)
    }

    public fun calculate_assets<T0, T1>(arg0: &MarginManager<T0, T1>, arg1: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>) : (u64, u64) {
        let v0 = balance_manager<T0, T1>(arg0);
        let (v1, v2, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::locked_balance<T0, T1>(arg1, v0);
        (v1 + 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::balance<T0>(v0), v2 + 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::balance<T1>(v0))
    }

    public fun calculate_debts<T0, T1, T2>(arg0: &MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T2>, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T2>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0), 10);
        let v1 = has_base_debt<T0, T1>(arg0);
        let v2 = if (v1) {
            arg0.borrowed_base_shares
        } else {
            arg0.borrowed_quote_shares
        };
        let v3 = if (v1) {
            assert!(0x1::type_name::with_defining_ids<T2>() == 0x1::type_name::with_defining_ids<T0>(), 12);
            0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::borrow_shares_to_amount<T2>(arg1, v2, arg2)
        } else {
            0
        };
        let v4 = if (v1) {
            0
        } else {
            assert!(0x1::type_name::with_defining_ids<T2>() == 0x1::type_name::with_defining_ids<T1>(), 12);
            0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::borrow_shares_to_amount<T2>(arg1, v2, arg2)
        };
        (v3, v4)
    }

    fun can_borrow<T0, T1, T2>(arg0: &MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T2>) : bool {
        let v0 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T2>(arg1);
        0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0) || 0x1::option::is_none<0x2::object::ID>(&arg0.margin_pool_id)
    }

    public fun cancel_all_conditional_orders<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        validate_owner<T0, T1>(arg0, arg2);
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::cancel_all_conditional_orders(&mut arg0.take_profit_stop_loss, id<T0, T1>(arg0), arg1);
    }

    public fun cancel_conditional_order<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        validate_owner<T0, T1>(arg0, arg3);
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::cancel_conditional_order(&mut arg0.take_profit_stop_loss, id<T0, T1>(arg0), arg1, arg2);
    }

    public fun conditional_order<T0, T1>(arg0: &MarginManager<T0, T1>, arg1: u64) : 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder {
        let v0 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::get_conditional_order(&arg0.take_profit_stop_loss, arg1);
        assert!(0x1::option::is_some<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(&v0), 16);
        0x1::option::destroy_some<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(v0)
    }

    public fun conditional_order_ids<T0, T1>(arg0: &MarginManager<T0, T1>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::trigger_below_orders(&arg0.take_profit_stop_loss);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(v1)) {
            0x1::vector::push_back<u64>(&mut v0, 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::conditional_order_id(0x1::vector::borrow<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(v1, v2)));
            v2 = v2 + 1;
        };
        let v3 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::trigger_above_orders(&arg0.take_profit_stop_loss);
        v2 = 0;
        while (v2 < 0x1::vector::length<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(v3)) {
            0x1::vector::push_back<u64>(&mut v0, 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::conditional_order_id(0x1::vector::borrow<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(v3, v2)));
            v2 = v2 + 1;
        };
        v0
    }

    public fun deep_balance<T0, T1>(arg0: &MarginManager<T0, T1>) : u64 {
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance_manager)
    }

    public fun deepbook_pool<T0, T1>(arg0: &MarginManager<T0, T1>) : 0x2::object::ID {
        arg0.deepbook_pool
    }

    public fun deposit<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg6);
        deposit_int<T0, T1, T2>(arg0, arg4, arg6);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = v0 == 0x1::type_name::with_defining_ids<T0>();
        if (!v1 && !(v0 == 0x1::type_name::with_defining_ids<T1>())) {
            return
        };
        let (v2, v3) = if (v1) {
            0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::oracle::get_pyth_price<T0>(arg2, arg1, arg5)
        } else {
            0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::oracle::get_pyth_price<T1>(arg3, arg1, arg5)
        };
        let v4 = DepositCollateralEvent{
            margin_manager_id : id<T0, T1>(arg0),
            amount            : 0x2::coin::value<T2>(&arg4),
            asset             : v0,
            pyth_price        : v2,
            pyth_decimals     : v3,
            timestamp         : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<DepositCollateralEvent>(v4);
    }

    public(friend) fun deposit_int<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = if (v0 == 0x1::type_name::with_defining_ids<T0>()) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<T1>()) {
            true
        } else {
            v0 == 0x1::type_name::with_defining_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()
        };
        assert!(v1, 1);
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::deposit_with_cap<T2>(&mut arg0.balance_manager, &arg0.deposit_cap, arg1, arg2);
    }

    public fun execute_conditional_orders<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &mut 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : vector<0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::order_info::OrderInfo> {
        assert!(0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg1) == deepbook_pool<T0, T1>(arg0), 5);
        let v0 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::oracle::calculate_price<T0, T1>(arg4, arg2, arg3, arg6);
        let v1 = 0x1::vector::empty<0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::order_info::OrderInfo>();
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0x1::vector::empty<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::trigger_below(&arg0.take_profit_stop_loss))) {
            let v7 = 0x1::vector::borrow<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::trigger_below(&arg0.take_profit_stop_loss), v6);
            let v8 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::condition(v7);
            if (v0 >= 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::trigger_price(&v8)) {
                break
            };
            0x1::vector::push_back<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(&mut v5, *v7);
            v6 = v6 + 1;
        };
        v6 = 0;
        while (v6 < 0x1::vector::length<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::trigger_above(&arg0.take_profit_stop_loss))) {
            let v9 = 0x1::vector::borrow<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::trigger_above(&arg0.take_profit_stop_loss), v6);
            let v10 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::condition(v9);
            if (v0 <= 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::trigger_price(&v10)) {
                break
            };
            0x1::vector::push_back<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(&mut v5, *v9);
            v6 = v6 + 1;
        };
        let v11 = &mut v1;
        let v12 = &mut v2;
        let v13 = &mut v3;
        let v14 = &mut v4;
        process_collected_orders<T0, T1>(arg0, arg1, arg4, v5, v11, v12, v13, v14, arg5, arg6, arg7);
        let v15 = id<T0, T1>(arg0);
        0x1::vector::reverse<u64>(&mut v4);
        let v16 = 0;
        while (v16 < 0x1::vector::length<u64>(&v4)) {
            0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::emit_insufficient_funds_event(&arg0.take_profit_stop_loss, v15, 0x1::vector::pop_back<u64>(&mut v4), arg6);
            v16 = v16 + 1;
        };
        0x1::vector::destroy_empty<u64>(v4);
        0x1::vector::append<u64>(&mut v3, v4);
        0x1::vector::reverse<u64>(&mut v3);
        let v17 = 0;
        while (v17 < 0x1::vector::length<u64>(&v3)) {
            0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::cancel_conditional_order(&mut arg0.take_profit_stop_loss, v15, 0x1::vector::pop_back<u64>(&mut v3), arg6);
            v17 = v17 + 1;
        };
        0x1::vector::destroy_empty<u64>(v3);
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::remove_executed_conditional_orders(&mut arg0.take_profit_stop_loss, v15, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg1), v2, arg6);
        v1
    }

    public fun has_base_debt<T0, T1>(arg0: &MarginManager<T0, T1>) : bool {
        arg0.borrowed_base_shares > 0
    }

    public fun highest_trigger_price_below<T0, T1>(arg0: &MarginManager<T0, T1>) : u64 {
        let v0 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::trigger_below_orders(&arg0.take_profit_stop_loss);
        if (0x1::vector::is_empty<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(v0)) {
            0
        } else {
            let v2 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::condition(0x1::vector::borrow<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(v0, 0));
            0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::trigger_price(&v2)
        }
    }

    public fun id<T0, T1>(arg0: &MarginManager<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T2>, arg5: &mut 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert!(arg0.deepbook_pool == 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg5), 5);
        let v0 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T2>(arg4);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0), 10);
        let v1 = risk_ratio_int<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, arg4, arg7);
        assert!(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::can_liquidate(arg1, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg5), v1), 9);
        assert!(0x2::coin::value<T2>(&arg6) >= 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_constants::min_liquidation_repay(), 13);
        let v2 = trade_proof<T0, T1>(arg0, arg8);
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::cancel_all_orders<T0, T1>(arg5, &mut arg0.balance_manager, &v2, arg7, arg8);
        let v3 = 0x1::u64::max(arg0.borrowed_base_shares, arg0.borrowed_quote_shares);
        let v4 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::borrow_shares_to_amount<T2>(arg4, v3, arg7);
        let v5 = 0x1::type_name::with_defining_ids<T2>() == 0x1::type_name::with_defining_ids<T0>();
        let (v6, v7, v8) = assets_in_debt_unit<T0, T1>(arg0, arg1, arg5, arg2, arg3, arg7);
        let v9 = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::constants::float_scaling() + 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::user_liquidation_reward(arg1, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg5)) + 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::pool_liquidation_reward(arg1, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg5));
        let v10 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::target_liquidation_risk_ratio(arg1, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg5));
        let v11 = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::div(0x1::u64::min(0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::mul(0x1::u64::min(0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::div(0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::mul(v10, v4) - v6, v10 - v9), v4), v9), v6), v9);
        let v12 = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::constants::float_scaling() + 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::pool_liquidation_reward(arg1, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg5));
        let v13 = 0x1::u64::min(v11, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::div(0x2::coin::value<T2>(&arg6), v12));
        let v14 = if (v1 < 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::constants::float_scaling() && v13 == v11) {
            v3
        } else {
            0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::mul(v3, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::div(v13, v4))
        };
        assert!(v14 > 0, 14);
        let (v15, v16, v17) = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::repay_liquidation<T2>(arg4, v14, 0x2::coin::split<T2>(&mut arg6, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::mul(v13, v12), arg8), arg7);
        if (v5) {
            arg0.borrowed_base_shares = arg0.borrowed_base_shares - v14;
        } else {
            arg0.borrowed_quote_shares = arg0.borrowed_quote_shares - v14;
        };
        if (arg0.borrowed_base_shares == 0 && arg0.borrowed_quote_shares == 0) {
            arg0.margin_pool_id = 0x1::option::none<0x2::object::ID>();
        };
        let v18 = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::mul(v13, v9);
        let (v19, v20) = if (v5) {
            let v21 = 0x1::u64::min(v18, v7);
            let v22 = liquidation_withdraw<T0, T1, T0>(arg0, v21, arg8);
            let v20 = liquidation_withdraw<T0, T1, T1>(arg0, 0x1::u64::min(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::oracle::calculate_target_currency<T0, T1>(arg1, arg2, arg3, v18 - v21, arg7), v8), arg8);
            (v22, v20)
        } else {
            let v23 = 0x1::u64::min(v18, v8);
            let v24 = liquidation_withdraw<T0, T1, T0>(arg0, 0x1::u64::min(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::oracle::calculate_target_currency<T1, T0>(arg1, arg3, arg2, v18 - v23, arg7), v7), arg8);
            let v20 = liquidation_withdraw<T0, T1, T1>(arg0, v23, arg8);
            (v24, v20)
        };
        let (v25, v26) = calculate_assets<T0, T1>(arg0, arg5);
        let (v27, v28) = if (0x1::option::is_some<0x2::object::ID>(&arg0.margin_pool_id)) {
            calculate_debts<T0, T1, T2>(arg0, arg4, arg7)
        } else {
            (0, 0)
        };
        let (v29, v30) = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::oracle::get_pyth_price<T0>(arg2, arg1, arg7);
        let (v31, v32) = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::oracle::get_pyth_price<T1>(arg3, arg1, arg7);
        let v33 = LiquidationEvent{
            margin_manager_id     : id<T0, T1>(arg0),
            margin_pool_id        : 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T2>(arg4),
            liquidation_amount    : v15,
            pool_reward           : v16,
            pool_default          : v17,
            risk_ratio            : v1,
            remaining_base_asset  : v25,
            remaining_quote_asset : v26,
            remaining_base_debt   : v27,
            remaining_quote_debt  : v28,
            base_pyth_price       : v29,
            base_pyth_decimals    : v30,
            quote_pyth_price      : v31,
            quote_pyth_decimals   : v32,
            timestamp             : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<LiquidationEvent>(v33);
        (v19, v20, arg6)
    }

    fun liquidation_withdraw<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg1, arg2)
    }

    public fun lowest_trigger_price_above<T0, T1>(arg0: &MarginManager<T0, T1>) : u64 {
        let v0 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::trigger_above_orders(&arg0.take_profit_stop_loss);
        if (0x1::vector::is_empty<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(v0)) {
            0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::constants::max_u64()
        } else {
            let v2 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::condition(0x1::vector::borrow<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(v0, 0));
            0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::trigger_price(&v2)
        }
    }

    public fun manager_state<T0, T1>(arg0: &MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg5: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T0>, arg6: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T1>, arg7: &0x2::clock::Clock) : (0x2::object::ID, 0x2::object::ID, u64, u64, u64, u64, u64, u64, u8, u64, u8) {
        let (v0, v1) = calculate_assets<T0, T1>(arg0, arg4);
        let (v2, v3) = if (0x1::option::is_some<0x2::object::ID>(&arg0.margin_pool_id)) {
            if (has_base_debt<T0, T1>(arg0)) {
                calculate_debts<T0, T1, T0>(arg0, arg5, arg7)
            } else {
                calculate_debts<T0, T1, T1>(arg0, arg6, arg7)
            }
        } else {
            (0, 0)
        };
        let (v4, v5) = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::oracle::get_pyth_price<T0>(arg2, arg1, arg7);
        let (v6, v7) = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::oracle::get_pyth_price<T1>(arg3, arg1, arg7);
        (id<T0, T1>(arg0), arg0.deepbook_pool, risk_ratio<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun margin_pool_id<T0, T1>(arg0: &MarginManager<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.margin_pool_id
    }

    fun new_margin_manager<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::registry::Registry, arg2: &mut 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : MarginManager<T0, T1> {
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::load_inner(arg2);
        assert!(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::pool_enabled<T0, T1>(arg2, arg0), 2);
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        let (v2, v3, v4, v5) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::new_with_custom_owner_caps<MarginApp>(arg1, 0x2::object::uid_to_address(&v0), arg4);
        let v6 = v2;
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::add_margin_manager(arg2, 0x2::object::uid_to_inner(&v0), arg4);
        let v7 = MarginManagerCreatedEvent{
            margin_manager_id  : 0x2::object::uid_to_inner(&v0),
            balance_manager_id : 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::id(&v6),
            deepbook_pool_id   : 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg0),
            owner              : v1,
            timestamp          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarginManagerCreatedEvent>(v7);
        MarginManager<T0, T1>{
            id                    : v0,
            owner                 : v1,
            deepbook_pool         : 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg0),
            margin_pool_id        : 0x1::option::none<0x2::object::ID>(),
            balance_manager       : v6,
            deposit_cap           : v3,
            withdraw_cap          : v4,
            trade_cap             : v5,
            borrowed_base_shares  : 0,
            borrowed_quote_shares : 0,
            take_profit_stop_loss : 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::new(),
            extra_fields          : 0x2::vec_map::empty<0x1::string::String, u64>(),
        }
    }

    public fun new_with_initializer<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::registry::Registry, arg2: &mut 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (MarginManager<T0, T1>, ManagerInitializer) {
        let v0 = new_margin_manager<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v1 = ManagerInitializer{margin_manager_id: id<T0, T1>(&v0)};
        (v0, v1)
    }

    public fun owner<T0, T1>(arg0: &MarginManager<T0, T1>) : address {
        arg0.owner
    }

    fun place_market_order_conditional<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &mut 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg3: u64, arg4: u8, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::order_info::OrderInfo {
        assert!(deepbook_pool<T0, T1>(arg0) == 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg2), 5);
        let v0 = trade_proof<T0, T1>(arg0, arg9);
        let v1 = balance_manager_unsafe_mut<T0, T1>(arg0);
        assert!(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::pool_enabled<T0, T1>(arg1, arg2), 15);
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::place_market_order<T0, T1>(arg2, v1, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    fun place_pending_limit_order<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &mut 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) : 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::order_info::OrderInfo {
        assert!(deepbook_pool<T0, T1>(arg0) == 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg2), 5);
        let v0 = trade_proof<T0, T1>(arg0, arg12);
        let v1 = balance_manager_unsafe_mut<T0, T1>(arg0);
        assert!(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::pool_enabled<T0, T1>(arg1, arg2), 15);
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::place_limit_order<T0, T1>(arg2, v1, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    fun place_pending_order<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &mut 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg3: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::PendingOrder, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::order_info::OrderInfo {
        if (0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::is_limit_order(arg3)) {
            place_pending_limit_order<T0, T1>(arg0, arg1, arg2, 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::client_order_id(arg3), 0x1::option::destroy_some<u8>(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::order_type(arg3)), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::self_matching_option(arg3), 0x1::option::destroy_some<u64>(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::price(arg3)), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::quantity(arg3), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::is_bid(arg3), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::pay_with_deep(arg3), 0x1::option::destroy_some<u64>(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::expire_timestamp(arg3)), arg4, arg5)
        } else {
            place_market_order_conditional<T0, T1>(arg0, arg1, arg2, 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::client_order_id(arg3), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::self_matching_option(arg3), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::quantity(arg3), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::is_bid(arg3), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::pay_with_deep(arg3), arg4, arg5)
        }
    }

    fun process_collected_orders<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &mut 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg2: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg3: vector<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>, arg4: &mut vector<0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::order_info::OrderInfo>, arg5: &mut vector<u64>, arg6: &mut vector<u64>, arg7: &mut vector<u64>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(&arg3) && 0x1::vector::length<0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::order_info::OrderInfo>(arg4) < arg8) {
            let v1 = 0x1::vector::borrow<0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::ConditionalOrder>(&arg3, v0);
            let v2 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::pending_order(v1);
            if (0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::is_limit_order(&v2) && 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::can_place_limit_order<T0, T1>(arg1, balance_manager<T0, T1>(arg0), 0x1::option::destroy_some<u64>(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::price(&v2)), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::quantity(&v2), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::is_bid(&v2), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::pay_with_deep(&v2), 0x1::option::destroy_some<u64>(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::expire_timestamp(&v2)), arg9) || 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::can_place_market_order<T0, T1>(arg1, balance_manager<T0, T1>(arg0), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::quantity(&v2), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::is_bid(&v2), 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::pay_with_deep(&v2), arg9)) {
                0x1::vector::push_back<0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::order_info::OrderInfo>(arg4, place_pending_order<T0, T1>(arg0, arg2, arg1, &v2, arg9, arg10));
                0x1::vector::push_back<u64>(arg5, 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::conditional_order_id(v1));
            } else if (0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::is_limit_order(&v2)) {
                let v3 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::expire_timestamp(&v2);
                if (*0x1::option::borrow<u64>(&v3) <= 0x2::clock::timestamp_ms(arg9)) {
                    0x1::vector::push_back<u64>(arg6, 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::conditional_order_id(v1));
                } else {
                    0x1::vector::push_back<u64>(arg7, 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::conditional_order_id(v1));
                };
            } else {
                0x1::vector::push_back<u64>(arg7, 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::tpsl::conditional_order_id(v1));
            };
            v0 = v0 + 1;
        };
    }

    public fun quote_balance<T0, T1>(arg0: &MarginManager<T0, T1>) : u64 {
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::balance<T1>(&arg0.balance_manager)
    }

    fun repay<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &mut 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T2>, arg2: 0x1::option::Option<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::u64::max(arg0.borrowed_base_shares, arg0.borrowed_quote_shares);
        let v1 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::borrow_shares_to_amount<T2>(arg1, v0, arg3);
        let v2 = 0x1::u64::min(0x1::option::destroy_with_default<u64>(arg2, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::balance<T2>(balance_manager<T0, T1>(arg0))), v1);
        let v3 = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::mul(v0, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::div(v2, v1));
        let v4 = repay_withdraw<T0, T1, T2>(arg0, v2, arg4);
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::repay<T2>(arg1, v3, v4, arg3);
        if (0x1::type_name::with_defining_ids<T2>() == 0x1::type_name::with_defining_ids<T0>()) {
            arg0.borrowed_base_shares = arg0.borrowed_base_shares - v3;
        } else {
            arg0.borrowed_quote_shares = arg0.borrowed_quote_shares - v3;
        };
        if (arg0.borrowed_base_shares == 0 && arg0.borrowed_quote_shares == 0) {
            arg0.margin_pool_id = 0x1::option::none<0x2::object::ID>();
        };
        let v5 = LoanRepaidEvent{
            margin_manager_id : id<T0, T1>(arg0),
            margin_pool_id    : 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T2>(arg1),
            repay_amount      : v2,
            repay_shares      : v3,
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LoanRepaidEvent>(v5);
        v2
    }

    public fun repay_base<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &mut 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T0>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg5);
        let v0 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T0>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0), 10);
        repay<T0, T1, T0>(arg0, arg2, arg3, arg4, arg5)
    }

    public fun repay_quote<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &mut 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T1>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg5);
        let v0 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T1>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0), 10);
        repay<T0, T1, T1>(arg0, arg2, arg3, arg4, arg5)
    }

    fun repay_withdraw<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        validate_owner<T0, T1>(arg0, arg2);
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg1, arg2)
    }

    public fun risk_ratio<T0, T1>(arg0: &MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg5: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T0>, arg6: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T1>, arg7: &0x2::clock::Clock) : u64 {
        if (arg0.borrowed_base_shares > 0) {
            risk_ratio_int<T0, T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7)
        } else {
            risk_ratio_int<T0, T1, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7)
        }
    }

    fun risk_ratio_int<T0, T1, T2>(arg0: &MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg5: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T2>, arg6: &0x2::clock::Clock) : u64 {
        let v0 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T2>(arg5);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0) || 0x1::option::is_none<0x2::object::ID>(&arg0.margin_pool_id), 10);
        let (v1, _, _) = assets_in_debt_unit<T0, T1>(arg0, arg1, arg4, arg2, arg3, arg6);
        let v4 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::borrow_shares_to_amount<T2>(arg5, 0x1::u64::max(arg0.borrowed_base_shares, arg0.borrowed_quote_shares), arg6);
        let v5 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_constants::max_risk_ratio();
        if (v1 >= 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::mul(v4, v5)) {
            v5
        } else {
            0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::div(v1, v4)
        }
    }

    public fun set_referral<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::DeepBookReferral, arg2: &mut 0x2::tx_context::TxContext) {
        validate_owner<T0, T1>(arg0, arg2);
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::set_referral(&mut arg0.balance_manager, arg1, &arg0.trade_cap);
    }

    public fun share<T0, T1>(arg0: MarginManager<T0, T1>, arg1: ManagerInitializer) {
        assert!(id<T0, T1>(&arg0) == arg1.margin_manager_id, 11);
        0x2::transfer::share_object<MarginManager<T0, T1>>(arg0);
        let ManagerInitializer {  } = arg1;
    }

    public(friend) fun trade_proof<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0x2::tx_context::TxContext) : 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::TradeProof {
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg1)
    }

    public fun unregister_margin_manager<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &mut 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        validate_owner<T0, T1>(arg0, arg2);
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::remove_margin_manager(arg1, id<T0, T1>(arg0), arg2);
    }

    public fun unset_referral<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        validate_owner<T0, T1>(arg0, arg1);
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::unset_referral(&mut arg0.balance_manager, &arg0.trade_cap);
    }

    fun validate_owner<T0, T1>(arg0: &MarginManager<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T0>, arg3: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg9);
        let v0 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T0>(arg2);
        if (0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0)) {
            assert!(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::can_withdraw(arg1, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg6), risk_ratio_int<T0, T1, T0>(arg0, arg1, arg4, arg5, arg6, arg2, arg8)), 8);
        } else {
            let v1 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::id<T1>(arg3);
            if (0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v1)) {
                assert!(0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::can_withdraw(arg1, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg6), risk_ratio_int<T0, T1, T1>(arg0, arg1, arg4, arg5, arg6, arg3, arg8)), 8);
            };
        };
        let v2 = 0x1::type_name::with_defining_ids<T2>();
        let v3 = v2 == 0x1::type_name::with_defining_ids<T0>();
        if (!v3 && !(v2 == 0x1::type_name::with_defining_ids<T1>())) {
            return 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg7, arg9)
        };
        let (_, _, _, v7, v8, v9, v10, v11, v12, v13, v14) = manager_state<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg2, arg3, arg8);
        let v15 = WithdrawCollateralEvent{
            margin_manager_id     : id<T0, T1>(arg0),
            amount                : arg7,
            asset                 : v2,
            withdraw_base_asset   : v3,
            remaining_base_asset  : v7,
            remaining_quote_asset : v8,
            remaining_base_debt   : v9,
            remaining_quote_debt  : v10,
            base_pyth_price       : v11,
            base_pyth_decimals    : v12,
            quote_pyth_price      : v13,
            quote_pyth_decimals   : v14,
            timestamp             : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<WithdrawCollateralEvent>(v15);
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg7, arg9)
    }

    public(friend) fun withdraw_settled_amounts_permissionless_int<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &mut 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>) {
        assert!(arg0.deepbook_pool == 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::id<T0, T1>(arg1), 5);
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::withdraw_settled_amounts_permissionless<T0, T1>(arg1, &mut arg0.balance_manager);
    }

    // decompiled from Move bytecode v6
}

