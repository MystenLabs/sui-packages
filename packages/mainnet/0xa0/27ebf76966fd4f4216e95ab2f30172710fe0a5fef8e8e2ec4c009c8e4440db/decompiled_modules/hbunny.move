module 0xa027ebf76966fd4f4216e95ab2f30172710fe0a5fef8e8e2ec4c009c8e4440db::hbunny {
    struct HBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBUNNY>(arg0, 6, b"HBUNNY", b"HOP BUNNY", b"Once upon a time, in a lush green meadow, there lived a curious little bunny. Bunny to explore his surroundings, hopping from flower to flower and making friends with the other animals. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731255573857.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HBUNNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBUNNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

