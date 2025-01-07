module 0x9ae0dddf66c10b8dff4dbd36a323300c2a711382bf552e36cae149e668685ed7::reef_meme {
    struct REEF_MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: REEF_MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REEF_MEME>(arg0, 9, b"REEF_MEME", b"Reef", x"5265656620f09faab8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2bd115c1-d35b-4be1-bba3-77e4fa0b2d17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REEF_MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REEF_MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

