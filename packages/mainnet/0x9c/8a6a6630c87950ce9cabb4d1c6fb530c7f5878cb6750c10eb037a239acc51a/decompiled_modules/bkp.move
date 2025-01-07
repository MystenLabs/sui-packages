module 0x9c8a6a6630c87950ce9cabb4d1c6fb530c7f5878cb6750c10eb037a239acc51a::bkp {
    struct BKP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKP>(arg0, 9, b"BKP", b"Kieu Phong", x"42e1baaf63204b69e1bb81752050686f6e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c44ec597-7c20-4d2d-9c3e-13f4c599e7c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKP>>(v1);
    }

    // decompiled from Move bytecode v6
}

