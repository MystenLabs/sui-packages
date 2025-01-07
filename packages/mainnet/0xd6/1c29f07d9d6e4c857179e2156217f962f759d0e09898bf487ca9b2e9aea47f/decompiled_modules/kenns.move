module 0xd61c29f07d9d6e4c857179e2156217f962f759d0e09898bf487ca9b2e9aea47f::kenns {
    struct KENNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENNS>(arg0, 9, b"KENNS", b"hdbd", b"jdjd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aaebef8a-429e-4619-917a-ddb5e40e0ba3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

