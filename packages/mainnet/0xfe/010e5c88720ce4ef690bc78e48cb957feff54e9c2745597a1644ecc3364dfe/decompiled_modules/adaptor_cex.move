module 0xfe010e5c88720ce4ef690bc78e48cb957feff54e9c2745597a1644ecc3364dfe::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0xfe010e5c88720ce4ef690bc78e48cb957feff54e9c2745597a1644ecc3364dfe::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xfe010e5c88720ce4ef690bc78e48cb957feff54e9c2745597a1644ecc3364dfe::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

