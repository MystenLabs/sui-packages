module 0x32a2461b6d4151c602c0365bdeab51bebd3298ad0bc28f5c9fa8546297a8388c::sumo {
    struct SUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMO>(arg0, 9, b"SUMO", b"Sumo Cat", b"Mascot Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/522/075/large/cameron-mark-sumo-cat-exotic.jpg?1727798571")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUMO>(&mut v2, 300000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

