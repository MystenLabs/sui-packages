module 0x954a51ec392f14e45a994d3a993e30264c151ada438d443c6af2f5a2070582b::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x954a51ec392f14e45a994d3a993e30264c151ada438d443c6af2f5a2070582b::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x954a51ec392f14e45a994d3a993e30264c151ada438d443c6af2f5a2070582b::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

