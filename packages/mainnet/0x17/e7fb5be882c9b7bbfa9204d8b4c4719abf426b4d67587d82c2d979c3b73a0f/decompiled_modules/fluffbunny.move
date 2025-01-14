module 0x17e7fb5be882c9b7bbfa9204d8b4c4719abf426b4d67587d82c2d979c3b73a0f::fluffbunny {
    struct FLUFFBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFBUNNY>(arg0, 6, b"FluffBunny", b"SuiFluffBunny", b"Fluffbunny, which will be exhibited at Movepump, is not just a meme money, it is a revolution in the world of digital money! Inspired by the soft and cuddly nature of rabbits,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000199292_6d7140718f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFBUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFBUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

