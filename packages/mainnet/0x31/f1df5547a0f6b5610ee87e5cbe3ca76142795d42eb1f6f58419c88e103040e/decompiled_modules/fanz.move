module 0x31f1df5547a0f6b5610ee87e5cbe3ca76142795d42eb1f6f58419c88e103040e::fanz {
    struct FANZ has drop {
        dummy_field: bool,
    }

    public fun decimals() : u8 {
        6
    }

    public fun genesis_supply_base_units() : u64 {
        21000000000000000
    }

    fun init(arg0: FANZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FANZ>(arg0, 6, 0x1::string::utf8(b"FANZ"), 0x1::string::utf8(b"FANZ"), 0x1::string::utf8(b"Fixed-supply FANZ platform coin"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<FANZ>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<FANZ>>(0x2::coin::mint<FANZ>(&mut v2, 21000000000000000, arg1), @0xb9b5f08c05c5b264070ac0213c9614c33e41bd61791667cda5309439108d660);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FANZ>>(0x2::coin_registry::finalize<FANZ>(v3, arg1), @0xb9b5f08c05c5b264070ac0213c9614c33e41bd61791667cda5309439108d660);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

