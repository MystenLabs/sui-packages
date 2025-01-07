module 0x116fe4c0967478388001f60aab2cb419d2c5a2a5b509feada53340bb1c56965e::flower {
    struct FLOWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOWER>(arg0, 9, b"FLOWER", b"LOTUS", b"Lotus symbolizes the supreme flower", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1aae0cd0-9c07-4d50-8f2e-0731f5f05d66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOWER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOWER>>(v1);
    }

    // decompiled from Move bytecode v6
}

