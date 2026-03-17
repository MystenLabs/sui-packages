module 0x8ff3481c5da9f6690872f20fb2b3a21740e04af98fd27a2155b99cbb3e809391::bluefin_only {
    public fun liquidate_c2d<T0, T1, T2>(arg0: &0x8ff3481c5da9f6690872f20fb2b3a21740e04af98fd27a2155b99cbb3e809391::liquidator::Liquidator, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg4: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x8ff3481c5da9f6690872f20fb2b3a21740e04af98fd27a2155b99cbb3e809391::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg10));
        let (v0, v1) = liquidate_with_bluefin_c2d<T0, T1, T2>(0x8ff3481c5da9f6690872f20fb2b3a21740e04af98fd27a2155b99cbb3e809391::liquidator::borrow_package_caller_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x8ff3481c5da9f6690872f20fb2b3a21740e04af98fd27a2155b99cbb3e809391::liquidator::transfer_to_recipient<T2>(arg0, v0);
        0x8ff3481c5da9f6690872f20fb2b3a21740e04af98fd27a2155b99cbb3e809391::liquidator::transfer_to_recipient<T1>(arg0, v1);
    }

    public fun liquidate_d2c<T0, T1, T2>(arg0: &0x8ff3481c5da9f6690872f20fb2b3a21740e04af98fd27a2155b99cbb3e809391::liquidator::Liquidator, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg4: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x8ff3481c5da9f6690872f20fb2b3a21740e04af98fd27a2155b99cbb3e809391::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg10));
        let (v0, v1) = liquidate_with_bluefin_d2c<T0, T1, T2>(0x8ff3481c5da9f6690872f20fb2b3a21740e04af98fd27a2155b99cbb3e809391::liquidator::borrow_package_caller_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x8ff3481c5da9f6690872f20fb2b3a21740e04af98fd27a2155b99cbb3e809391::liquidator::transfer_to_recipient<T2>(arg0, v0);
        0x8ff3481c5da9f6690872f20fb2b3a21740e04af98fd27a2155b99cbb3e809391::liquidator::transfer_to_recipient<T1>(arg0, v1);
    }

    fun liquidate_with_bluefin_c2d<T0, T1, T2>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg4: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg9, arg1, arg2, true, false, arg8, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::liquidate::liquidate_as_coin<T0, T1, T2>(arg3, arg0, arg5, arg4, 0x2::coin::from_balance<T1>(v1, arg10), arg6, arg7, arg9, arg10);
        let v6 = v4;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg2, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3), arg10)), 0x2::balance::zero<T1>(), v3);
        (v6, v5)
    }

    fun liquidate_with_bluefin_d2c<T0, T1, T2>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg4: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg9, arg1, arg2, false, false, arg8, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v1);
        let (v4, v5) = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::liquidate::liquidate_as_coin<T0, T1, T2>(arg3, arg0, arg5, arg4, 0x2::coin::from_balance<T1>(v0, arg10), arg6, arg7, arg9, arg10);
        let v6 = v4;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v3), arg10)), v3);
        (v6, v5)
    }

    // decompiled from Move bytecode v6
}

