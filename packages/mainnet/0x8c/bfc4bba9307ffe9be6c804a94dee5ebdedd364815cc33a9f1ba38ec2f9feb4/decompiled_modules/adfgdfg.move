module 0x8cbfc4bba9307ffe9be6c804a94dee5ebdedd364815cc33a9f1ba38ec2f9feb4::adfgdfg {
    struct ADFGDFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADFGDFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADFGDFG>(arg0, 9, b"ADFGDFG", b"efdg", b"dfgdfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3af30ca-b3b9-46be-9318-0c993bead96c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADFGDFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADFGDFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

