module 0x2078fd8cd4f428546214f225327cbe6b5faf8b490331341cd1b7eae984ced9ae::kangaroo {
    struct KANGAROO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KANGAROO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KANGAROO>(arg0, 6, b"KANGAROO", b"SuiKangaroo", x"4865792c2049276d204b414e47412e2049206a756d70206c696b652061207265616c206174686c6574652c206f7220616c6d6f73742e2e2e204275740a6576657279206a756d702049206d616b6520697320612073686f772120416c736f2c206265747765656e20796f750a616e64206d652c2049206c6f766520746f206561742052617370626572726965732e0a0a5261737062657272696573206973206d79207765616b6e6573732c2062757420646f6e2774207468696e6b2074686174206d616b6573206d65206661742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730965456041.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KANGAROO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KANGAROO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

