module 0x1d32e0d518d3bd0a6047f07a07d51bbeaa41b5ad413391a45fee568057e2d26e::jelly {
    struct JELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLY>(arg0, 9, b"Jelly", b"Jelly", b"Jelly on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/teamrobust/images/6/62/Jellynew.jpg/revision/latest?cb=20231203195753")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JELLY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLY>>(v2, @0xadbcfa5f1207767b3a890a5eb0416a13a86de0918e57b58aec0d5e4cf6bf7060);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

