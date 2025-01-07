module 0x9fe8978a25496e5235b10a193de794d21a81a4b21775e0331fc2608da4115266::ivanrudsk {
    struct IVANRUDSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVANRUDSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVANRUDSK>(arg0, 9, b"IVANRUDSK", b"1GUY", x"49206d616465206120736f6e672061626f7574202431677579206d656d6520636f696e20f09f9880", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2e522e7-3b9c-405f-b12c-8c31ff70cab6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVANRUDSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVANRUDSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

