module 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_pirate {
    struct KAPY_PIRATE has drop {
        dummy_field: bool,
    }

    struct KapyPirate has store, key {
        id: 0x2::object::UID,
        kind: u8,
    }

    public fun new<T0: drop>(arg0: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::KapyWorld, arg1: u8, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : KapyPirate {
        if (!0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::is_valid_pirate_rule<T0>(arg0, arg1)) {
            err_invalid_pirate_rule();
        };
        new_internal(arg1, arg3)
    }

    fun err_invalid_pirate_rule() {
        abort 0
    }

    public(friend) fun get_recruited(arg0: KapyPirate) : u8 {
        let KapyPirate {
            id   : v0,
            kind : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    fun init(arg0: KAPY_PIRATE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<KAPY_PIRATE>(arg0, arg1);
    }

    public fun kind(arg0: &KapyPirate) : u8 {
        arg0.kind
    }

    public fun new_by_god(arg0: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::GodPower, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : KapyPirate {
        new_internal(arg1, arg2)
    }

    entry fun new_by_god_to(arg0: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::GodPower, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<KapyPirate>(new_internal(arg1, arg3), arg2);
    }

    public fun new_internal(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : KapyPirate {
        let v0 = 0x2::object::new(arg1);
        0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::events::emit_new_pirate(0x2::object::uid_to_inner(&v0), arg0);
        KapyPirate{
            id   : v0,
            kind : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

