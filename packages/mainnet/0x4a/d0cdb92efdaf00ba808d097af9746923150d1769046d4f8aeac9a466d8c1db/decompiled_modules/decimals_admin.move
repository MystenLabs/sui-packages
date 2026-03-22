module 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::decimals_admin {
    struct CoinDecimalsRegistered has copy, drop {
        registry: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
    }

    public fun register_decimals<T0>(arg0: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::AdminCap, arg1: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg2: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin::CoinMetadata<T0>) {
        0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ensure_version_matches(arg1);
        let v0 = CoinDecimalsRegistered{
            registry  : 0x2::object::id<0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::coin_decimals_registry::CoinDecimalsRegistry>(arg2),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            decimals  : 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::coin_decimals_registry::register_decimals<T0>(arg2, arg3),
        };
        0x2::event::emit<CoinDecimalsRegistered>(v0);
    }

    public fun register_decimals_with_currency<T0>(arg0: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::AdminCap, arg1: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg2: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin_registry::Currency<T0>) {
        0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ensure_version_matches(arg1);
        let v0 = CoinDecimalsRegistered{
            registry  : 0x2::object::id<0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::coin_decimals_registry::CoinDecimalsRegistry>(arg2),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            decimals  : 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::coin_decimals_registry::register_decimals_with_currency<T0>(arg2, arg3),
        };
        0x2::event::emit<CoinDecimalsRegistered>(v0);
    }

    // decompiled from Move bytecode v6
}

