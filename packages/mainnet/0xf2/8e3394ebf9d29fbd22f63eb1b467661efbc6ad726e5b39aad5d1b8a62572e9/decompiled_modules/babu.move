module 0xf28e3394ebf9d29fbd22f63eb1b467661efbc6ad726e5b39aad5d1b8a62572e9::babu {
    struct BABU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABU>(arg0, 6, b"BABU", b"ambalabu", b"ambalabu is the meme on sui and a mythical doll in ngawi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1471_17bd0a6796.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABU>>(v1);
    }

    // decompiled from Move bytecode v6
}

