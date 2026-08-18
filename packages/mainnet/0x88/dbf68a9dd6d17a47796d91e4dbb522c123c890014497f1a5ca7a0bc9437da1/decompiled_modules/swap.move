module 0x88dbf68a9dd6d17a47796d91e4dbb522c123c890014497f1a5ca7a0bc9437da1::swap {
    struct MicroSwap has copy, drop {
        sender: address,
        token_type: 0x1::type_name::TypeName,
    }

    public entry fun MicroSwapReturnType<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MicroSwap{
            sender     : 0x2::tx_context::sender(arg0),
            token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<MicroSwap>(v0);
    }

    // decompiled from Move bytecode v7
}

