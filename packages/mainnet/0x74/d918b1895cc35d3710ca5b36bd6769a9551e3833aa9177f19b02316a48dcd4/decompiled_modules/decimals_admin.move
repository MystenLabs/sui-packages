module 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::decimals_admin {
    struct CoinDecimalsRegistered has copy, drop {
        registry: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
    }

    public fun register_decimals<T0>(arg0: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::AdminCap, arg1: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>) {
        let v0 = CoinDecimalsRegistered{
            registry  : 0x2::object::id<0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::coin_decimals_registry::CoinDecimalsRegistry>(arg1),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            decimals  : 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::coin_decimals_registry::register_decimals<T0>(arg1, arg2),
        };
        0x2::event::emit<CoinDecimalsRegistered>(v0);
    }

    // decompiled from Move bytecode v6
}

