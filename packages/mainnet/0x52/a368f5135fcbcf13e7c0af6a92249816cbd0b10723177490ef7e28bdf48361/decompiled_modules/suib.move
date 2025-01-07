module 0x52a368f5135fcbcf13e7c0af6a92249816cbd0b10723177490ef7e28bdf48361::suib {
    struct SUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIB>(arg0, 6, b"Suib", b"Sui blue Butt", b"Dive into the wild world of SUI Blue Butt , the memecoin on Sui for laughs, gains, and pure degen energy .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731832896721.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

