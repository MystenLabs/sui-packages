module 0x4b9a086f545196604c745f142bbb80a779d3123d5ae671144faa4a1562c9e2cd::suitz {
    struct SUITZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITZ>(arg0, 6, b"SUITZ", b"Suitzerland", b"sui country", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suizt_8e364d7940.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

