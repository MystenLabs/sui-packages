module 0xf7c2b0135885e6ea5fc8be36fcc206dfdcc7b86d9c03ec71ce2eb2fd9f32e243::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0xf7c2b0135885e6ea5fc8be36fcc206dfdcc7b86d9c03ec71ce2eb2fd9f32e243::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xf7c2b0135885e6ea5fc8be36fcc206dfdcc7b86d9c03ec71ce2eb2fd9f32e243::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

