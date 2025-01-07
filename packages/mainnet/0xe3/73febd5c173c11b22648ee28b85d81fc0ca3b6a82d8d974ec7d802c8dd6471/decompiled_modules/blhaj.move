module 0xe373febd5c173c11b22648ee28b85d81fc0ca3b6a82d8d974ec7d802c8dd6471::blhaj {
    struct BLHAJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLHAJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLHAJ>(arg0, 6, b"BLHAJ", b"Blhaj", b"Blhaj IKEA Shark Plush Meme: A viral meme featuring the IKEA plush shark, Blhaj, often depicted in humorous or relatable everyday scenarios. The plush gained internet fame for being posed in funny or cozy situations, symbolizing feelings of comfort, anxiety, or loneliness, with users giving it a lovable personality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/949_9eb8469904.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLHAJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLHAJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

