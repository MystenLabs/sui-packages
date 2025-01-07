module 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::coin_decimals {
    struct Decimals has store {
        decimals: u8,
        scalar: u64,
    }

    struct CoinDecimals has store, key {
        id: 0x2::object::UID,
    }

    public fun add<T0>(arg0: &mut CoinDecimals, arg1: &0x2::coin::CoinMetadata<T0>) {
        if (contains<T0>(arg0)) {
            return
        };
        let v0 = 0x2::coin::get_decimals<T0>(arg1);
        let v1 = Decimals{
            decimals : v0,
            scalar   : 0x2::math::pow(10, v0),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, Decimals>(&mut arg0.id, 0x1::type_name::get<T0>(), v1);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : CoinDecimals {
        CoinDecimals{id: 0x2::object::new(arg0)}
    }

    public fun contains<T0>(arg0: &CoinDecimals) : bool {
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun decimals<T0>(arg0: &CoinDecimals) : u8 {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, Decimals>(&arg0.id, 0x1::type_name::get<T0>()).decimals
    }

    public fun scalar<T0>(arg0: &CoinDecimals) : u64 {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, Decimals>(&arg0.id, 0x1::type_name::get<T0>()).scalar
    }

    // decompiled from Move bytecode v6
}

