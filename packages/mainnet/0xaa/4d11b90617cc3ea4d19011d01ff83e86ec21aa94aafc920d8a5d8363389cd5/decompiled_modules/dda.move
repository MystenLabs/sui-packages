module 0xaa4d11b90617cc3ea4d19011d01ff83e86ec21aa94aafc920d8a5d8363389cd5::dda {
    struct DDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDA>(arg0, 6, b"dda", b"dda", b"erdefcd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DDA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

