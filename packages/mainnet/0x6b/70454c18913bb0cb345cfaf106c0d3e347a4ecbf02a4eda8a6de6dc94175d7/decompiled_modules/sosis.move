module 0x6b70454c18913bb0cb345cfaf106c0d3e347a4ecbf02a4eda8a6de6dc94175d7::sosis {
    struct SOSIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOSIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOSIS>(arg0, 9, b"SOSIS", b"Suiosis", b"The native token for the Suiosis project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVs4Zwqop7SMREzn6jFaA4GYRY3orNGtqHmVeki5UbBnA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOSIS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOSIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOSIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

