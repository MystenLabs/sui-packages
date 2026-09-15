module 0x71da49294d9b33eaf676b24d8a7320148729058c7917e49cd0e2a9a4f5ff03bd::tg {
    struct TG has drop {
        dummy_field: bool,
    }

    public fun decimals() : u8 {
        6
    }

    public fun genesis_supply_base_units() : u64 {
        21000000000000000
    }

    fun init(arg0: TG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TG>(arg0, 6, 0x1::string::utf8(b"TG"), 0x1::string::utf8(b"TokenGate"), 0x1::string::utf8(b"Fixed-supply TokenGate platform coin"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<TG>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TG>>(0x2::coin::mint<TG>(&mut v2, 21000000000000000, arg1), @0xb9b5f08c05c5b264070ac0213c9614c33e41bd61791667cda5309439108d660);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TG>>(0x2::coin_registry::finalize<TG>(v3, arg1), @0xb9b5f08c05c5b264070ac0213c9614c33e41bd61791667cda5309439108d660);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

