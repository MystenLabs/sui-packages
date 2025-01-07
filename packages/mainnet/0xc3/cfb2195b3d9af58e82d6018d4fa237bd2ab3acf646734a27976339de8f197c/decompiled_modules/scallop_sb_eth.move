module 0xc3cfb2195b3d9af58e82d6018d4fa237bd2ab3acf646734a27976339de8f197c::scallop_sb_eth {
    struct SCALLOP_SB_ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_SB_ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_SB_ETH>(arg0, 8, b"sSBETH", b"sSBETH", b"Scallop interest-bearing token for SUI bridge ETH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://b2x6znc2ta33lo5dquh4itez46cjwzg6fnskouwp667rzfce3nmq.arweave.net/Dq_stFqYN7W7o4UPxEyZ54SbZN4rZKdSz_e_HJRE21k")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_SB_ETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_SB_ETH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

