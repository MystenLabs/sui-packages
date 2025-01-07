module 0xd1d3ead69edc95c4b28565f1afba5c8f30cd9f9cacb7190b944e5ce2747ed17::simpson_ {
    struct SIMPSON_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPSON_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPSON_>(arg0, 9, b"SIMPSON", x"e2ad90efb88f53696d70736f6e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIMPSON_>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPSON_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMPSON_>>(v1);
    }

    // decompiled from Move bytecode v6
}

