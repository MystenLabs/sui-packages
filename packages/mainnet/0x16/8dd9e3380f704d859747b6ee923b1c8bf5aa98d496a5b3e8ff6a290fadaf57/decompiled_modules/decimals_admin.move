module 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::decimals_admin {
    struct CoinDecimalsRegistered has copy, drop {
        registry: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
    }

    public fun register_decimals<T0>(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>) {
        let v0 = CoinDecimalsRegistered{
            registry  : 0x2::object::id<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::coin_decimals_registry::CoinDecimalsRegistry>(arg1),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            decimals  : 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::coin_decimals_registry::register_decimals<T0>(arg1, arg2),
        };
        0x2::event::emit<CoinDecimalsRegistered>(v0);
    }

    // decompiled from Move bytecode v6
}

