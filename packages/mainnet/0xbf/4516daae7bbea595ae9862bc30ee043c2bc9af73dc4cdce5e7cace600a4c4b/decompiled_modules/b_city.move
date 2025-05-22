module 0xbf4516daae7bbea595ae9862bc30ee043c2bc9af73dc4cdce5e7cace600a4c4b::b_city {
    struct B_CITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CITY>(arg0, 9, b"bCITY", b"bToken CITY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

