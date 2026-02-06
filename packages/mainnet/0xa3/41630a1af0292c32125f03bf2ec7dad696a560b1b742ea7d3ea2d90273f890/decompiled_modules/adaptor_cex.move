module 0xa341630a1af0292c32125f03bf2ec7dad696a560b1b742ea7d3ea2d90273f890::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0xa341630a1af0292c32125f03bf2ec7dad696a560b1b742ea7d3ea2d90273f890::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xa341630a1af0292c32125f03bf2ec7dad696a560b1b742ea7d3ea2d90273f890::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

