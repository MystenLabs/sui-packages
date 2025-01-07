module 0xdd7dac6884394285b0511f17f0ed1f71a37d9dc1f42418f04f11b6e4aaa9cfa9::strawberry {
    struct STRAWBERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRAWBERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRAWBERRY>(arg0, 6, b"STRAWBERRY", b"strawberry cat", b"strawberry cat is an all time iconic cat with a strawberry, the community is still there with the super hyped launch that reach 2M Marketcap in less than an hour. strawberry cat now run by community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Strawberry_0f7172b205.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRAWBERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRAWBERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

