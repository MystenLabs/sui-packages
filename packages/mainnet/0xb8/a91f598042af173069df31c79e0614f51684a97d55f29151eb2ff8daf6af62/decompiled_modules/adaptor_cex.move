module 0xb8a91f598042af173069df31c79e0614f51684a97d55f29151eb2ff8daf6af62::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0xb8a91f598042af173069df31c79e0614f51684a97d55f29151eb2ff8daf6af62::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xb8a91f598042af173069df31c79e0614f51684a97d55f29151eb2ff8daf6af62::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

