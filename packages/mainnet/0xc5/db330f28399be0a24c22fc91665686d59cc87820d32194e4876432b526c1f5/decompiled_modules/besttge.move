module 0xc5db330f28399be0a24c22fc91665686d59cc87820d32194e4876432b526c1f5::besttge {
    struct BESTTGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BESTTGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BESTTGE>(arg0, 9, b"BESTTGE", b"TGE", x"4c6574277320646f20697420e298baefb88f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/128c9f4e-0cbe-4ec5-abc9-2bd69d2671f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BESTTGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BESTTGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

