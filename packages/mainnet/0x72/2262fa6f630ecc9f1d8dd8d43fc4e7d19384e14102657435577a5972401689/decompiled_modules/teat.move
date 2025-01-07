module 0x722262fa6f630ecc9f1d8dd8d43fc4e7d19384e14102657435577a5972401689::teat {
    struct TEAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEAT>(arg0, 9, b"TEAT", b"TEAT", b"test coin - please don't buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEAT>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

