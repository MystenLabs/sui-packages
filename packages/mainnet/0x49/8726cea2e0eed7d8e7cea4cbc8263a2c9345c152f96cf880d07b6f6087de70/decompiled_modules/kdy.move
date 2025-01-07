module 0x498726cea2e0eed7d8e7cea4cbc8263a2c9345c152f96cf880d07b6f6087de70::kdy {
    struct KDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDY>(arg0, 9, b"KDY", b"Kindvilly", b"The good villain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f22b0f0-c7c5-49aa-948b-78888611be3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

