module 0xb090f6df3ff34b5c3ded5cd8c89ed22b6e234a29b31dc5123d802a5b5400b7a8::tc11 {
    struct TC11 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TC11, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TC11>(arg0, 6, b"TC11", b"testcoin11", b"Tester coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hog_wild_23806988_a35e57e4dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TC11>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TC11>>(v1);
    }

    // decompiled from Move bytecode v6
}

