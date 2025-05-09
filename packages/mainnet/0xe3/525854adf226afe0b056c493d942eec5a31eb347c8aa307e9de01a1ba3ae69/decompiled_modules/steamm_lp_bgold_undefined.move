module 0xe3525854adf226afe0b056c493d942eec5a31eb347c8aa307e9de01a1ba3ae69::steamm_lp_bgold_undefined {
    struct STEAMM_LP_BGOLD_UNDEFINED has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BGOLD_UNDEFINED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BGOLD_UNDEFINED>(arg0, 9, b"STEAMM LP bGOLD-undefined", b"STEAMM LP Token bGOLD-undefined", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BGOLD_UNDEFINED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BGOLD_UNDEFINED>>(v1);
    }

    // decompiled from Move bytecode v6
}

