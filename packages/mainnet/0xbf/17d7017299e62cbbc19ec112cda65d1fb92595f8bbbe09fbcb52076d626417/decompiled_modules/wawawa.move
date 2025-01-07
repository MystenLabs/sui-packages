module 0xbf17d7017299e62cbbc19ec112cda65d1fb92595f8bbbe09fbcb52076d626417::wawawa {
    struct WAWAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWAWA>(arg0, 9, b"WAWAWA", b"Superwawa", b"it's very funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0514e93-c086-4f78-aad0-0888bcd4f202.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

