module 0xc1cc4bb5c9b4daf19dbf52d5fee907d3a0ef91c9f88ad1785d73cfa7e9dceebc::aglpika {
    struct AGLPIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGLPIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGLPIKA>(arg0, 9, b"AGLPIKA", b"ANGELAPIKA", x"416e20574f4720576176657220f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74f4a24e-b6be-462c-bf41-4dcf23050ba7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGLPIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGLPIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

