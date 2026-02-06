module 0x96025a4db4083edf6f21d2c9f08f00b8d0d986f573cc4fbb75f696c904e3af43::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x96025a4db4083edf6f21d2c9f08f00b8d0d986f573cc4fbb75f696c904e3af43::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x96025a4db4083edf6f21d2c9f08f00b8d0d986f573cc4fbb75f696c904e3af43::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

