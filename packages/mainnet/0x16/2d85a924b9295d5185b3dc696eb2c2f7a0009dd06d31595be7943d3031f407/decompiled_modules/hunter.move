module 0x162d85a924b9295d5185b3dc696eb2c2f7a0009dd06d31595be7943d3031f407::hunter {
    struct HUNTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUNTER>(arg0, 9, b"HUNTER", b"Hunt man", b"Just hunt and earn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ae2887e-a741-4d22-b9dd-7e7c946fafc1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUNTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

