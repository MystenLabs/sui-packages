module 0x3f5ee642aeec6b6ad6b2237990629994733cac001bfc02865a0e1170925fdb3a::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x3f5ee642aeec6b6ad6b2237990629994733cac001bfc02865a0e1170925fdb3a::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x3f5ee642aeec6b6ad6b2237990629994733cac001bfc02865a0e1170925fdb3a::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

