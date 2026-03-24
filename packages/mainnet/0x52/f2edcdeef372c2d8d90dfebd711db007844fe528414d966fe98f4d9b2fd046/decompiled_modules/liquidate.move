module 0x52f2edcdeef372c2d8d90dfebd711db007844fe528414d966fe98f4d9b2fd046::liquidate {
    struct CustomLiquidateReceipt<phantom T0, phantom T1> {
        ticket: 0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::EmptyTokenTicket,
        debt_quota: u64,
    }

    public fun custom_liquidate<T0, T1, T2>(arg0: &0x52f2edcdeef372c2d8d90dfebd711db007844fe528414d966fe98f4d9b2fd046::liquidator::Liquidator, arg1: 0x2::coin::Coin<T2>, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg3: 0x2::object::ID, arg4: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg5: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (CustomLiquidateReceipt<T1, T2>, 0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::SwapContext) {
        0x52f2edcdeef372c2d8d90dfebd711db007844fe528414d966fe98f4d9b2fd046::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg8));
        let (v0, v1) = 0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::new_swap_context(arg8);
        let v2 = v0;
        let v3 = CustomLiquidateReceipt<T1, T2>{
            ticket     : v1,
            debt_quota : 0x2::coin::value<T2>(&arg1),
        };
        let (v4, v5) = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::liquidate::liquidate_as_coin<T0, T2, T1>(arg2, 0x52f2edcdeef372c2d8d90dfebd711db007844fe528414d966fe98f4d9b2fd046::liquidator::borrow_package_caller_cap(arg0), arg3, arg4, arg1, arg5, arg6, arg7, arg8);
        let v6 = v5;
        v3.debt_quota = v3.debt_quota - 0x2::coin::value<T2>(&v6);
        0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::put_balance<T1>(&mut v2, 0x2::coin::into_balance<T1>(v4));
        if (0x2::coin::value<T2>(&v6) == 0) {
            0x2::coin::destroy_zero<T2>(v6);
        } else {
            0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::put_balance<T2>(&mut v2, 0x2::coin::into_balance<T2>(v6));
        };
        (v3, v2)
    }

    public fun verify_custom_liquidate<T0, T1>(arg0: CustomLiquidateReceipt<T0, T1>, arg1: 0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::SwapContext, arg2: u64, arg3: &0x52f2edcdeef372c2d8d90dfebd711db007844fe528414d966fe98f4d9b2fd046::liquidator::Liquidator, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let CustomLiquidateReceipt {
            ticket     : v0,
            debt_quota : v1,
        } = arg0;
        let v2 = v0;
        assert!(v1 * (1000 + 1) / 1000 >= arg2, 0x52f2edcdeef372c2d8d90dfebd711db007844fe528414d966fe98f4d9b2fd046::error::invalid_repay_amount());
        0x52f2edcdeef372c2d8d90dfebd711db007844fe528414d966fe98f4d9b2fd046::liquidator::transfer_to_recipient<T0>(arg3, 0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::empty_token_as_coin<T0>(&mut arg1, &v2, arg4));
        let v3 = 0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::empty_token_as_coin<T1>(&mut arg1, &v2, arg4);
        0x52f2edcdeef372c2d8d90dfebd711db007844fe528414d966fe98f4d9b2fd046::liquidator::transfer_to_recipient<T1>(arg3, v3);
        0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::end_swap(arg1, v2);
        0x2::coin::split<T1>(&mut v3, arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

