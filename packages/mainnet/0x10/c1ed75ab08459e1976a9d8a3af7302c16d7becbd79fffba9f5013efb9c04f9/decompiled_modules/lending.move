module 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::lending {
    struct DepositEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        reserve: u8,
        sender: address,
        to: address,
        amount: u64,
    }

    struct BorrowEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
    }

    struct RepayEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
    }

    struct LiquidationCallEvent has copy, drop {
        reserve: u8,
        sender: address,
        liquidate_user: address,
        liquidate_amount: u64,
    }

    public entry fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg3: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun base_borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg3: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address) : 0x2::balance::Balance<T0> {
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::when_not_paused(arg2);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::version_verification(arg2);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::logic::execute_borrow<T0>(arg0, arg1, arg2, arg4, arg6, (0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::normal_amount<T0>(arg3, arg5) as u256));
        let v0 = BorrowEvent{
            reserve : arg4,
            sender  : arg6,
            amount  : arg5,
        };
        0x2::event::emit<BorrowEvent>(v0);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::withdraw_balance<T0>(arg3, arg5, arg6)
    }

    fun base_deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg3: u8, arg4: address, arg5: 0x2::balance::Balance<T0>) {
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::when_not_paused(arg1);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::version_verification(arg1);
        let v0 = 0x2::balance::value<T0>(&arg5);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::deposit_balance<T0>(arg2, arg5, arg4);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::logic::execute_deposit<T0>(arg0, arg1, arg3, arg4, (0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::normal_amount<T0>(arg2, v0) as u256));
        let v1 = DepositEvent{
            reserve : arg3,
            sender  : arg4,
            amount  : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun base_liquidation_call<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg3: u8, arg4: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T1>, arg8: address, arg9: address) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::when_not_paused(arg2);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::version_verification(arg2);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::deposit_balance<T0>(arg4, arg5, arg8);
        let (v0, v1, v2) = 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::logic::execute_liquidate<T0, T1>(arg0, arg1, arg2, arg9, arg6, arg3, (0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::normal_amount<T0>(arg4, 0x2::balance::value<T0>(&arg5)) as u256));
        let v3 = 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::unnormal_amount<T1>(arg7, (v2 as u64));
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::deposit_treasury<T1>(arg7, v3);
        let v4 = 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::unnormal_amount<T1>(arg7, (v0 as u64));
        let v5 = LiquidationCallEvent{
            reserve          : arg6,
            sender           : arg8,
            liquidate_user   : arg9,
            liquidate_amount : v4 + v3,
        };
        0x2::event::emit<LiquidationCallEvent>(v5);
        (0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::withdraw_balance<T0>(arg4, 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::unnormal_amount<T0>(arg4, (v1 as u64)), arg8), 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::withdraw_balance<T1>(arg7, v4, arg8))
    }

    fun base_repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg3: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg4: u8, arg5: 0x2::balance::Balance<T0>, arg6: address) : 0x2::balance::Balance<T0> {
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::when_not_paused(arg2);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::version_verification(arg2);
        let v0 = 0x2::balance::value<T0>(&arg5);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::deposit_balance<T0>(arg3, arg5, arg6);
        let v1 = 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::unnormal_amount<T0>(arg3, (0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::logic::execute_repay<T0>(arg0, arg1, arg2, arg4, arg6, (0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::normal_amount<T0>(arg3, v0) as u256)) as u64));
        let v2 = RepayEvent{
            reserve : arg4,
            sender  : arg6,
            amount  : v0 - v1,
        };
        0x2::event::emit<RepayEvent>(v2);
        if (v1 > 0) {
            return 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::withdraw_balance<T0>(arg3, v1, arg6)
        };
        0x2::balance::zero<T0>()
    }

    fun base_withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg3: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address) : 0x2::balance::Balance<T0> {
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::when_not_paused(arg2);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::version_verification(arg2);
        let v0 = 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::unnormal_amount<T0>(arg3, 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::logic::execute_withdraw<T0>(arg0, arg1, arg2, arg4, arg6, (0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::normal_amount<T0>(arg3, arg5) as u256)));
        let v1 = WithdrawEvent{
            reserve : arg4,
            sender  : arg6,
            to      : arg6,
            amount  : v0,
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::withdraw_balance<T0>(arg3, v0, arg6)
    }

    public(friend) fun borrow_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg3: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg6))
    }

    public entry fun deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::incentive::Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun deposit_coin<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        base_deposit<T0>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg6), 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::utils::split_coin_to_balance<T0>(arg4, arg5, arg6));
    }

    public(friend) fun liquidation<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg3: u8, arg4: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u8, arg7: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T1>, arg8: address, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = base_liquidation_call<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::utils::split_coin_to_balance<T0>(arg5, arg9, arg10), arg6, arg7, 0x2::tx_context::sender(arg10), arg8);
        (v1, v0)
    }

    public entry fun liquidation_call<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg3: u8, arg4: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg5: u8, arg6: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T1>, arg7: 0x2::coin::Coin<T0>, arg8: address, arg9: u64, arg10: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::incentive::Incentive, arg11: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg11);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::incentive::update_reward(arg10, arg0, arg2, arg5, arg8);
        let v1 = 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::utils::split_coin<T0>(arg7, arg9, arg11);
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::deposit<T0>(arg4, v1, arg11);
        let (v2, v3, v4) = 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::logic::execute_liquidate<T0, T1>(arg0, arg1, arg2, arg8, arg5, arg3, (0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::normal_amount<T0>(arg4, 0x2::coin::value<T0>(&v1)) as u256));
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::withdraw<T0>(arg4, 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::unnormal_amount<T0>(arg4, (v3 as u64)), v0, arg11);
        let v5 = 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::unnormal_amount<T1>(arg6, (v2 as u64));
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::withdraw<T1>(arg6, v5, v0, arg11);
        let v6 = 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::unnormal_amount<T1>(arg6, (v4 as u64));
        0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::deposit_treasury<T1>(arg6, v6);
        let v7 = LiquidationCallEvent{
            reserve          : arg5,
            sender           : v0,
            liquidate_user   : arg8,
            liquidate_amount : v5 + v6,
        };
        0x2::event::emit<LiquidationCallEvent>(v7);
    }

    public entry fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg3: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun repay_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg3: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_repay<T0>(arg0, arg1, arg2, arg3, arg4, 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::utils::split_coin_to_balance<T0>(arg5, arg6, arg7), 0x2::tx_context::sender(arg7))
    }

    fun when_not_paused(arg0: &0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage) {
        assert!(!0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::pause(arg0), 41001);
    }

    public entry fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg3: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address, arg7: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::incentive::Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun withdraw_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg3: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg6))
    }

    // decompiled from Move bytecode v6
}

