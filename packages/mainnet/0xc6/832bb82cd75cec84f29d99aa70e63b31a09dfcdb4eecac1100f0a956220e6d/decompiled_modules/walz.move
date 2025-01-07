module 0xc6832bb82cd75cec84f29d99aa70e63b31a09dfcdb4eecac1100f0a956220e6d::walz {
    struct WALZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALZ>(arg0, 6, b"WALZ", b"NO BALLZ WALZ", b"Ive become friends with school shooters!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8933_0fa25dab26.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

