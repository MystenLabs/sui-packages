module 0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::decimals_admin {
    struct CoinDecimalsRegistered has copy, drop {
        registry: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
    }

    public fun register_decimals<T0>(arg0: &0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::app::AdminCap, arg1: &mut 0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>) {
        let v0 = CoinDecimalsRegistered{
            registry  : 0x2::object::id<0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::coin_decimals_registry::CoinDecimalsRegistry>(arg1),
            coin_type : 0x1::type_name::get<T0>(),
            decimals  : 0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::coin_decimals_registry::register_decimals<T0>(arg1, arg2),
        };
        0x2::event::emit<CoinDecimalsRegistered>(v0);
    }

    // decompiled from Move bytecode v6
}

