module 0x4d1fab9f58d5e86b9eedf0c41b0d35c91060dd7ad5128d11a8f5b8010ad0894d::hunter {
    struct HUNTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUNTER>(arg0, 9, b"HUNTER", b"Bitis", b"Bitis Hunter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/72a17e6f-7c52-4f38-b594-a36c49fd3e4b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUNTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

