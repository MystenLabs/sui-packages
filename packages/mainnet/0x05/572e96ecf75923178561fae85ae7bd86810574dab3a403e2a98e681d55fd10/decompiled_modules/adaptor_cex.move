module 0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

