module 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::flow_x_protocol {
    public(friend) fun swap_exact_input<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

