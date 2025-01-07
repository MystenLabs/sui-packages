module 0xb73beff8b0ea8f04c735b957c69f0a4836f852e78430b5464493ca9cd86e1e8e::meve {
    struct MEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEVE>(arg0, 9, b"MEVE", b"LoC", b"To the mon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09682215-1d7b-4add-b43f-738f85cd3a08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

