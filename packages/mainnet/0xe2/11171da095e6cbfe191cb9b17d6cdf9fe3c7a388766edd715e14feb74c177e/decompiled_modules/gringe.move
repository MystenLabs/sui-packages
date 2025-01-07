module 0xe211171da095e6cbfe191cb9b17d6cdf9fe3c7a388766edd715e14feb74c177e::gringe {
    struct GRINGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRINGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINGE>(arg0, 9, b"GRINGE", b"CRINGE", b"Gringest coin from 0 to 10 million!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.tenor.com/d2-UHAzefXgAAAAi/pepe-cringe.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GRINGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRINGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

