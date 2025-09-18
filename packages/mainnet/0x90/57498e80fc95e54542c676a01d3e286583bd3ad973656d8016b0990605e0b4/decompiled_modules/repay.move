module 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        refund: u64,
        time: u64,
    }

    public entry fun repay<T0, T1>(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::obligation::ObligationOwnerCap, arg1: &mut 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::ensure_version_matches<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::handle_repay<T0, T1>(arg1, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::obligation::id(arg0), arg2, v0, arg4);
        let v2 = 0x2::coin::value<T1>(&v1);
        if (v2 == 0) {
            0x2::coin::destroy_zero<T1>(v1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg4));
        };
        let v3 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg4),
            market     : 0x1::type_name::get<T0>(),
            obligation : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::obligation::id(arg0),
            asset      : 0x1::type_name::get<T1>(),
            amount     : 0x2::coin::value<T1>(&arg2),
            refund     : v2,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

