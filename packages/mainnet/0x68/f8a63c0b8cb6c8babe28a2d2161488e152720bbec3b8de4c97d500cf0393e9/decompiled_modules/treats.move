module 0x68f8a63c0b8cb6c8babe28a2d2161488e152720bbec3b8de4c97d500cf0393e9::treats {
    struct TREATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREATS>(arg0, 1, b"TREAT", b"Treat Coin", b"Doghouse Treat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d1fvsuv3rrz9o2.cloudfront.net/dogs/bone.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREATS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREATS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

