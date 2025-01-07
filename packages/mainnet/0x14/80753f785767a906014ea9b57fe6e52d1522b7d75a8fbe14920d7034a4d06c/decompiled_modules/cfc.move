module 0x1480753f785767a906014ea9b57fe6e52d1522b7d75a8fbe14920d7034a4d06c::cfc {
    struct CFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFC>(arg0, 9, b"CFC", b"CHELSEA", b"Meme coin for Chelsea Football Club supporters. #KTBFFH ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/339039bf-41c5-47e9-83e2-1834fcb2b0b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

