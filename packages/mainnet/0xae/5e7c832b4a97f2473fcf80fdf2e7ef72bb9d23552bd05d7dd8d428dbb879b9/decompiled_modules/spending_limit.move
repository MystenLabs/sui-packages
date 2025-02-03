module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::spending_limit {
    struct Spending has copy, drop, store {
        round: u64,
        limit: u64,
    }

    struct SpendingLimit has copy, drop, store {
        start_time_ms: u64,
        period_ms: u64,
        spending_limit: u64,
        spending: Spending,
    }

    struct SpendingLimits has store {
        limits: 0x2::vec_map::VecMap<u64, SpendingLimit>,
    }

    struct CoinSpendingLimit has store {
        limits: 0x2::table::Table<0x1::ascii::String, SpendingLimits>,
    }

    struct SignerSpendingLimit has store {
        limits: 0x2::table::Table<address, CoinSpendingLimit>,
    }

    struct SpendingLimitBook has store {
        next_id: u64,
        limits: SignerSpendingLimit,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : SpendingLimitBook {
        let v0 = SignerSpendingLimit{limits: 0x2::table::new<address, CoinSpendingLimit>(arg0)};
        SpendingLimitBook{
            next_id : 0,
            limits  : v0,
        }
    }

    fun create_spending_limit(arg0: &mut SpendingLimitBook, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::validate_coin_type(&arg2);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        if (arg3 == 0) {
            arg3 = v0;
        };
        assert!(arg4 > 0, 1001);
        assert!(arg3 + arg4 > v0, 1000);
        let v1 = arg0.next_id;
        arg0.next_id = arg0.next_id + 1;
        let v2 = init_spending_limits_mut(arg0, arg1, arg2, arg7);
        let v3 = Spending{
            round : 0,
            limit : arg5,
        };
        let v4 = SpendingLimit{
            start_time_ms  : arg3,
            period_ms      : arg4,
            spending_limit : arg5,
            spending       : v3,
        };
        0x2::vec_map::insert<u64, SpendingLimit>(&mut v2.limits, v1, v4);
        assert!(0x2::vec_map::size<u64, SpendingLimit>(&v2.limits) <= 1024, 1005);
        v1
    }

    fun delete_spending_limit(arg0: &mut SpendingLimitBook, arg1: address, arg2: 0x1::ascii::String, arg3: u64) {
        let (_, _) = 0x2::vec_map::remove<u64, SpendingLimit>(&mut get_spending_limits_mut(arg0, arg1, arg2).limits, &arg3);
    }

    public(friend) fun execute(arg0: &mut SpendingLimitBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_admin_operation(arg1), 1003);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_create_spending_limit(v0)) {
            execute_create_spending_limit(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_create_spending_limit(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)), arg2, arg3);
        } else {
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_delete_spending_limit(v0), 1004);
            execute_delete_spending_limit(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_delete_spending_limit(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        };
    }

    fun execute_create_spending_limit(arg0: &mut SpendingLimitBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::CreateSpendingLimit, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::create_spending_limit_destruct(arg1);
        create_spending_limit(arg0, v0, v1, v2, v3, v4, arg2, arg3);
    }

    fun execute_delete_spending_limit(arg0: &mut SpendingLimitBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::DeleteSpendingLimit) {
        let (v0, v1, v2) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::delete_spending_limit_destruct(arg1);
        delete_spending_limit(arg0, v0, v1, v2);
    }

    fun get_spending_limits_mut(arg0: &mut SpendingLimitBook, arg1: address, arg2: 0x1::ascii::String) : &mut SpendingLimits {
        0x2::table::borrow_mut<0x1::ascii::String, SpendingLimits>(&mut 0x2::table::borrow_mut<address, CoinSpendingLimit>(&mut arg0.limits.limits, arg1).limits, arg2)
    }

    fun init_spending_limits_mut(arg0: &mut SpendingLimitBook, arg1: address, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) : &mut SpendingLimits {
        let v0 = &mut arg0.limits;
        if (!0x2::table::contains<address, CoinSpendingLimit>(&mut v0.limits, arg1)) {
            let v1 = CoinSpendingLimit{limits: 0x2::table::new<0x1::ascii::String, SpendingLimits>(arg3)};
            0x2::table::add<address, CoinSpendingLimit>(&mut v0.limits, arg1, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, CoinSpendingLimit>(&mut v0.limits, arg1);
        if (!0x2::table::contains<0x1::ascii::String, SpendingLimits>(&mut v2.limits, arg2)) {
            let v3 = SpendingLimits{limits: 0x2::vec_map::empty<u64, SpendingLimit>()};
            0x2::table::add<0x1::ascii::String, SpendingLimits>(&mut v2.limits, arg2, v3);
        };
        0x2::table::borrow_mut<0x1::ascii::String, SpendingLimits>(&mut v2.limits, arg2)
    }

    public(friend) fun spend(arg0: &mut SpendingLimitBook, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::get_mut<u64, SpendingLimit>(&mut get_spending_limits_mut(arg0, arg1, arg2).limits, &arg3);
        let v1 = (0x2::clock::timestamp_ms(arg5) - v0.start_time_ms) / v0.period_ms;
        if (v1 > v0.spending.round) {
            v0.spending.round = v1;
            v0.spending.limit = v0.spending_limit;
        };
        assert!(v0.spending.limit >= arg4, 1002);
        v0.spending.limit = v0.spending.limit - arg4;
    }

    // decompiled from Move bytecode v6
}

