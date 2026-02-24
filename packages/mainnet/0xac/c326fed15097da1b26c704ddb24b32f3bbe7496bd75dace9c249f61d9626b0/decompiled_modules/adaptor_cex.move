module 0xacc326fed15097da1b26c704ddb24b32f3bbe7496bd75dace9c249f61d9626b0::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0xacc326fed15097da1b26c704ddb24b32f3bbe7496bd75dace9c249f61d9626b0::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xacc326fed15097da1b26c704ddb24b32f3bbe7496bd75dace9c249f61d9626b0::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

