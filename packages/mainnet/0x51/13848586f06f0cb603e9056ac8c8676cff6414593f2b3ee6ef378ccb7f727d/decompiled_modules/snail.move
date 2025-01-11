module 0x5113848586f06f0cb603e9056ac8c8676cff6414593f2b3ee6ef378ccb7f727d::snail {
    struct SNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAIL>(arg0, 9, b"Snail", b"Snail", b"Snail is a unique, eco-friendly meme coin built on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/svNnHKq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNAIL>(&mut v2, 4206900000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAIL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

