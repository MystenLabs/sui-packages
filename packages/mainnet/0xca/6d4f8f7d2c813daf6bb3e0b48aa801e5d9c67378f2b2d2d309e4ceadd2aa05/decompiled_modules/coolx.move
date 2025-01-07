module 0xca6d4f8f7d2c813daf6bb3e0b48aa801e5d9c67378f2b2d2d309e4ceadd2aa05::coolx {
    struct COOLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLX>(arg0, 9, b"COOLX", b"Cool", b"Cool Elon musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03ecb1c1-5e14-4c5d-9233-41d55920fb08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

