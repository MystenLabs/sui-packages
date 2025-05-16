module 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        price_object_addr: address,
    }

    struct SetBasePriceIdentifierRequest has store, key {
        id: 0x2::object::UID,
        price_object_addr: address,
        base_pyth_price_info_object_addr: address,
        request_time_ms: u64,
        is_executed: bool,
    }

    struct SetQuotePriceIdentifierRequest has store, key {
        id: 0x2::object::UID,
        price_object_addr: address,
        quote_pyth_price_info_object_addr: address,
        request_time_ms: u64,
        is_executed: bool,
    }

    struct SetMaxConfidenceRatioRequest has store, key {
        id: 0x2::object::UID,
        price_object_addr: address,
        max_confidence_ratio: u64,
        request_time_ms: u64,
        is_executed: bool,
    }

    struct PriceObject has store, key {
        id: 0x2::object::UID,
        base_asset: 0x1::type_name::TypeName,
        quote_asset: 0x1::type_name::TypeName,
        base_decimals: u8,
        quote_decimals: u8,
        base_price_identifier: vector<u8>,
        quote_price_identifier: vector<u8>,
        max_confidence_ratio: u64,
        time_lock_ms: u64,
        price: 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price::Price,
    }

    struct PriceObjectCreatedEvent has copy, drop {
        price_object_addr: address,
        base_asset: 0x1::type_name::TypeName,
        quote_asset: 0x1::type_name::TypeName,
        base_decimals: u8,
        quote_decimals: u8,
        base_price_identifier: vector<u8>,
        quote_price_identifier: vector<u8>,
        max_confidence_ratio: u64,
        time_lock_ms: u64,
    }

    struct BasePriceIdentifierChangedEvent has copy, drop {
        price_object_addr: address,
        old_base_price_identifier: vector<u8>,
        new_base_price_identifier: vector<u8>,
    }

    struct QuotePriceIdentifierChangedEvent has copy, drop {
        price_object_addr: address,
        old_quote_price_identifier: vector<u8>,
        new_quote_price_identifier: vector<u8>,
    }

    struct MinConfidenceRatioChangedEvent has copy, drop {
        price_object_addr: address,
        old_max_confidence_ratio: u64,
        new_max_confidence_ratio: u64,
    }

    struct UpdatedEvent has copy, drop {
        price_object_addr: address,
        old_price: u64,
        old_timestamp_ms: u64,
        new_price: u64,
        new_timestamp_ms: u64,
    }

    public fun new<T0, T1>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x2::coin::get_decimals<T0>(arg0);
        let v3 = 0x2::coin::get_decimals<T1>(arg1);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v4);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v5);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v7);
        let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v8);
        let v10 = 0x2::object::new(arg6);
        let v11 = 0x2::object::uid_to_address(&v10);
        let v12 = PriceObject{
            id                     : v10,
            base_asset             : v0,
            quote_asset            : v1,
            base_decimals          : v2,
            quote_decimals         : v3,
            base_price_identifier  : v6,
            quote_price_identifier : v9,
            max_confidence_ratio   : arg4,
            time_lock_ms           : arg5,
            price                  : 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price::new(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0), 0),
        };
        0x2::transfer::share_object<PriceObject>(v12);
        let v13 = AdminCap{
            id                : 0x2::object::new(arg6),
            price_object_addr : v11,
        };
        0x2::transfer::public_transfer<AdminCap>(v13, 0x2::tx_context::sender(arg6));
        let v14 = PriceObjectCreatedEvent{
            price_object_addr      : v11,
            base_asset             : v0,
            quote_asset            : v1,
            base_decimals          : v2,
            quote_decimals         : v3,
            base_price_identifier  : v6,
            quote_price_identifier : v9,
            max_confidence_ratio   : arg4,
            time_lock_ms           : arg5,
        };
        0x2::event::emit<PriceObjectCreatedEvent>(v14);
        v11
    }

    public fun get_price(arg0: &PriceObject) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price::get_price(arg0.price)
    }

    public fun get_timestamp_ms(arg0: &PriceObject) : u64 {
        0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price::get_timestamp_ms(arg0.price)
    }

    public fun get_base_asset(arg0: &PriceObject) : 0x1::type_name::TypeName {
        arg0.base_asset
    }

    public fun get_quote_asset(arg0: &PriceObject) : 0x1::type_name::TypeName {
        arg0.quote_asset
    }

    fun parse_price_to_decimal(arg0: u64, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg1)) {
            0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg0), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0x2::math::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&arg1) as u8))))
        } else {
            0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg0), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0x2::math::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&arg1) as u8))))
        }
    }

    public fun request_to_set_base_price_identifier(arg0: &AdminCap, arg1: &mut PriceObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : SetBasePriceIdentifierRequest {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg1), 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::EForbidden());
        SetBasePriceIdentifierRequest{
            id                               : 0x2::object::new(arg4),
            price_object_addr                : 0x2::object::id_address<PriceObject>(arg1),
            base_pyth_price_info_object_addr : 0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2),
            request_time_ms                  : 0x2::clock::timestamp_ms(arg3),
            is_executed                      : false,
        }
    }

    public fun request_to_set_max_confidence_ratio(arg0: &AdminCap, arg1: &mut PriceObject, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : SetMaxConfidenceRatioRequest {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg1), 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::EForbidden());
        SetMaxConfidenceRatioRequest{
            id                   : 0x2::object::new(arg4),
            price_object_addr    : 0x2::object::id_address<PriceObject>(arg1),
            max_confidence_ratio : arg2,
            request_time_ms      : 0x2::clock::timestamp_ms(arg3),
            is_executed          : false,
        }
    }

    public fun request_to_set_quote_price_identifier(arg0: &AdminCap, arg1: &mut PriceObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : SetQuotePriceIdentifierRequest {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg1), 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::EForbidden());
        SetQuotePriceIdentifierRequest{
            id                                : 0x2::object::new(arg4),
            price_object_addr                 : 0x2::object::id_address<PriceObject>(arg1),
            quote_pyth_price_info_object_addr : 0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2),
            request_time_ms                   : 0x2::clock::timestamp_ms(arg3),
            is_executed                       : false,
        }
    }

    public fun set_base_price_identifier(arg0: &AdminCap, arg1: &mut SetBasePriceIdentifierRequest, arg2: &mut PriceObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg2), 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::EForbidden());
        assert!(!arg1.is_executed, 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::ERequestExecuted());
        assert!(0x2::clock::timestamp_ms(arg4) >= arg1.request_time_ms + arg2.time_lock_ms, 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::EExecuteTooEarly());
        assert!(arg1.price_object_addr == 0x2::object::id_address<PriceObject>(arg2) && arg1.base_pyth_price_info_object_addr == 0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3), 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::ERequestInfoMismatch());
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1);
        arg2.base_price_identifier = v2;
        arg1.is_executed = true;
        let v3 = BasePriceIdentifierChangedEvent{
            price_object_addr         : arg1.price_object_addr,
            old_base_price_identifier : arg2.base_price_identifier,
            new_base_price_identifier : v2,
        };
        0x2::event::emit<BasePriceIdentifierChangedEvent>(v3);
    }

    public fun set_max_confidence_ratio(arg0: &AdminCap, arg1: &mut SetMaxConfidenceRatioRequest, arg2: &mut PriceObject, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg2), 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::EForbidden());
        assert!(!arg1.is_executed, 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::ERequestExecuted());
        assert!(0x2::clock::timestamp_ms(arg4) >= arg1.request_time_ms + arg2.time_lock_ms, 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::EExecuteTooEarly());
        assert!(arg1.price_object_addr == 0x2::object::id_address<PriceObject>(arg2) && arg1.max_confidence_ratio == arg3, 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::ERequestInfoMismatch());
        arg2.max_confidence_ratio = arg3;
        arg1.is_executed = true;
        let v0 = MinConfidenceRatioChangedEvent{
            price_object_addr        : arg0.price_object_addr,
            old_max_confidence_ratio : arg2.max_confidence_ratio,
            new_max_confidence_ratio : arg3,
        };
        0x2::event::emit<MinConfidenceRatioChangedEvent>(v0);
    }

    public fun set_quote_price_identifier(arg0: &AdminCap, arg1: &mut SetQuotePriceIdentifierRequest, arg2: &mut PriceObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg2), 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::EForbidden());
        assert!(!arg1.is_executed, 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::ERequestExecuted());
        assert!(0x2::clock::timestamp_ms(arg4) >= arg1.request_time_ms + arg2.time_lock_ms, 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::EExecuteTooEarly());
        assert!(arg1.price_object_addr == 0x2::object::id_address<PriceObject>(arg2) && arg1.quote_pyth_price_info_object_addr == 0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3), 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::ERequestInfoMismatch());
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1);
        arg2.quote_price_identifier = v2;
        arg1.is_executed = true;
        let v3 = QuotePriceIdentifierChangedEvent{
            price_object_addr          : arg1.price_object_addr,
            old_quote_price_identifier : arg2.quote_price_identifier,
            new_quote_price_identifier : v2,
        };
        0x2::event::emit<QuotePriceIdentifierChangedEvent>(v3);
    }

    public fun update(arg0: &mut PriceObject, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let (v0, v1) = validate_and_get_price_and_timestamp_ms(arg0.base_price_identifier, arg1, arg0.max_confidence_ratio);
        let v2 = v0;
        let (v3, v4) = validate_and_get_price_and_timestamp_ms(arg0.quote_price_identifier, arg2, arg0.max_confidence_ratio);
        let v5 = v3;
        assert!(!0x1::option::is_none<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(&v2) && !0x1::option::is_none<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(&v5), 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::EPricesInvalid());
        let v6 = 0x2::math::min(v1, v4);
        let v7 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(*0x1::option::borrow<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(&v2), *0x1::option::borrow<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(&v5)), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from((arg0.base_decimals as u64))), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from((arg0.quote_decimals as u64)));
        arg0.price = 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price::new(v7, v6);
        let v8 = UpdatedEvent{
            price_object_addr : 0x2::object::id_address<PriceObject>(arg0),
            old_price         : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(get_price(arg0)),
            old_timestamp_ms  : get_timestamp_ms(arg0),
            new_price         : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v7),
            new_timestamp_ms  : v6,
        };
        0x2::event::emit<UpdatedEvent>(v8);
    }

    public fun validate_and_get_price_and_timestamp_ms(arg0: vector<u8>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64) : (0x1::option::Option<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1) == arg0, 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors::EPriceInfoObjectMismatch());
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v2) * 10000 / arg2 <= v4) {
            return (0x1::option::some<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(parse_price_to_decimal(v4, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2))), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v2) * 1000)
        };
        (0x1::option::none<0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal>(), 0)
    }

    // decompiled from Move bytecode v6
}

