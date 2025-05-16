module 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::utils {
    public fun fetch_prices<T0, T1>(arg0: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg1: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg2: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg3: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg4: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg5: &0x2::clock::Clock) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        let v0 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_base_asset<T0, T1>(arg0);
        let v1 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_quote_asset<T0, T1>(arg0);
        let v2 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_pricing_asset<T0, T1>(arg0);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::validate_price_object(v0, v2, arg1);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::validate_price_object(v1, v2, arg2);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::validate_ref_price_object(v0, v2, arg3);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::validate_ref_price_object(v1, v2, arg4);
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = v3 - 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_max_price_staleness_ms<T0, T1>(arg0);
        let v5 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::get_price_not_older_than(arg1, v0, v2, v4, arg5);
        let v6 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::get_price_not_older_than(arg2, v1, v2, v4, arg5);
        let v7 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::get_ref_price_not_older_than(arg3, v0, v2, v3, arg5);
        let v8 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::get_ref_price_not_older_than(arg4, v1, v2, v3, arg5);
        let v9 = if (0x1::option::is_some<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(&v5)) {
            if (0x1::option::is_some<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(&v6)) {
                if (0x1::option::is_some<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(&v7)) {
                    0x1::option::is_some<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(&v8)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v9, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPriceInvalid());
        (*0x1::option::borrow<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(&v5), *0x1::option::borrow<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(&v6), *0x1::option::borrow<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(&v7), *0x1::option::borrow<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(&v8))
    }

    // decompiled from Move bytecode v6
}

