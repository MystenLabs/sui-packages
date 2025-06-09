module 0xdb211b009b6350be0b68fe3bd3f5ea937864bc260568f201a65620a52b4d6106::steamm_lp_bocto_bup {
    struct STEAMM_LP_BOCTO_BUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BOCTO_BUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BOCTO_BUP>(arg0, 9, b"STEAMM LP bOCTO-bUP", b"STEAMM LP Token bOCTO-bUP", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BOCTO_BUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BOCTO_BUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

