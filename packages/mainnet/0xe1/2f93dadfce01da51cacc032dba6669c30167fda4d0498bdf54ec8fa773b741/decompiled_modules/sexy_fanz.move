module 0xe12f93dadfce01da51cacc032dba6669c30167fda4d0498bdf54ec8fa773b741::sexy_fanz {
    struct SEXY_FANZ has drop {
        dummy_field: bool,
    }

    public fun decimals() : u8 {
        6
    }

    public fun genesis_supply_base_units() : u64 {
        21000000000000000
    }

    fun init(arg0: SEXY_FANZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SEXY_FANZ>(arg0, 6, 0x1::string::utf8(b"SEXYFANZ"), 0x1::string::utf8(b"SexyFanz"), 0x1::string::utf8(b"Fixed-supply FANZ creator economy coin"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<SEXY_FANZ>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SEXY_FANZ>>(0x2::coin::mint<SEXY_FANZ>(&mut v2, 21000000000000000, arg1), @0xd7f24e14660f6b8436271aade3d130ae5f23f719d324c3085703418a4f0ab622);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SEXY_FANZ>>(0x2::coin_registry::finalize<SEXY_FANZ>(v3, arg1), @0xd7f24e14660f6b8436271aade3d130ae5f23f719d324c3085703418a4f0ab622);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

