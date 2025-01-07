module 0x5bc20690a2a9ec127a513ad3de71ec1226b85c6e1a34aed70b6e75f2d22f7c06::smfkfv {
    struct SMFKFV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMFKFV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMFKFV>(arg0, 9, b"SMFKFV", b"Tsjwks", b"Skemgmv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12bca9ea-c0e5-4ae1-aecc-5cebc4b251e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMFKFV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMFKFV>>(v1);
    }

    // decompiled from Move bytecode v6
}

