module 0x831924408507d4fd44a1e6629f92471e422b919d26956c1a5ab29c602c19725e::zfr {
    struct ZFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZFR>(arg0, 9, b"ZFR", b"ZafarToken", b"Meme coin on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0c8020e-d544-4886-8de1-121ae7d5f538.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZFR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

