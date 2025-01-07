module 0xd0f0b2f3bdb75fb10f2972ad6138f740feb0c0f6bc991d48071b1999d72b2f91::habson14 {
    struct HABSON14 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HABSON14, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HABSON14>(arg0, 9, b"HABSON14", b"habson17", b"BichiousNft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da79cf1b-8459-45f2-be02-590d76197430.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HABSON14>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HABSON14>>(v1);
    }

    // decompiled from Move bytecode v6
}

