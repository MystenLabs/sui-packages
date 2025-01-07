module 0x88f405a7ca54c3ab6746a8e05f2e5f18c71ed1e056fa43d32939651c9c6eb1f6::evps {
    struct EVPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVPS>(arg0, 6, b"EVPS", b"EvilPenguin", b"Bro, as an evil penguin, should we wreck something? Like, uh, carry out an evil plan on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Evil_Penguin_6310041be0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

