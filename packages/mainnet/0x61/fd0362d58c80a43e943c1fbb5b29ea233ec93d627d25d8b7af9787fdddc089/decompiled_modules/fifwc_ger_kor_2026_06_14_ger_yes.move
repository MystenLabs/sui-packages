module 0x61fd0362d58c80a43e943c1fbb5b29ea233ec93d627d25d8b7af9787fdddc089::fifwc_ger_kor_2026_06_14_ger_yes {
    struct FIFWC_GER_KOR_2026_06_14_GER_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIFWC_GER_KOR_2026_06_14_GER_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIFWC_GER_KOR_2026_06_14_GER_YES>(arg0, 0, b"FIFWC_GER_KOR_2026_06_14_GER_YES", b"FIFWC_GER_KOR_2026_06_14_GER YES", b"FIFWC_GER_KOR_2026_06_14_GER YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIFWC_GER_KOR_2026_06_14_GER_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIFWC_GER_KOR_2026_06_14_GER_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

