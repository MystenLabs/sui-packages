module 0x70053f91e9b2d04fc9820524dfe784c9a6f9aa15466ba5a4feb518d4561370c::him {
    struct HIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIM>(arg0, 9, b"HIM", b"CATHIM", b"This is my cat and I want to launch it into space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/141f3f0e-d8cb-42c4-ac99-bd59b14f72e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

