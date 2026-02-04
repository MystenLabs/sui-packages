module 0x45ae4a3f60fa3fcf544c69fdaad9f99821064cac55ceac3af7d8b60daddcdd5::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x45ae4a3f60fa3fcf544c69fdaad9f99821064cac55ceac3af7d8b60daddcdd5::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x45ae4a3f60fa3fcf544c69fdaad9f99821064cac55ceac3af7d8b60daddcdd5::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

