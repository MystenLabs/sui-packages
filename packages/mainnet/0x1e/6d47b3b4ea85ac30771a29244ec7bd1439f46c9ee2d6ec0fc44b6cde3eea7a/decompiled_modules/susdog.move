module 0x1e6d47b3b4ea85ac30771a29244ec7bd1439f46c9ee2d6ec0fc44b6cde3eea7a::susdog {
    struct SUSDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDOG>(arg0, 9, b"susdog", b"susdog", x"24737573646f67202d20536964652045796520446f6721204c6f6f6b20696e746f207468657365206579657320f09f9180202054656c656772616d3a2068747470733a2f2f742e6d652f737573646f675f7375692020547769747465723a2068747470733a2f2f782e636f6d2f737573646f675f7375692020576562736974653a2068747470733a2f2f737573646f672e66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/susdog112/susdog/refs/heads/main/susdog%20logo%20(1).png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUSDOG>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

