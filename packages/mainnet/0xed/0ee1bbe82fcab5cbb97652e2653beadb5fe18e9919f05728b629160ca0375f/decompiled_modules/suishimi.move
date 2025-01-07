module 0xed0ee1bbe82fcab5cbb97652e2653beadb5fe18e9919f05728b629160ca0375f::suishimi {
    struct SUISHIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIMI>(arg0, 6, b"SUISHIMI", b"Suishimi", b"Chef Wonderful is cooking Suishimi for every Sui lover. 100% CTO. No jeet. Strong hand", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/34be974911c5d17f9023ba0bcaa61510_447e019e53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

