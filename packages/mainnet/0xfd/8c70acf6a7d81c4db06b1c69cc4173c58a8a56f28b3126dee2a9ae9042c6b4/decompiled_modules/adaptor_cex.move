module 0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

