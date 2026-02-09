module 0x7534ad074ad457886160dc5193e2af3be0af93d299c3e7fabe6eb29b9ebc49d::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x7534ad074ad457886160dc5193e2af3be0af93d299c3e7fabe6eb29b9ebc49d::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x7534ad074ad457886160dc5193e2af3be0af93d299c3e7fabe6eb29b9ebc49d::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

