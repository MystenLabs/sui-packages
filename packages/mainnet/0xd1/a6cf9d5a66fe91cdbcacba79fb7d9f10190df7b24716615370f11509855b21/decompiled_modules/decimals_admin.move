module 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::decimals_admin {
    struct CoinDecimalsRegistered has copy, drop {
        registry: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
    }

    public fun register_decimals<T0>(arg0: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::AdminCap, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg2: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin::CoinMetadata<T0>) {
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ensure_version_matches(arg1);
        let v0 = CoinDecimalsRegistered{
            registry  : 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::coin_decimals_registry::CoinDecimalsRegistry>(arg2),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            decimals  : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::coin_decimals_registry::register_decimals<T0>(arg2, arg3),
        };
        0x2::event::emit<CoinDecimalsRegistered>(v0);
    }

    // decompiled from Move bytecode v6
}

