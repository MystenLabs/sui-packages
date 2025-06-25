module 0xe63a5d31c883cb0154300a73f6396b8ec57f0c45cac33dc8368de3acd62d42df::steamm_lp_basui_bmsend {
    struct STEAMM_LP_BASUI_BMSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BASUI_BMSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BASUI_BMSEND>(arg0, 9, b"STEAMM LP baSUI-bmSEND", b"STEAMM LP Token baSUI-bmSEND", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BASUI_BMSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BASUI_BMSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

