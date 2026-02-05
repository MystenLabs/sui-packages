module 0x84a21ab6dc6db54d7ba68de6ab4bbd13cb719321fc9f83e5a1fa46d870d610f0::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0x84a21ab6dc6db54d7ba68de6ab4bbd13cb719321fc9f83e5a1fa46d870d610f0::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x84a21ab6dc6db54d7ba68de6ab4bbd13cb719321fc9f83e5a1fa46d870d610f0::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

