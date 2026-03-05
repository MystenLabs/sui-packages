module 0x570c3a5dd8dcc7ac757b37be1c53746855b555e0efb44e4bf8101f16c119adf8::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x570c3a5dd8dcc7ac757b37be1c53746855b555e0efb44e4bf8101f16c119adf8::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x570c3a5dd8dcc7ac757b37be1c53746855b555e0efb44e4bf8101f16c119adf8::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

