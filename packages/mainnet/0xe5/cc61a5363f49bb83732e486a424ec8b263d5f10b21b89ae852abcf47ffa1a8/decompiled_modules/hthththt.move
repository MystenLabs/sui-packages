module 0xe5cc61a5363f49bb83732e486a424ec8b263d5f10b21b89ae852abcf47ffa1a8::hthththt {
    struct HTHTHTHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTHTHTHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTHTHTHT>(arg0, 9, b"HTHTHTHT", b"THTHTHT", b"THTHTHTHT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4162db39-f81c-4e71-b119-0da588419acb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTHTHTHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTHTHTHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

