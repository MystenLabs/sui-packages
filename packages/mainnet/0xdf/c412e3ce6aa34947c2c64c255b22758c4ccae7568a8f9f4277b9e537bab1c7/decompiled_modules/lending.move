module 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::lending {
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

    public entry fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::storage::Storage, arg3: &mut 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::normal_amount<T0>(arg3, arg5);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::validation::validate_borrow(arg2, arg4, v1);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::logic::execute_borrow(arg0, arg1, arg2, arg4, v0, (v1 as u256));
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::withdraw<T0>(arg3, arg5, v0, arg6);
        let v2 = BorrowEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg6),
            amount  : arg5,
        };
        0x2::event::emit<BorrowEvent>(v2);
    }

    public entry fun deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::storage::Storage, arg2: &mut 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x3acdfb20dd0c6d4d6502a29199c5bc00ff6d2d8fab29bd11dbd274103e6b467b::utils::split_coin<T0>(arg4, arg5, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::deposit<T0>(arg2, v1, arg6);
        let v3 = 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::normal_amount<T0>(arg2, v2);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::validation::validate_deposit(arg1, arg3, v3);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::logic::execute_deposit(arg0, arg1, arg3, v0, (v3 as u256));
        let v4 = DepositEvent{
            reserve : arg3,
            sender  : v0,
            amount  : v2,
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public entry fun liquidation_call<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::storage::Storage, arg3: &mut 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::Pool<T0>, arg4: &mut 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::Pool<T1>, arg5: u8, arg6: 0x2::coin::Coin<T0>, arg7: address, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg10);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::validation::validate_liquidate(arg2, arg5, arg8);
        let v1 = 0x3acdfb20dd0c6d4d6502a29199c5bc00ff6d2d8fab29bd11dbd274103e6b467b::utils::split_coin<T0>(arg6, arg8, arg10);
        let v2 = 0x2::coin::value<T0>(&v1);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::deposit<T0>(arg3, v1, arg10);
        let (v3, v4, v5) = 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::logic::execute_liquidate(arg0, arg1, arg2, arg7, arg5, arg9, (v2 as u256));
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::withdraw<T0>(arg3, (v4 as u64), v0, arg10);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::withdraw<T1>(arg4, (v3 as u64), v0, arg10);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::deposit_treasury<T1>(arg4, (v5 as u64));
        let v6 = LiquidationCallEvent{
            reserve          : arg5,
            sender           : v0,
            liquidate_user   : arg7,
            liquidate_amount : v2,
        };
        0x2::event::emit<LiquidationCallEvent>(v6);
    }

    public entry fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::storage::Storage, arg3: &mut 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x3acdfb20dd0c6d4d6502a29199c5bc00ff6d2d8fab29bd11dbd274103e6b467b::utils::split_coin<T0>(arg5, arg6, arg7);
        let v2 = 0x2::coin::value<T0>(&v1);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::deposit<T0>(arg3, v1, arg7);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::validation::validate_repay(arg2, arg4, arg6);
        let v3 = 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::logic::execute_repay(arg0, arg1, arg2, arg4, v0, (0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::normal_amount<T0>(arg3, v2) as u256));
        if (v3 > 0) {
            0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::withdraw<T0>(arg3, (v3 as u64), v0, arg7);
        };
        let v4 = RepayEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg7),
            amount  : v2,
        };
        0x2::event::emit<RepayEvent>(v4);
    }

    fun when_not_paused(arg0: &0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::storage::Storage) {
        assert!(!0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::storage::pause(arg0), 41001);
    }

    public entry fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg2: &mut 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::storage::Storage, arg3: &mut 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::normal_amount<T0>(arg3, arg5);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::validation::validate_withdraw(arg2, arg4, v0);
        0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::withdraw<T0>(arg3, 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::pool::unnormal_amount<T0>(arg3, 0xdfc412e3ce6aa34947c2c64c255b22758c4ccae7568a8f9f4277b9e537bab1c7::logic::execute_withdraw(arg0, arg1, arg2, arg4, 0x2::tx_context::sender(arg7), (v0 as u256))), arg6, arg7);
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

