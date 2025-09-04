module 0x7dee9c98234bd5c43aa8dec65f722262134ea2d7f27dd5bd033d0f265e8bb63b::counterfeit_bobs {
    struct COUNTERFEIT_BOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUNTERFEIT_BOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUNTERFEIT_BOBS>(arg0, 9, b"BOBS", b"Counterfeit BOBs", b"A token that is not the real BOBs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.pinimg.com%2Foriginals%2F17%2F43%2F9e%2F17439ed53c82a22a551f4261bf25afe3.jpg&f=1&nofb=1&ipt=7c3159d75e2cb3c0d77a15e3c16fc2f05738281d1e99d554d7634074fd5425c7")), arg1);
        let (v2, v3) = 0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::new<COUNTERFEIT_BOBS>(v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COUNTERFEIT_BOBS>>(v1);
        let v6 = 0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::create_mint_cap(&mut v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<COUNTERFEIT_BOBS>>(0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::mint<COUNTERFEIT_BOBS>(&v6, &mut v5, 1000000000000000000, arg1), @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
        0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::MintCap>(v6, @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
        0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::BurnCap>(0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::create_burn_cap(&mut v4, arg1), @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
        0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::MetadataCap>(0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::create_metadata_cap(&mut v4, arg1), @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
        0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::destroy_witness<COUNTERFEIT_BOBS>(&mut v5, v4);
        0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::IPXTreasuryStandard>(v5, @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
    }

    // decompiled from Move bytecode v6
}

