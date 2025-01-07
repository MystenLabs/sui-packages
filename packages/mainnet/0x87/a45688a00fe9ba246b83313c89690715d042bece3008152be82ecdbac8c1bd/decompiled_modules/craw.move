module 0x87a45688a00fe9ba246b83313c89690715d042bece3008152be82ecdbac8c1bd::craw {
    struct CRAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAW>(arg0, 6, b"CRAW", b"CrawFishOnSui", b"Mmmm Crawzaddy, let's have a boi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241005_073415_79ef425c40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

