module 0x93187a224d71daed70a3c34d4f9b50ed36da34db77a902fe12a9bb44a29989ce::ynb {
    struct YNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: YNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YNB>(arg0, 6, b"YNB", b"Your Name Boy", b"Beautiful movie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731568718800.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YNB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YNB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

