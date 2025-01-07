module 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::lending {
    struct DepositEvent has copy, drop {
        reserve: u8,
        user: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        reserve: u8,
        user: address,
        to: address,
        amount: u64,
    }

    struct BorrowEvent has copy, drop {
        reserve: u8,
        user: address,
        amount: u64,
    }

    struct RepayEvent has copy, drop {
        reserve: u8,
        user: address,
        amount: u64,
    }

    struct LiquidationCallEvent has copy, drop {
        reserve: u8,
        user: address,
    }

    public entry fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg2: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg3: &mut 0x3221fa03e8eb2a35409e6b2582ff89fb4af4745d0729f97d37bc3ee9adf2a653::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg6);
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::validation::validate_borrow(arg2, arg4, arg5);
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::logic::execute_borrow(arg0, arg1, arg2, arg4, v0, (arg5 as u256));
        0x3221fa03e8eb2a35409e6b2582ff89fb4af4745d0729f97d37bc3ee9adf2a653::pool::withdraw<T0>(arg3, arg5, v0, arg6);
        let v1 = BorrowEvent{
            reserve : arg4,
            user    : 0x2::tx_context::sender(arg6),
            amount  : arg5,
        };
        0x2::event::emit<BorrowEvent>(v1);
    }

    public entry fun deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg2: &mut 0x3221fa03e8eb2a35409e6b2582ff89fb4af4745d0729f97d37bc3ee9adf2a653::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x953dd3b31a76d4c17c1c0391b4a8cf99692340df58ec2695dd703ec90adc6097::utils::split_coin<T0>(arg4, arg5, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        0x3221fa03e8eb2a35409e6b2582ff89fb4af4745d0729f97d37bc3ee9adf2a653::pool::deposit<T0>(arg2, v1, arg6);
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::validation::validate_deposit(arg1, arg3, v2);
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::logic::execute_deposit(arg0, arg1, arg3, v0, (v2 as u256));
        let v3 = DepositEvent{
            reserve : arg3,
            user    : v0,
            amount  : v2,
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public entry fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg2: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg3: &mut 0x3221fa03e8eb2a35409e6b2582ff89fb4af4745d0729f97d37bc3ee9adf2a653::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::validation::validate_repay(arg2, arg4, arg6);
        let v0 = 0x953dd3b31a76d4c17c1c0391b4a8cf99692340df58ec2695dd703ec90adc6097::utils::split_coin<T0>(arg5, arg6, arg7);
        let v1 = 0x2::coin::value<T0>(&v0);
        0x3221fa03e8eb2a35409e6b2582ff89fb4af4745d0729f97d37bc3ee9adf2a653::pool::deposit<T0>(arg3, v0, arg7);
        0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::logic::execute_repay(arg0, arg1, arg2, arg4, 0x2::tx_context::sender(arg7), (v1 as u256));
        let v2 = RepayEvent{
            reserve : arg4,
            user    : 0x2::tx_context::sender(arg7),
            amount  : v1,
        };
        0x2::event::emit<RepayEvent>(v2);
    }

    fun when_not_paused(arg0: &0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage) {
        assert!(!0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::pause(arg0), 41001);
    }

    public entry fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg2: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg3: &mut 0x3221fa03e8eb2a35409e6b2582ff89fb4af4745d0729f97d37bc3ee9adf2a653::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::logic::execute_withdraw(arg0, arg1, arg2, arg4, 0x2::tx_context::sender(arg7), (arg5 as u256));
        0x3221fa03e8eb2a35409e6b2582ff89fb4af4745d0729f97d37bc3ee9adf2a653::pool::withdraw<T0>(arg3, v0, arg6, arg7);
        let v1 = WithdrawEvent{
            reserve : arg4,
            user    : 0x2::tx_context::sender(arg7),
            to      : arg6,
            amount  : v0,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

