module 0x1250f84b608c375b91783512c747fd6d9c0cb8722c5a8f792e97a3081108534b::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x1250f84b608c375b91783512c747fd6d9c0cb8722c5a8f792e97a3081108534b::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x1250f84b608c375b91783512c747fd6d9c0cb8722c5a8f792e97a3081108534b::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

