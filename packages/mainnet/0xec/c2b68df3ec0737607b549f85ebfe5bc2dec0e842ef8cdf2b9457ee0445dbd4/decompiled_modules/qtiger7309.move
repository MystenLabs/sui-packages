module 0xecc2b68df3ec0737607b549f85ebfe5bc2dec0e842ef8cdf2b9457ee0445dbd4::qtiger7309 {
    struct QTIGER7309 has drop {
        dummy_field: bool,
    }

    fun init(arg0: QTIGER7309, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QTIGER7309>(arg0, 6, b"QTIGER7309", b"Quantum Tiger #7309", b"Superposition of wealth and prosperity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/quantum-tiger.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QTIGER7309>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QTIGER7309>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

