module 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config {
    struct PoolAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        config_addr: address,
    }

    struct PoolConfig<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        base_asset: 0x1::type_name::TypeName,
        quote_asset: 0x1::type_name::TypeName,
        pricing_asset: 0x1::type_name::TypeName,
        is_paused: bool,
        min_fee_rate: u64,
        protocol_fee_share: u64,
        safe_price_diff_ratio: u64,
        max_price_diff_ratio: u64,
        base_max_reserve: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        quote_max_reserve: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        base_min_amount_in: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        base_max_amount_in: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        quote_min_amount_in: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        quote_max_amount_in: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        min_deposit_time_ms: u64,
        min_trade_interval_ms: u64,
        max_price_staleness_ms: u64,
        base_price_object_addr: address,
        quote_price_object_addr: address,
        base_ref_price_object_addr: address,
        quote_ref_price_object_addr: address,
    }

    struct PoolConfigCreatedEvent<phantom T0, phantom T1> has copy, drop {
        config_addr: address,
        base_asset: 0x1::type_name::TypeName,
        quote_asset: 0x1::type_name::TypeName,
        pricing_asset: 0x1::type_name::TypeName,
        min_fee_rate: u64,
        protocol_fee_share: u64,
        safe_price_diff_ratio: u64,
        max_price_diff_ratio: u64,
        min_deposit_time_ms: u64,
        base_price_object_addr: address,
        quote_price_object_addr: address,
        base_ref_price_object_addr: address,
        quote_ref_price_object_addr: address,
        sender: address,
    }

    public(friend) fun new<T0, T1>(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg8: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg9: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg10: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg11: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::validate_price_object(v0, arg0, arg7);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::validate_price_object(v1, arg0, arg8);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::validate_ref_price_object(v0, arg0, arg9);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::validate_ref_price_object(v1, arg0, arg10);
        let v2 = if (0x1::option::is_some<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(arg7)) {
            0x2::object::id_address<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(0x1::option::borrow<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(arg7))
        } else {
            @0x0
        };
        let v3 = if (0x1::option::is_some<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(arg8)) {
            0x2::object::id_address<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(0x1::option::borrow<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(arg8))
        } else {
            @0x0
        };
        let v4 = if (0x1::option::is_some<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(arg9)) {
            0x2::object::id_address<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(0x1::option::borrow<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(arg9))
        } else {
            @0x0
        };
        let v5 = if (0x1::option::is_some<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(arg10)) {
            0x2::object::id_address<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(0x1::option::borrow<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(arg10))
        } else {
            @0x0
        };
        let v6 = 0x2::object::new(arg11);
        let v7 = 0x2::object::uid_to_address(&v6);
        let v8 = PoolConfig<T0, T1>{
            id                          : v6,
            base_asset                  : v0,
            quote_asset                 : v1,
            pricing_asset               : arg0,
            is_paused                   : false,
            min_fee_rate                : arg1,
            protocol_fee_share          : arg2,
            safe_price_diff_ratio       : arg3,
            max_price_diff_ratio        : arg4,
            base_max_reserve            : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::max_decimal(),
            quote_max_reserve           : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::max_decimal(),
            base_min_amount_in          : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            base_max_amount_in          : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::max_decimal(),
            quote_min_amount_in         : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            quote_max_amount_in         : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::max_decimal(),
            min_deposit_time_ms         : arg5,
            min_trade_interval_ms       : 0,
            max_price_staleness_ms      : arg6,
            base_price_object_addr      : v2,
            quote_price_object_addr     : v3,
            base_ref_price_object_addr  : v4,
            quote_ref_price_object_addr : v5,
        };
        0x2::transfer::share_object<PoolConfig<T0, T1>>(v8);
        let v9 = PoolAdminCap<T0, T1>{
            id          : 0x2::object::new(arg11),
            config_addr : v7,
        };
        0x2::transfer::public_transfer<PoolAdminCap<T0, T1>>(v9, 0x2::tx_context::sender(arg11));
        let v10 = PoolConfigCreatedEvent<T0, T1>{
            config_addr                 : v7,
            base_asset                  : v0,
            quote_asset                 : v1,
            pricing_asset               : arg0,
            min_fee_rate                : arg1,
            protocol_fee_share          : arg2,
            safe_price_diff_ratio       : arg3,
            max_price_diff_ratio        : arg4,
            min_deposit_time_ms         : arg5,
            base_price_object_addr      : v2,
            quote_price_object_addr     : v3,
            base_ref_price_object_addr  : v4,
            quote_ref_price_object_addr : v5,
            sender                      : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<PoolConfigCreatedEvent<T0, T1>>(v10);
        v7
    }

    public fun get_base_amount_in_range<T0, T1>(arg0: &PoolConfig<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        (arg0.base_min_amount_in, arg0.base_max_amount_in)
    }

    public fun get_base_asset<T0, T1>(arg0: &PoolConfig<T0, T1>) : 0x1::type_name::TypeName {
        arg0.base_asset
    }

    public fun get_base_price_object_addr<T0, T1>(arg0: &PoolConfig<T0, T1>) : address {
        arg0.base_price_object_addr
    }

    public fun get_base_ref_price_object_addr<T0, T1>(arg0: &PoolConfig<T0, T1>) : address {
        arg0.base_ref_price_object_addr
    }

    public fun get_max_price_diff_ratio<T0, T1>(arg0: &PoolConfig<T0, T1>) : u64 {
        arg0.max_price_diff_ratio
    }

    public fun get_max_price_staleness_ms<T0, T1>(arg0: &PoolConfig<T0, T1>) : u64 {
        arg0.max_price_staleness_ms
    }

    public fun get_max_reserves<T0, T1>(arg0: &PoolConfig<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        (arg0.base_max_reserve, arg0.quote_max_reserve)
    }

    public fun get_min_deposit_time_ms<T0, T1>(arg0: &PoolConfig<T0, T1>) : u64 {
        arg0.min_deposit_time_ms
    }

    public fun get_min_fee_rate<T0, T1>(arg0: &PoolConfig<T0, T1>) : u64 {
        arg0.min_fee_rate
    }

    public fun get_min_trade_interval_ms<T0, T1>(arg0: &PoolConfig<T0, T1>) : u64 {
        arg0.min_trade_interval_ms
    }

    public fun get_pricing_asset<T0, T1>(arg0: &PoolConfig<T0, T1>) : 0x1::type_name::TypeName {
        arg0.pricing_asset
    }

    public fun get_protocol_fee_share<T0, T1>(arg0: &PoolConfig<T0, T1>) : u64 {
        arg0.protocol_fee_share
    }

    public fun get_quote_amount_in_range<T0, T1>(arg0: &PoolConfig<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        (arg0.quote_min_amount_in, arg0.quote_max_amount_in)
    }

    public fun get_quote_asset<T0, T1>(arg0: &PoolConfig<T0, T1>) : 0x1::type_name::TypeName {
        arg0.quote_asset
    }

    public fun get_quote_price_object_addr<T0, T1>(arg0: &PoolConfig<T0, T1>) : address {
        arg0.quote_price_object_addr
    }

    public fun get_quote_ref_price_object_addr<T0, T1>(arg0: &PoolConfig<T0, T1>) : address {
        arg0.quote_ref_price_object_addr
    }

    public fun get_safe_price_diff_ratio<T0, T1>(arg0: &PoolConfig<T0, T1>) : u64 {
        arg0.safe_price_diff_ratio
    }

    public fun is_paused<T0, T1>(arg0: &PoolConfig<T0, T1>) : bool {
        arg0.is_paused
    }

    public fun pause_or_resume<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        arg1.is_paused = !arg1.is_paused;
    }

    public fun set_base_amount_in_range<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: u64, arg3: u64) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        arg1.base_min_amount_in = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg2);
        arg1.base_max_amount_in = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg3);
    }

    public fun set_base_price_object_addr<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::validate_price_object(arg1.base_asset, arg1.pricing_asset, arg2);
        let v0 = if (0x1::option::is_some<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(arg2)) {
            0x2::object::id_address<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(0x1::option::borrow<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(arg2))
        } else {
            @0x0
        };
        arg1.base_price_object_addr = v0;
    }

    public fun set_base_ref_price_object_addr<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::validate_ref_price_object(arg1.base_asset, arg1.pricing_asset, arg2);
        let v0 = if (0x1::option::is_some<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(arg2)) {
            0x2::object::id_address<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(0x1::option::borrow<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(arg2))
        } else {
            @0x0
        };
        arg1.base_ref_price_object_addr = v0;
    }

    public fun set_max_price_diff_ratio<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: u64) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        arg1.max_price_diff_ratio = arg2;
    }

    public fun set_max_price_staleness_ms<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: u64) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        arg1.max_price_staleness_ms = arg2;
    }

    public fun set_max_reserves<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: u64, arg3: u64) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        arg1.base_max_reserve = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg2);
        arg1.quote_max_reserve = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg3);
    }

    public fun set_min_deposit_time_ms<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: u64) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        arg1.min_deposit_time_ms = arg2;
    }

    public fun set_min_fee_rate<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: u64) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        arg1.min_fee_rate = arg2;
    }

    public fun set_min_trade_interval_ms<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: u64) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        arg1.min_trade_interval_ms = arg2;
    }

    public fun set_protocol_fee_share<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: u64) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        arg1.protocol_fee_share = arg2;
    }

    public fun set_quote_amount_in_range<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: u64, arg3: u64) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        arg1.quote_min_amount_in = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg2);
        arg1.quote_max_amount_in = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg3);
    }

    public fun set_quote_price_object_addr<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::validate_price_object(arg1.quote_asset, arg1.pricing_asset, arg2);
        let v0 = if (0x1::option::is_some<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(arg2)) {
            0x2::object::id_address<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(0x1::option::borrow<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>(arg2))
        } else {
            @0x0
        };
        arg1.quote_price_object_addr = v0;
    }

    public fun set_quote_ref_price_object_addr<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::validate_ref_price_object(arg1.quote_asset, arg1.pricing_asset, arg2);
        let v0 = if (0x1::option::is_some<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(arg2)) {
            0x2::object::id_address<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(0x1::option::borrow<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>(arg2))
        } else {
            @0x0
        };
        arg1.quote_ref_price_object_addr = v0;
    }

    public fun set_safe_price_diff_ratio<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: &mut PoolConfig<T0, T1>, arg2: u64) {
        assert!(arg0.config_addr == 0x2::object::id_address<PoolConfig<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        arg1.safe_price_diff_ratio = arg2;
    }

    // decompiled from Move bytecode v6
}

