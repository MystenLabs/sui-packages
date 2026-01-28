module 0xc7be60e19a1313724e11f339b0b49a34926905d1d09da89e99932882fc62066e::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0xc7be60e19a1313724e11f339b0b49a34926905d1d09da89e99932882fc62066e::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc7be60e19a1313724e11f339b0b49a34926905d1d09da89e99932882fc62066e::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

