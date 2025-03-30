module 0x27fbfa6ff284ed4b9ce36a38062098e0e636c0a716dea29a9f276e17422d24e6::fishman {
    struct FISHMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHMAN>(arg0, 6, b"FISHMAN", b"FishMAN", b"FishMan is a cool Fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052248_9293cc0d71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

