module 0xde8f2477454d9f119f78c30ef1d78255f8985d792fae67c31c31f6fe44d400a0::bftgg {
    struct BFTGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFTGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFTGG>(arg0, 9, b"BFTGG", b"BreakFast", b"Start Your Day with a GM. Gain some Gains with BreakFast LFGG.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/RlDoOAw.jpeg")), arg1);
        let (v2, v3) = 0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::new<BFTGG>(v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFTGG>>(v1);
        let v6 = 0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::create_mint_cap(&mut v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BFTGG>>(0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::mint<BFTGG>(&v6, &mut v5, 1000000000000000000, arg1), @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
        0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::MintCap>(v6, @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
        0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::BurnCap>(0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::create_burn_cap(&mut v4, arg1), @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
        0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::MetadataCap>(0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::create_metadata_cap(&mut v4, arg1), @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
        0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::destroy_witness<BFTGG>(&mut v5, v4);
        0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::IPXTreasuryStandard>(v5, @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
    }

    // decompiled from Move bytecode v6
}

