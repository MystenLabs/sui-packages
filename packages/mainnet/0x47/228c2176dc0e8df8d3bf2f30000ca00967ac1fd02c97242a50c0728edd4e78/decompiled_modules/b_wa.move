module 0x47228c2176dc0e8df8d3bf2f30000ca00967ac1fd02c97242a50c0728edd4e78::b_wa {
    struct B_WA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WA>(arg0, 9, b"bWA", b"bToken WA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WA>>(v1);
    }

    // decompiled from Move bytecode v6
}

