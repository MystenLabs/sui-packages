module 0xea4d235d0f0f8be1ff621ae35582c6fd24d859ae8e0ae20ee450d1ae26a2723a::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0xea4d235d0f0f8be1ff621ae35582c6fd24d859ae8e0ae20ee450d1ae26a2723a::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xea4d235d0f0f8be1ff621ae35582c6fd24d859ae8e0ae20ee450d1ae26a2723a::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

