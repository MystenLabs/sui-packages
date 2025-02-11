module 0xfd65479a98ae297745b11c6a2e1d38f17b43962f08356aeef2cc7d2a468b04ec::harrybolz {
    struct HARRYBOLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRYBOLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRYBOLZ>(arg0, 9, b"HarryBolz", x"48617272792042c58d6c7a", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVdxgrg3yaffkvgJPJtjuNiYm41QW5RSaoicykHj96pvv")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HARRYBOLZ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARRYBOLZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRYBOLZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

