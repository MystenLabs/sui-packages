module 0xfc20b52315361d6a0c83f8dfb9b2789e4c0ce12152fd379618caabbb08840ca6::ko {
    struct KO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KO>(arg0, 9, b"KO", b"Konda", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KO>>(v1);
    }

    // decompiled from Move bytecode v6
}

