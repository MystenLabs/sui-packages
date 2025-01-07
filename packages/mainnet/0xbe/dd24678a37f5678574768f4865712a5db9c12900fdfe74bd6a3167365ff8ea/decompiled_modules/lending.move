module 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::lending {
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

    public entry fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x6145ee6ce16344c158375d581116e7f9cceb50f3d9b08fba93c2a5d78601aa39::oracle::PriceOracle, arg2: &mut 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::Storage, arg3: &mut 0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg6);
        0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::validation::validate_borrow(arg2, arg4, arg5);
        0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::logic::execute_borrow(arg0, arg1, arg2, arg4, v0, (arg5 as u256));
        0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::withdraw<T0>(arg3, arg5, v0, arg6);
        let v1 = BorrowEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg6),
            amount  : arg5,
        };
        0x2::event::emit<BorrowEvent>(v1);
    }

    public entry fun deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::Storage, arg2: &mut 0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x3d32c2f52cf22990c227f1acc9ef91136832028045ae764a471a65fe26e8ce50::utils::split_coin<T0>(arg4, arg5, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::deposit<T0>(arg2, v1, arg6);
        0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::validation::validate_deposit(arg1, arg3, v2);
        0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::logic::execute_deposit(arg0, arg1, arg3, v0, (v2 as u256));
        let v3 = DepositEvent{
            reserve : arg3,
            sender  : v0,
            amount  : v2,
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public entry fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x6145ee6ce16344c158375d581116e7f9cceb50f3d9b08fba93c2a5d78601aa39::oracle::PriceOracle, arg2: &mut 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::Storage, arg3: &mut 0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::logic::execute_withdraw(arg0, arg1, arg2, arg4, 0x2::tx_context::sender(arg7), (arg5 as u256));
        0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::withdraw<T0>(arg3, v0, arg6, arg7);
        let v1 = WithdrawEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg7),
            to      : arg6,
            amount  : v0,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    public entry fun liquidation_call<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x6145ee6ce16344c158375d581116e7f9cceb50f3d9b08fba93c2a5d78601aa39::oracle::PriceOracle, arg2: &mut 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::Storage, arg3: &mut 0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::Pool<T0>, arg4: &mut 0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::Pool<T1>, arg5: u8, arg6: 0x2::coin::Coin<T0>, arg7: address, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::validation::validate_liquidate(arg2, arg5, arg8);
        let v1 = 0x3d32c2f52cf22990c227f1acc9ef91136832028045ae764a471a65fe26e8ce50::utils::split_coin<T0>(arg6, arg8, arg10);
        let v2 = 0x2::coin::value<T0>(&v1);
        0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::deposit<T0>(arg3, v1, arg10);
        let (v3, v4) = 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::logic::execute_liquidate(arg0, arg1, arg2, arg7, arg5, arg9, (v2 as u256));
        0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::withdraw<T0>(arg3, (v4 as u64), v0, arg10);
        0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::withdraw<T1>(arg4, (v3 as u64), v0, arg10);
        let v5 = LiquidationCallEvent{
            reserve          : arg5,
            sender           : v0,
            liquidate_user   : arg7,
            liquidate_amount : v2,
        };
        0x2::event::emit<LiquidationCallEvent>(v5);
    }

    public entry fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x6145ee6ce16344c158375d581116e7f9cceb50f3d9b08fba93c2a5d78601aa39::oracle::PriceOracle, arg2: &mut 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::Storage, arg3: &mut 0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::validation::validate_repay(arg2, arg4, arg6);
        let v0 = 0x3d32c2f52cf22990c227f1acc9ef91136832028045ae764a471a65fe26e8ce50::utils::split_coin<T0>(arg5, arg6, arg7);
        let v1 = 0x2::coin::value<T0>(&v0);
        0x5ff12e6601ddc6b376cd99630aa4f24cb768dbcc83353123b6e9c58408bc6e32::pool::deposit<T0>(arg3, v0, arg7);
        0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::logic::execute_repay(arg0, arg1, arg2, arg4, 0x2::tx_context::sender(arg7), (v1 as u256));
        let v2 = RepayEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg7),
            amount  : v1,
        };
        0x2::event::emit<RepayEvent>(v2);
    }

    fun when_not_paused(arg0: &0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::Storage) {
        assert!(!0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::pause(arg0), 41001);
    }

    // decompiled from Move bytecode v6
}

