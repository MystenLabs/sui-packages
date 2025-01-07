module 0xbbaae904bc9779d2857274bedd5b49286297115c6f53e41199ebb119723ec575::ff {
    struct FF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FF>(arg0, 8, b"ff", b"ff", b"aads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FF>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FF>>(v1);
    }

    // decompiled from Move bytecode v6
}

