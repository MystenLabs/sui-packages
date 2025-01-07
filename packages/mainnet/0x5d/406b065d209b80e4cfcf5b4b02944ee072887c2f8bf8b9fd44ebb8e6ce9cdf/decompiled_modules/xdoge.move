module 0x5d406b065d209b80e4cfcf5b4b02944ee072887c2f8bf8b9fd44ebb8e6ce9cdf::xdoge {
    struct XDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDOGE>(arg0, 6, b"XDOGE", b"Twitter Doge", b"Twitter Doge, combining the charm of Dogecoin with the chaotic energy of Twitter. Fueled by likes, retweets, and viral memes, it promises to unite the internets quirkiest communities. In this digital playground, every tweet could spark a moonshot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_21_20_58_10_449abdd81d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

