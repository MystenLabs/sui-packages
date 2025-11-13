module 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::decimals_admin {
    struct CoinDecimalsRegistered has copy, drop {
        registry: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
    }

    public fun register_decimals<T0>(arg0: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::app::AdminCap, arg1: &mut 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>) {
        let v0 = CoinDecimalsRegistered{
            registry  : 0x2::object::id<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::coin_decimals_registry::CoinDecimalsRegistry>(arg1),
            coin_type : 0x1::type_name::get<T0>(),
            decimals  : 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::coin_decimals_registry::register_decimals<T0>(arg1, arg2),
        };
        0x2::event::emit<CoinDecimalsRegistered>(v0);
    }

    // decompiled from Move bytecode v6
}

