module 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::revenue_admin {
    struct TakeRevenueEvent has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    public fun take_revenue<T0, T1>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::AdminCap, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::validate_market<T0>(arg1, arg2);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ensure_version_matches(arg1);
        assert!(arg3 > 0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::invalid_params_error());
        assert!(!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::has_circuit_break_triggered<T0>(arg2), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::market_under_circuit_break());
        let v0 = TakeRevenueEvent{
            market       : 0x2::object::id<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>>(arg2),
            amount       : arg3,
            coin_type    : 0x1::type_name::with_defining_ids<T1>(),
            sender       : 0x2::tx_context::sender(arg6),
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TakeRevenueEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::take_revenue<T0, T1>(arg2, arg3, arg6), arg4);
    }

    // decompiled from Move bytecode v6
}

