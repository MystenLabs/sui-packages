module 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher {
    struct PriceOracleConfig has store, key {
        id: 0x2::object::UID,
        price_fluctuation_threshold: 0x2::table::Table<0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>,
        last_fetched_price: 0x2::table::Table<0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>,
    }

    struct PriceTicket<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    struct PriceVoucher<phantom T0: drop> {
        underlying_price: u128,
    }

    public fun generate_price_ticket<T0: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg0, 0x2::tx_context::sender(arg1), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::acl_invalid_permission());
        let v0 = PriceTicket<T0>{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PriceTicket<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun generate_price_voucher<T0: drop>(arg0: &mut PriceOracleConfig, arg1: &PriceTicket<T0>, arg2: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg3: &0x2::tx_context::TxContext) : PriceVoucher<T0> {
        assert!(is_price_fluctuation_within_threshold<T0>(arg0, arg2), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::price_fluctuation_too_large());
        PriceVoucher<T0>{underlying_price: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::get_raw_value(arg2)}
    }

    public fun get_price<T0: drop>(arg0: PriceVoucher<T0>, arg1: &0x2::tx_context::TxContext) : u128 {
        let PriceVoucher { underlying_price: v0 } = arg0;
        v0
    }

    public fun get_price_fluctuation_threshold<T0: drop>(arg0: &PriceOracleConfig) : 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&arg0.price_fluctuation_threshold, v0)) {
            0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_raw_value(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::value(0x2::table::borrow<0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&arg0.price_fluctuation_threshold, v0)))
        } else {
            0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_rational(1, 100)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracleConfig{
            id                          : 0x2::object::new(arg0),
            price_fluctuation_threshold : 0x2::table::new<0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(arg0),
            last_fetched_price          : 0x2::table::new<0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(arg0),
        };
        0x2::transfer::share_object<PriceOracleConfig>(v0);
    }

    public fun is_price_fluctuation_within_threshold<T0: drop>(arg0: &mut PriceOracleConfig, arg1: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64) : bool {
        let v0 = get_price_fluctuation_threshold<T0>(arg0);
        if (0x2::table::contains<0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&arg0.last_fetched_price, 0x1::type_name::get<T0>())) {
            let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&mut arg0.last_fetched_price, 0x1::type_name::get<T0>());
            let v2 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_raw_value(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::value(v1));
            if (0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::greater(arg1, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::multiply(v2, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::add(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::one(), v0))) || 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::less(arg1, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::multiply(v2, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::sub(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::one(), v0)))) {
                return false
            };
            0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::set_value(v1, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::get_raw_value(arg1));
        } else {
            0x2::table::add<0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&mut arg0.last_fetched_price, 0x1::type_name::get<T0>(), arg1);
        };
        true
    }

    public fun set_price_fluctuation_threshold<T0: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg1: &mut PriceOracleConfig, arg2: u128, arg3: &0x2::tx_context::TxContext) {
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg0, 0x2::tx_context::sender(arg3), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::acl_invalid_permission());
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&arg1.price_fluctuation_threshold, v0)) {
            0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::set_value(0x2::table::borrow_mut<0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&mut arg1.price_fluctuation_threshold, v0), arg2);
        } else {
            0x2::table::add<0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&mut arg1.price_fluctuation_threshold, v0, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_raw_value(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

