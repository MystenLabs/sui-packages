module 0x2731f96a9a110ca7dcddcab40db7f7586ce134fe0cc001cda73e22b01e5aa878::crcl {
    struct CRCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRCL>(arg0, 9, b"CRCL", b"the circle", b"Smooth and consistent digital currency inspired by the simplicity and integrity of rings", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/133b9e12-dd7c-4854-8435-725e811d2f33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRCL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRCL>>(v1);
    }

    // decompiled from Move bytecode v6
}

