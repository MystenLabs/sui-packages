module 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::pay {
    public entry fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::zero<T0>(arg0), arg0);
    }

    public entry fun join_vec_and_split<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg1) > 0, 0);
        0x2::pay::join_vec<T0>(&mut arg0, arg1);
        0x2::pay::split<T0>(&mut arg0, arg2, arg3);
        0x2::pay::keep<T0>(arg0, arg3);
    }

    // decompiled from Move bytecode v6
}

