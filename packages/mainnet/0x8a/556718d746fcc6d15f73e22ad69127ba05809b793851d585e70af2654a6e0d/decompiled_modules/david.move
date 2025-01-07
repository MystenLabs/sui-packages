module 0x8a556718d746fcc6d15f73e22ad69127ba05809b793851d585e70af2654a6e0d::david {
    struct DAVID has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVID>(arg0, 9, b"DAVID", b"David", b"Tham tu DAVID", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6b27e55-41a8-4d7b-aa09-0430ed196dfe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAVID>>(v1);
    }

    // decompiled from Move bytecode v6
}

