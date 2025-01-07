module 0x2fb5c180e2a27e847c7119d3ffb6be408786a4764d091633b99d3900e11e800a::ditto {
    struct DITTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DITTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DITTO>(arg0, 9, b"Ditto", b"Ditto", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DITTO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DITTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DITTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

