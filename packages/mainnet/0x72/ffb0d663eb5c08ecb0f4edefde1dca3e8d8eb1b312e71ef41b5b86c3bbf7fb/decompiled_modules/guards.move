module 0x72ffb0d663eb5c08ecb0f4edefde1dca3e8d8eb1b312e71ef41b5b86c3bbf7fb::guards {
    public fun assert_debt_amount(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 901);
    }

    public fun assert_debt_at_least<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, arg1));
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v0)) {
            let v3 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v0, v2);
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_reserve_array_index(v3) == arg2) {
                v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_borrowed_amount(v3));
                break
            };
            v2 = v2 + 1;
        };
        assert_debt_amount(v1, arg3);
    }

    public fun assert_debt_scaled_at_least<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u256) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v0)) {
            let v2 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v0, v1);
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_reserve_array_index(v2) == arg2) {
                assert_scaled_amount(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_borrowed_amount(v2)), arg3);
                return
            };
            v1 = v1 + 1;
        };
        abort 901
    }

    public fun assert_scaled_amount(arg0: u256, arg1: u256) {
        assert!(arg0 >= arg1, 901);
    }

    public fun assert_settlement(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 <= arg2, 902);
        assert!(arg0 >= arg1, 903);
        assert!(arg0 - arg1 >= arg3, 903);
    }

    // decompiled from Move bytecode v7
}

