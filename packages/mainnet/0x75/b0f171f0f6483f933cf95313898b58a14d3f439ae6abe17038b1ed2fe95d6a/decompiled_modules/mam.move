module 0x75b0f171f0f6483f933cf95313898b58a14d3f439ae6abe17038b1ed2fe95d6a::mam {
    struct MAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAM>(arg0, 9, b"MAM", b"MAMMOTH", x"466f72207265616c204d616d6d6f74687320f09fa6a320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7337af97-52c6-4fb7-a826-03edff05be0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

