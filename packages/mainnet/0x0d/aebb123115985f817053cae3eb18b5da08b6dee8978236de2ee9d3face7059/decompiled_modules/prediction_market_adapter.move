module 0xdaebb123115985f817053cae3eb18b5da08b6dee8978236de2ee9d3face7059::prediction_market_adapter {
    public fun receive_position<T0>(arg0: &mut 0xdaebb123115985f817053cae3eb18b5da08b6dee8978236de2ee9d3face7059::account::Account, arg1: 0x2::transfer::Receiving<0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::Position<T0>>, arg2: &0x2::tx_context::TxContext) : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::Position<T0> {
        0xdaebb123115985f817053cae3eb18b5da08b6dee8978236de2ee9d3face7059::account::assert_owner(arg0, arg2);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::receive<T0>(0xdaebb123115985f817053cae3eb18b5da08b6dee8978236de2ee9d3face7059::account::extend(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

