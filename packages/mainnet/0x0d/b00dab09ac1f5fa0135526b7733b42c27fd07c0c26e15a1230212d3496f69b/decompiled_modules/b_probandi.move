module 0xdb00dab09ac1f5fa0135526b7733b42c27fd07c0c26e15a1230212d3496f69b::b_probandi {
    struct B_PROBANDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PROBANDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PROBANDI>(arg0, 9, b"bPROBANDI", b"bToken PROBANDI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PROBANDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PROBANDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

