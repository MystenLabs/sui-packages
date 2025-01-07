module 0xe3695dd7e8c0a8f4adb12712642f4d759e02281f7673433f4ddcda4407dbb150::kekcoin {
    struct KEKCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKCOIN>(arg0, 9, b"KEKCOIN", b"kek4fun", b"Kek4Fun is your go-to platform for everything related to the meme-based Kek Coin, bringing fun and excitement to the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b95931b-9729-4ce5-b867-9be90ee888f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

