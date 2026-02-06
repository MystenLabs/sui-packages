module 0xcb0613946b94831d37f4b20323190ebb620a7a0b2d9955ec9543cdbda621948c::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0xcb0613946b94831d37f4b20323190ebb620a7a0b2d9955ec9543cdbda621948c::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xcb0613946b94831d37f4b20323190ebb620a7a0b2d9955ec9543cdbda621948c::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

