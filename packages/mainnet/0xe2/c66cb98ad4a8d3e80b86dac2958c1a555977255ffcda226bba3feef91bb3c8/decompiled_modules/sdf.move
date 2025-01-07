module 0xe2c66cb98ad4a8d3e80b86dac2958c1a555977255ffcda226bba3feef91bb3c8::sdf {
    struct SDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDF>(arg0, 9, b"SDF", b"fcvbd", b"CVBCVB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef141869-fa88-4e1d-8a67-8fa6d870a1e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

