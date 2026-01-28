module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth {
    struct Auth<phantom T0> has drop {
        pos0: address,
    }

    public fun addr<T0>(arg0: &Auth<T0>) : address {
        arg0.pos0
    }

    public fun new_auth<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &mut 0x2::tx_context::TxContext) : Auth<T0> {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0));
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::assert_is_authorized<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::roles(arg0), 0x2::tx_context::sender(arg1));
        Auth<T0>{pos0: 0x2::tx_context::sender(arg1)}
    }

    // decompiled from Move bytecode v6
}

