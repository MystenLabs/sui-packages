module 0xb06189341bef5a749a285d5231a80dec78f93196b2d4f303c1c35bf40b8427e8::koi {
    struct KOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOI>(arg0, 6, b"KOI", b"KOI FISH", b"A meme coin you'll go quackers for.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_11_8dafacc53a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

