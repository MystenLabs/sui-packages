module 0x77f680f2ea8e384f6ff649373d025a15764580aa30f8886ec3579e664e3a4678::pct {
    struct PCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCT>(arg0, 6, b"PCT", b"Pochita", b"meme of dog pochita", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1018_00c7580588.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

