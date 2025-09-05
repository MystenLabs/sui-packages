module 0xb4a711f7060ff58ac0e3afd8a828ba0bb3a516d45fde1a3153476075096691bf::charizard_capital {
    struct CHARIZARD_CAPITAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARIZARD_CAPITAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARIZARD_CAPITAL>(arg0, 9, b"ZARD", b"Charizard Capital", b"https://www.charizardcapital.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/dZNayRK.jpeg")), arg1);
        let (v2, v3) = 0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::new<CHARIZARD_CAPITAL>(v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::set_maximum_supply(&mut v4, 1000000000000000000);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHARIZARD_CAPITAL>>(v1);
        0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::BurnCap>(0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::create_burn_cap(&mut v4, arg1), @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
        0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::destroy_witness<CHARIZARD_CAPITAL>(&mut v5, v4);
        0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::IPXTreasuryStandard>(v5, @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
    }

    // decompiled from Move bytecode v6
}

