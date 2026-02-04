module 0xefa479281ee250c8a8eeac213648fd19c77e23d805d8b4ff618276aa628ce2be::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0xefa479281ee250c8a8eeac213648fd19c77e23d805d8b4ff618276aa628ce2be::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xefa479281ee250c8a8eeac213648fd19c77e23d805d8b4ff618276aa628ce2be::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

