module 0xb2b5014d37dbcb5aff29d74cf356f29f200876b352c30d43d0abc54b978c088f::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        exchange_rates: 0x2::table::Table<0x1::type_name::TypeName, u128>,
        types: vector<0x1::type_name::TypeName>,
    }

    public fun calculate_current_liquidity_denominated_in_sui<T0>(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>, arg1: &Registry) : u64 {
        let v0 = vector[];
        let v1 = arg1.types;
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
            0x1::vector::push_back<u64>(&mut v0, 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::multiply_and_divide(0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::balance(0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::borrow<T0>(arg0, v3)), *exchange_rate(arg1, v3), 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::exchange_rate_one_to_one()));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v1);
        sum(v0)
    }

    public fun coin_to_meta_coin_exchange_rate<T0, T1>(arg0: &Registry, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>) : u128 {
        multiply_by(*exchange_rate(arg0, 0x1::type_name::get<T1>()), sui_to_meta_coin_exchange_rate<T0>(arg0, arg1))
    }

    fun create(arg0: &REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id             : 0x2::object::new(arg1),
            exchange_rates : 0x2::table::new<0x1::type_name::TypeName, u128>(arg1),
            types          : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        let v1 = 0x1::type_name::get<0x2::sui::SUI>();
        0x2::table::add<0x1::type_name::TypeName, u128>(&mut v0.exchange_rates, v1, 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::exchange_rate_one_to_one());
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.types, v1);
        0x2::transfer::share_object<Registry>(v0);
    }

    fun divide_by(arg0: u64, arg1: u64) : u128 {
        if (arg1 == 0) {
            return (0 as u128)
        };
        (0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::multiply_and_divide(arg0, 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::exchange_rate_one_to_one(), (arg1 as u128)) as u128)
    }

    public fun exchange_rate(arg0: &Registry, arg1: 0x1::type_name::TypeName) : &u128 {
        assert!(is_tracking_type_name(arg0, arg1), 9223372487826407426);
        0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg0.exchange_rates, arg1)
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        create(&arg0, arg1);
        0x2::package::claim_and_keep<REGISTRY>(arg0, arg1);
    }

    public fun is_tracking_type<T0>(arg0: &Registry) : bool {
        is_tracking_type_name(arg0, 0x1::type_name::get<T0>())
    }

    public fun is_tracking_type_name(arg0: &Registry, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, u128>(&arg0.exchange_rates, arg1)
    }

    public fun meta_coin_to_sui_exchange_rate<T0>(arg0: &Registry, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>) : u128 {
        divide_by(calculate_current_liquidity_denominated_in_sui<T0>(arg1, arg0), 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::supply_value<T0>(arg1))
    }

    fun multiply_by(arg0: u128, arg1: u128) : u128 {
        arg0 * arg1 / 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::exchange_rate_one_to_one()
    }

    public fun sui_to_meta_coin_exchange_rate<T0>(arg0: &Registry, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>) : u128 {
        divide_by(0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::supply_value<T0>(arg1), calculate_current_liquidity_denominated_in_sui<T0>(arg1, arg0))
    }

    fun sum(arg0: vector<u64>) : u64 {
        let v0 = 0;
        0x1::vector::reverse<u64>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut arg0);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
        v0
    }

    public fun update_exchange_rate<T0>(arg0: &0x2::object::UID, arg1: &mut Registry, arg2: u128) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::assert_app_is_authorized(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u128>(&arg1.exchange_rates, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u128>(&mut arg1.exchange_rates, v0) = arg2;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg1.exchange_rates, v0, arg2);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.types, v0);
        };
    }

    // decompiled from Move bytecode v6
}

