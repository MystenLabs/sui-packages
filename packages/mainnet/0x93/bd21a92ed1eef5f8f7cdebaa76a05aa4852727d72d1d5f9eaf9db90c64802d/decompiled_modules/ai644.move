module 0x93bd21a92ed1eef5f8f7cdebaa76a05aa4852727d72d1d5f9eaf9db90c64802d::ai644 {
    struct AI644 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI644, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI644>(arg0, 6, b"AI644", b"Meme Magic", b"Meme Magic - Project $AI644 designed and developed to flip all the meme coins in existence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241215_093930_542_8a6693b4a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI644>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI644>>(v1);
    }

    // decompiled from Move bytecode v6
}

