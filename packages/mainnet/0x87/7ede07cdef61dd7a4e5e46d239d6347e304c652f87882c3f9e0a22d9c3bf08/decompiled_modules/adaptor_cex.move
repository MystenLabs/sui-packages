module 0x877ede07cdef61dd7a4e5e46d239d6347e304c652f87882c3f9e0a22d9c3bf08::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x877ede07cdef61dd7a4e5e46d239d6347e304c652f87882c3f9e0a22d9c3bf08::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x877ede07cdef61dd7a4e5e46d239d6347e304c652f87882c3f9e0a22d9c3bf08::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

