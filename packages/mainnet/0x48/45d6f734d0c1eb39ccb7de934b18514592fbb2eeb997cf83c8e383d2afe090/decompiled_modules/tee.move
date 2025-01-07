module 0x4845d6f734d0c1eb39ccb7de934b18514592fbb2eeb997cf83c8e383d2afe090::tee {
    struct TEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEE>(arg0, 9, b"TEE", b"TEE YOD 2", b"Tee Yod", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97653b10-43c9-4ac2-8c6a-5e03e803bda0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

