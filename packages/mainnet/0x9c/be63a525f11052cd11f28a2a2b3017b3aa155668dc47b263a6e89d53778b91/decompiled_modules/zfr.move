module 0x9cbe63a525f11052cd11f28a2a2b3017b3aa155668dc47b263a6e89d53778b91::zfr {
    struct ZFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZFR>(arg0, 9, b"ZFR", b"ZafarToken", b"Meme coin on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d118b8c-c1b3-40e9-9f29-3f9966673a22.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZFR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

