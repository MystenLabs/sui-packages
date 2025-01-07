module 0xee19d0e9c80b2ea911737ffc3496b973476d7c774c6e0fd47b6a0f989d4a2cf5::white {
    struct WHITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHITE>(arg0, 9, b"WHITE", b"WHITE PARTY", b"The most popular party", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/736x/35/53/4e/35534e7ea0350687a9c4d33d2b8068ff.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHITE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHITE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

