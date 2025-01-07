module 0xa92abfd95fe4ebe9c25bdc9a1447fff98fe6623bd4a9a638caa61bd276234585::doodoo {
    struct DOODOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODOO>(arg0, 9, b"DOODOO", b"Baby Shark", x"4c6574277320676f2068756e742c20646f6f2d646f6f2c20646f6f2d646f6f2c20646f6f2d646f6f0a4c6574277320676f2068756e742c20646f6f2d646f6f2c20646f6f2d646f6f2c20646f6f2d646f6f0a4c6574277320676f2068756e742c20646f6f2d646f6f2c20646f6f2d646f6f2c20646f6f2d646f6f0a4c6574277320676f2068756e74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/149a5273-8570-400d-a28f-80ea77b2cc11.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOODOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

