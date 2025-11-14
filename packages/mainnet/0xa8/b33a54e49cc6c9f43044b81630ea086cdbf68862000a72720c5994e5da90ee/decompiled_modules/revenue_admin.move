module 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::revenue_admin {
    struct TakeRevenueEvent has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    public fun take_revenue<T0, T1>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::ProtocolApp, arg2: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::validate_market<T0>(arg1, arg2);
        assert!(arg3 > 0, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::invalid_params_error());
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::has_circuit_break_triggered<T0>(arg2), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::market_under_circuit_break());
        let v0 = TakeRevenueEvent{
            market       : 0x2::object::id<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>>(arg2),
            amount       : arg3,
            coin_type    : 0x1::type_name::get<T1>(),
            sender       : 0x2::tx_context::sender(arg6),
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TakeRevenueEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::take_revenue<T0, T1>(arg2, arg3, arg6), arg4);
    }

    // decompiled from Move bytecode v6
}

