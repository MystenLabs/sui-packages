module 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_admin {
    public fun onboard_market<T0>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::AdminCap, arg1: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::ensure_group_exists(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::emode_registry<T0>(arg1), arg2);
        0x2::transfer::public_share_object<0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_market::LeverageMarket>(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_market::new_market(*0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::id<T0>(arg1), arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

