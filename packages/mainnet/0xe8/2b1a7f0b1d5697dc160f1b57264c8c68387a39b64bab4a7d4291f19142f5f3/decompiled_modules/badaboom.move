module 0xe82b1a7f0b1d5697dc160f1b57264c8c68387a39b64bab4a7d4291f19142f5f3::badaboom {
    struct BADABOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADABOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADABOOM>(arg0, 6, b"Badaboom", b"Banana Kaboom", b"Minions Cooking Crypto Badaboom! Every time someone buys our token, there's gonna be a tiny banana explosion, making the whole universe a little bit happier.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_76f1a5bf70.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADABOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADABOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

