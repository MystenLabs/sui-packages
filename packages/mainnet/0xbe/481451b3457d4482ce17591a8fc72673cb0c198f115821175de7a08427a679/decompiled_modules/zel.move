module 0xbe481451b3457d4482ce17591a8fc72673cb0c198f115821175de7a08427a679::zel {
    struct ZEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEL>(arg0, 9, b"ZEL", b"Zelda", b"Haski", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a0148b0-46c7-4773-a420-6ea4f4bfe7a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

