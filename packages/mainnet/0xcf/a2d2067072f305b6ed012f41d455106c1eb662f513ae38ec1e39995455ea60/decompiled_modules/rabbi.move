module 0xcfa2d2067072f305b6ed012f41d455106c1eb662f513ae38ec1e39995455ea60::rabbi {
    struct RABBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBI>(arg0, 6, b"RABBI", b"Rabbi on SUI", b"It might make sense just to get some rabbi in case it catches on. If enough people think the same way, that becomes a self-fulfilling prophecy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Iqxfn8sg_400x400_9834e54a13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

