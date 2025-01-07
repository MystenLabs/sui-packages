module 0xa525a12adeccabcc28f9ad29b5d61fef402504defb30e588cb92d65f2540e166::cash {
    struct CASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASH>(arg0, 9, b"CASH", b"Cashi", b"Cashi is meme token that teaches community on how to trade meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9576248a-8649-42c3-a972-fd9af42894e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

