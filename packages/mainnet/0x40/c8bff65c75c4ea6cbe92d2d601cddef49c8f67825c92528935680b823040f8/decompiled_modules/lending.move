module 0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::lending {
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

    public entry fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::storage::Storage, arg3: &mut 0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg6);
        0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::validation::validate_borrow(arg2, arg4, arg5);
        0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::logic::execute_borrow(arg0, arg1, arg2, arg4, v0, (arg5 as u256));
        0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::withdraw<T0>(arg3, arg5, v0, arg6);
        let v1 = BorrowEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg6),
            amount  : arg5,
        };
        0x2::event::emit<BorrowEvent>(v1);
    }

    public entry fun deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::storage::Storage, arg2: &mut 0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x863dd14d9c8dbc554752888c10b78208b7fc20ac401b63cb537cf17bc50f58bc::utils::split_coin<T0>(arg4, arg5, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::deposit<T0>(arg2, v1, arg6);
        0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::validation::validate_deposit(arg1, arg3, v2);
        0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::logic::execute_deposit(arg0, arg1, arg3, v0, (v2 as u256));
        let v3 = DepositEvent{
            reserve : arg3,
            sender  : v0,
            amount  : v2,
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public entry fun liquidation_call<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::storage::Storage, arg3: &mut 0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::Pool<T0>, arg4: &mut 0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::Pool<T1>, arg5: u8, arg6: 0x2::coin::Coin<T0>, arg7: address, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg10);
        0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::validation::validate_liquidate(arg2, arg5, arg8);
        let v1 = 0x863dd14d9c8dbc554752888c10b78208b7fc20ac401b63cb537cf17bc50f58bc::utils::split_coin<T0>(arg6, arg8, arg10);
        let v2 = 0x2::coin::value<T0>(&v1);
        0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::deposit<T0>(arg3, v1, arg10);
        let (v3, v4, v5) = 0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::logic::execute_liquidate(arg0, arg1, arg2, arg7, arg5, arg9, (v2 as u256));
        0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::withdraw<T0>(arg3, (v4 as u64), v0, arg10);
        0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::withdraw<T1>(arg4, (v3 as u64), v0, arg10);
        0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::deposit_treasury<T1>(arg4, (v5 as u64));
        let v6 = LiquidationCallEvent{
            reserve          : arg5,
            sender           : v0,
            liquidate_user   : arg7,
            liquidate_amount : v2,
        };
        0x2::event::emit<LiquidationCallEvent>(v6);
    }

    public entry fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::storage::Storage, arg3: &mut 0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::validation::validate_repay(arg2, arg4, arg6);
        let v0 = 0x863dd14d9c8dbc554752888c10b78208b7fc20ac401b63cb537cf17bc50f58bc::utils::split_coin<T0>(arg5, arg6, arg7);
        let v1 = 0x2::coin::value<T0>(&v0);
        0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::deposit<T0>(arg3, v0, arg7);
        0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::logic::execute_repay(arg0, arg1, arg2, arg4, 0x2::tx_context::sender(arg7), (v1 as u256));
        let v2 = RepayEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg7),
            amount  : v1,
        };
        0x2::event::emit<RepayEvent>(v2);
    }

    fun when_not_paused(arg0: &0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::storage::Storage) {
        assert!(!0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::storage::pause(arg0), 41001);
    }

    public entry fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::storage::Storage, arg3: &mut 0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x8470800b647bdd54a07bc6eb0c078e44e0daa8a4b11f5a3533cdf9129e6f2e32::logic::execute_withdraw(arg0, arg1, arg2, arg4, 0x2::tx_context::sender(arg7), (arg5 as u256));
        0xaf30a81c158051d27b35490445550b9b795271bf75f022c09799c683083e5b29::pool::withdraw<T0>(arg3, v0, arg6, arg7);
        let v1 = WithdrawEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg7),
            to      : arg6,
            amount  : v0,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

