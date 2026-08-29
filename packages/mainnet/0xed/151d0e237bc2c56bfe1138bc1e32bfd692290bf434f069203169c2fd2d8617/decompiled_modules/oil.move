module 0xed151d0e237bc2c56bfe1138bc1e32bfd692290bf434f069203169c2fd2d8617::oil {
    struct OIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIL>(arg0, 6, b"OIL", b"oil", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/2f7f1e756e6440903d36cffd5bd550948b171a4ee41d9fedaa7d13a71de84d41.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIL>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OIL>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

