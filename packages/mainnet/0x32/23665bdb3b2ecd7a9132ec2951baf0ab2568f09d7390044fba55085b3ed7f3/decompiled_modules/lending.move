module 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::lending {
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

    public entry fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x94ccc8d80ce60a2e2d9800e5bfbca3dbf7d88fbc00b70216e54600148829190f::oracle::PriceOracle, arg2: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::storage::Storage, arg3: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::normal_amount<T0>(arg3, arg5);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::validation::validate_borrow<T0>(arg2, arg4, v1);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::logic::execute_borrow(arg0, arg1, arg2, arg4, v0, (v1 as u256));
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::withdraw<T0>(arg3, arg5, v0, arg6);
        let v2 = BorrowEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg6),
            amount  : arg5,
        };
        0x2::event::emit<BorrowEvent>(v2);
    }

    public entry fun deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::storage::Storage, arg2: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::incentive::Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg7);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::incentive::update_reward(arg6, arg0, arg1, arg3, v0);
        let v1 = 0x3fbcde1070e096a9fd2b30d44c9a69e3ec857809b5367737b0f21cc1af3a961f::utils::split_coin<T0>(arg4, arg5, arg7);
        let v2 = 0x2::coin::value<T0>(&v1);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::deposit<T0>(arg2, v1, arg7);
        let v3 = 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::normal_amount<T0>(arg2, v2);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::validation::validate_deposit<T0>(arg1, arg3, v3);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::logic::execute_deposit(arg0, arg1, arg3, v0, (v3 as u256));
        let v4 = DepositEvent{
            reserve : arg3,
            sender  : v0,
            amount  : v2,
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public entry fun liquidation_call<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x94ccc8d80ce60a2e2d9800e5bfbca3dbf7d88fbc00b70216e54600148829190f::oracle::PriceOracle, arg2: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::storage::Storage, arg3: u8, arg4: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::Pool<T0>, arg5: u8, arg6: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::Pool<T1>, arg7: 0x2::coin::Coin<T0>, arg8: address, arg9: u64, arg10: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::incentive::Incentive, arg11: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg11);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::validation::validate_liquidate<T0, T1>(arg2, arg3, arg5, arg9);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::incentive::update_reward(arg10, arg0, arg2, arg5, arg8);
        let v1 = 0x3fbcde1070e096a9fd2b30d44c9a69e3ec857809b5367737b0f21cc1af3a961f::utils::split_coin<T0>(arg7, arg9, arg11);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::deposit<T0>(arg4, v1, arg11);
        let (v2, v3, v4) = 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::logic::execute_liquidate(arg0, arg1, arg2, arg8, arg5, arg3, (0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::normal_amount<T0>(arg4, 0x2::coin::value<T0>(&v1)) as u256));
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::withdraw<T0>(arg4, 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::unnormal_amount<T0>(arg4, (v3 as u64)), v0, arg11);
        let v5 = 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::unnormal_amount<T1>(arg6, (v2 as u64));
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::withdraw<T1>(arg6, v5, v0, arg11);
        let v6 = 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::unnormal_amount<T1>(arg6, (v4 as u64));
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::deposit_treasury<T1>(arg6, v6);
        let v7 = LiquidationCallEvent{
            reserve          : arg5,
            sender           : v0,
            liquidate_user   : arg8,
            liquidate_amount : v5 + v6,
        };
        0x2::event::emit<LiquidationCallEvent>(v7);
    }

    public entry fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x94ccc8d80ce60a2e2d9800e5bfbca3dbf7d88fbc00b70216e54600148829190f::oracle::PriceOracle, arg2: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::storage::Storage, arg3: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x3fbcde1070e096a9fd2b30d44c9a69e3ec857809b5367737b0f21cc1af3a961f::utils::split_coin<T0>(arg5, arg6, arg7);
        let v2 = 0x2::coin::value<T0>(&v1);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::deposit<T0>(arg3, v1, arg7);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::validation::validate_repay<T0>(arg2, arg4, v0, arg6);
        let v3 = 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::unnormal_amount<T0>(arg3, (0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::logic::execute_repay(arg0, arg1, arg2, arg4, v0, (0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::normal_amount<T0>(arg3, v2) as u256)) as u64));
        if (v3 > 0) {
            0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::withdraw<T0>(arg3, v3, v0, arg7);
        };
        let v4 = RepayEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg7),
            amount  : v2 - v3,
        };
        0x2::event::emit<RepayEvent>(v4);
    }

    fun when_not_paused(arg0: &0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::storage::Storage) {
        assert!(!0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::storage::pause(arg0), 41001);
    }

    public entry fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x94ccc8d80ce60a2e2d9800e5bfbca3dbf7d88fbc00b70216e54600148829190f::oracle::PriceOracle, arg2: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::storage::Storage, arg3: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address, arg7: &mut 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::incentive::Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg8);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::incentive::update_reward(arg7, arg0, arg2, arg4, v0);
        let v1 = 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::normal_amount<T0>(arg3, arg5);
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::validation::validate_withdraw<T0>(arg2, arg4, v0, v1);
        let v2 = 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::unnormal_amount<T0>(arg3, 0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::logic::execute_withdraw(arg0, arg1, arg2, arg4, v0, (v1 as u256)));
        0x3223665bdb3b2ecd7a9132ec2951baf0ab2568f09d7390044fba55085b3ed7f3::pool::withdraw<T0>(arg3, v2, arg6, arg8);
        let v3 = WithdrawEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg8),
            to      : arg6,
            amount  : v2,
        };
        0x2::event::emit<WithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

