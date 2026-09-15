module 0xae0f733f0eaa73f8d3eab6c91a01b9622c2e13014d7da15535ef15cce9f2d5e4::x_fanz {
    struct X_FANZ has drop {
        dummy_field: bool,
    }

    public fun decimals() : u8 {
        6
    }

    public fun genesis_supply_base_units() : u64 {
        21000000000000000
    }

    fun init(arg0: X_FANZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<X_FANZ>(arg0, 6, 0x1::string::utf8(b"XFANZ"), 0x1::string::utf8(b"XFanz"), 0x1::string::utf8(b"Fixed-supply FANZ creator economy coin"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<X_FANZ>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<X_FANZ>>(0x2::coin::mint<X_FANZ>(&mut v2, 21000000000000000, arg1), @0xb9b5f08c05c5b264070ac0213c9614c33e41bd61791667cda5309439108d660);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<X_FANZ>>(0x2::coin_registry::finalize<X_FANZ>(v3, arg1), @0xb9b5f08c05c5b264070ac0213c9614c33e41bd61791667cda5309439108d660);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

