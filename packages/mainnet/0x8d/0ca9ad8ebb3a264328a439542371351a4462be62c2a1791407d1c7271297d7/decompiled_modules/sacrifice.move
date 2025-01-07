module 0x8d0ca9ad8ebb3a264328a439542371351a4462be62c2a1791407d1c7271297d7::sacrifice {
    struct SACRIFICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SACRIFICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SACRIFICE>(arg0, 6, b"SACRIFICE", b"SACRIFICE.", b"If not now, when?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/guts_c186f6f40b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SACRIFICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SACRIFICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

