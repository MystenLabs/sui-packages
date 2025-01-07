module 0x4dd3b61f4dd6ac3ba62de0970d56e6e2738421ca1c84fa4c91378bf5789c1ca7::oly {
    struct OLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLY>(arg0, 9, b"OLY", b"Olaiya", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82fee5e9-a6d5-4206-81b1-38ac6305de36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

