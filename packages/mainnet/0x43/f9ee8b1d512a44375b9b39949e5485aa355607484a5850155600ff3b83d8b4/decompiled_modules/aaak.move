module 0x43f9ee8b1d512a44375b9b39949e5485aa355607484a5850155600ff3b83d8b4::aaak {
    struct AAAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAK>(arg0, 9, b"AAAK", b"aaa kitten", b"Can't stop, won't stop (raving about Sui).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_6729_3f39692e96.png&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAAK>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

