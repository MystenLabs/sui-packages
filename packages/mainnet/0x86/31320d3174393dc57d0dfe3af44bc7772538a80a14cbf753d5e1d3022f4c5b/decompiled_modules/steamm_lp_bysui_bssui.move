module 0x8631320d3174393dc57d0dfe3af44bc7772538a80a14cbf753d5e1d3022f4c5b::steamm_lp_bysui_bssui {
    struct STEAMM_LP_BYSUI_BSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BYSUI_BSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BYSUI_BSSUI>(arg0, 9, b"STEAMM LP bySUI-bsSUI", b"STEAMM LP Token bySUI-bsSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BYSUI_BSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BYSUI_BSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

