module 0x4d68f20031df38e37dbd10e99b3a40fe9251db4f1a7e8d63c8e9ac8f1b61ad97::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x4d68f20031df38e37dbd10e99b3a40fe9251db4f1a7e8d63c8e9ac8f1b61ad97::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x4d68f20031df38e37dbd10e99b3a40fe9251db4f1a7e8d63c8e9ac8f1b61ad97::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

