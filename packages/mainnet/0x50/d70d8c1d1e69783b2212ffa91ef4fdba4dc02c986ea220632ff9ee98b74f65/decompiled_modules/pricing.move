module 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing {
    public fun get_price(arg0: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, u64) {
        let v0 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (arg1 != arg2) {
            assert!(0x1::option::is_some<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(arg0), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPriceObjectInvalid());
            let v2 = 0x1::option::borrow<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(arg0);
            let v3 = 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::get_base_asset(v2);
            let v4 = 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::get_quote_asset(v2);
            assert!(arg1 == v3 && arg2 == v4 || arg1 == v4 && arg2 == v3, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPriceAssetsMismatch());
            let v5 = 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::get_price(v2);
            v0 = v5;
            v1 = 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::get_timestamp_ms(v2);
            if (arg1 == v4) {
                v0 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(1), v5);
            };
        };
        (v0, v1)
    }

    public(friend) fun get_price_diff_ratio(arg0: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) : u64 {
        if (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::gt(arg0, arg1)) {
            return 0
        };
        0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(arg0, arg1), arg0)) * 10000
    }

    public fun get_price_not_older_than(arg0: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: &0x2::clock::Clock) : 0x1::option::Option<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal> {
        let (v0, v1) = get_price(arg0, arg1, arg2, arg4);
        if (v1 < arg3) {
            0x1::option::none<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>()
        } else {
            0x1::option::some<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(v0)
        }
    }

    public fun get_ref_price(arg0: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, u64) {
        let v0 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (arg1 != arg2) {
            assert!(0x1::option::is_some<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(arg0), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPriceObjectInvalid());
            let v2 = 0x1::option::borrow<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(arg0);
            let v3 = 0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::get_base_asset(v2);
            let v4 = 0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::get_quote_asset(v2);
            assert!(arg1 == v3 && arg2 == v4 || arg1 == v4 && arg2 == v3, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPriceAssetsMismatch());
            let v5 = 0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::get_price(v2);
            v0 = v5;
            v1 = 0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::get_timestamp_ms(v2);
            if (arg1 == v4) {
                v0 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(1), v5);
            };
        };
        (v0, v1)
    }

    public fun get_ref_price_not_older_than(arg0: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: &0x2::clock::Clock) : 0x1::option::Option<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal> {
        let (v0, v1) = get_ref_price(arg0, arg1, arg2, arg4);
        if (v1 < arg3) {
            0x1::option::none<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>()
        } else {
            0x1::option::some<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(v0)
        }
    }

    public(friend) fun validate_price_object(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>) {
        if (0x1::option::is_none<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(arg2)) {
            assert!(arg0 == arg1, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPriceObjectInvalid());
        } else {
            let v0 = 0x1::option::borrow<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(arg2);
            assert!(0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::get_base_asset(v0) == arg0 && 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::get_quote_asset(v0) == arg1, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPriceObjectInvalid());
        };
    }

    public(friend) fun validate_ref_price_object(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>) {
        if (0x1::option::is_none<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(arg2)) {
            assert!(arg0 == arg1, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPriceObjectInvalid());
        } else {
            let v0 = 0x1::option::borrow<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(arg2);
            assert!(0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::get_base_asset(v0) == arg0 && 0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::get_quote_asset(v0) == arg1, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPriceObjectInvalid());
        };
    }

    // decompiled from Move bytecode v6
}

