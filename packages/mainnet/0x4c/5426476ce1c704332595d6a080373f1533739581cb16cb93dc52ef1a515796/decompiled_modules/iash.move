module 0x4c5426476ce1c704332595d6a080373f1533739581cb16cb93dc52ef1a515796::iash {
    struct IASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: IASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IASH>(arg0, 6, b"IASH", b"IDK", x"4920646f6e74206b6e6f772e0a4920616d2073757065722068696768", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_1583160247711_2191776b4b91_9e9e819e00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

