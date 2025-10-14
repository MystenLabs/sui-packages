module 0x42a19100d8ff8673a491aa410a01773c8515138e6d1aae92b9f41ae307de88a4::suilend_integration {
    public fun borrow_fee_zero_reserve_config(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::ReserveConfig) {
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::borrow_fee(arg0)) == 0, 0);
    }

    public fun nothing() {
    }

    // decompiled from Move bytecode v6
}

