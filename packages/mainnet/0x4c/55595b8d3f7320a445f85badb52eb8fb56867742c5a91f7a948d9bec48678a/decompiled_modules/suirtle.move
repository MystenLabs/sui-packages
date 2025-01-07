module 0x4c55595b8d3f7320a445f85badb52eb8fb56867742c5a91f7a948d9bec48678a::suirtle {
    struct SUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRTLE>(arg0, 6, b"SUIRTLE", b"SUIRTLE ON SUI", b"Suirtle has arrived at SUI, ready to make the jeeters wet and to give good profits to the holders! WATER GUN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suir_03cbb0091a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

