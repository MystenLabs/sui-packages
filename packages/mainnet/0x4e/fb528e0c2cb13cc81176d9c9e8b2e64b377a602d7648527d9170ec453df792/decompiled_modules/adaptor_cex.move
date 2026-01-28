module 0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

