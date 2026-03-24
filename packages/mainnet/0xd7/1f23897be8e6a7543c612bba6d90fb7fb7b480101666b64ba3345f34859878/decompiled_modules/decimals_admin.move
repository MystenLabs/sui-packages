module 0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::decimals_admin {
    struct CoinDecimalsRegistered has copy, drop {
        registry: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
    }

    public fun register_decimals<T0>(arg0: &0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::app::AdminCap, arg1: &0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::app::ProtocolApp, arg2: &mut 0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin::CoinMetadata<T0>) {
        0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::app::ensure_version_matches(arg1);
        let v0 = CoinDecimalsRegistered{
            registry  : 0x2::object::id<0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::coin_decimals_registry::CoinDecimalsRegistry>(arg2),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            decimals  : 0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::coin_decimals_registry::register_decimals<T0>(arg2, arg3),
        };
        0x2::event::emit<CoinDecimalsRegistered>(v0);
    }

    public fun register_decimals_with_currency<T0>(arg0: &0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::app::AdminCap, arg1: &0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::app::ProtocolApp, arg2: &mut 0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin_registry::Currency<T0>) {
        0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::app::ensure_version_matches(arg1);
        let v0 = CoinDecimalsRegistered{
            registry  : 0x2::object::id<0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::coin_decimals_registry::CoinDecimalsRegistry>(arg2),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            decimals  : 0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::coin_decimals_registry::register_decimals_with_currency<T0>(arg2, arg3),
        };
        0x2::event::emit<CoinDecimalsRegistered>(v0);
    }

    // decompiled from Move bytecode v6
}

