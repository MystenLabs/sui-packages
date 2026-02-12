module 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::decimals_admin {
    struct CoinDecimalsRegistered has copy, drop {
        registry: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
    }

    public fun register_decimals<T0>(arg0: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::app::AdminCap, arg1: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>) {
        let v0 = CoinDecimalsRegistered{
            registry  : 0x2::object::id<0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::coin_decimals_registry::CoinDecimalsRegistry>(arg1),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            decimals  : 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::coin_decimals_registry::register_decimals<T0>(arg1, arg2),
        };
        0x2::event::emit<CoinDecimalsRegistered>(v0);
    }

    // decompiled from Move bytecode v6
}

