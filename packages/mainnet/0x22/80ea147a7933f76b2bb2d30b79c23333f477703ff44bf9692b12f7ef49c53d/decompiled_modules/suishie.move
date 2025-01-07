module 0x2280ea147a7933f76b2bb2d30b79c23333f477703ff44bf9692b12f7ef49c53d::suishie {
    struct SUISHIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIE>(arg0, 6, b"Suishie", b"Suishie on Sui", b"A quirky Sui character thats part fish, part mystery, and all attitude. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suishie_1_652f37dc6b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

