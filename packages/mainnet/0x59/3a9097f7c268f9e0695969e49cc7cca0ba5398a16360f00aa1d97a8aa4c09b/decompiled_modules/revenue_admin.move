module 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::revenue_admin {
    struct TakeRevenueEvent has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    public fun take_revenue<T0, T1>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::AdminCap, arg1: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::ProtocolApp, arg2: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::app::validate_market<T0>(arg1, arg2);
        assert!(arg3 > 0, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::invalid_params_error());
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::has_circuit_break_triggered<T0>(arg2), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::market_under_circuit_break());
        let v0 = TakeRevenueEvent{
            market       : 0x2::object::id<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>>(arg2),
            amount       : arg3,
            coin_type    : 0x1::type_name::get<T1>(),
            sender       : 0x2::tx_context::sender(arg6),
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TakeRevenueEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::take_revenue<T0, T1>(arg2, arg3, arg6), arg4);
    }

    // decompiled from Move bytecode v6
}

