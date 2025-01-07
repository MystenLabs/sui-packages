module 0xf460274303e905a2d2a7394afb7a296e07accec4360c7e22bb33c3f6a77986ef::krwabobr {
    struct KRWABOBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRWABOBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRWABOBR>(arg0, 9, b"KRWABOBR", b"KRWA", b"KRWA BOBR: Taking Over the World, One WAWE at a Time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1221102-92c0-4b16-ab92-fe2c822cf3f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRWABOBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRWABOBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

