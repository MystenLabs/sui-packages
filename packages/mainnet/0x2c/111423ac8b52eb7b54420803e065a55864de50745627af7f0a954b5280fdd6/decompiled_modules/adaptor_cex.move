module 0x2c111423ac8b52eb7b54420803e065a55864de50745627af7f0a954b5280fdd6::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x2c111423ac8b52eb7b54420803e065a55864de50745627af7f0a954b5280fdd6::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x2c111423ac8b52eb7b54420803e065a55864de50745627af7f0a954b5280fdd6::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 100, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

