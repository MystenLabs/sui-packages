module 0x78be42b8342ed073983e30fdf2b3c03fdb584586aff4d8c7adc086c36c906f8e::suitest {
    struct SUITEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEST>(arg0, 9, b"SUITEST", b"Suitest", b"Suitest token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://etherscan.io/images/main/empty-token.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITEST>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

