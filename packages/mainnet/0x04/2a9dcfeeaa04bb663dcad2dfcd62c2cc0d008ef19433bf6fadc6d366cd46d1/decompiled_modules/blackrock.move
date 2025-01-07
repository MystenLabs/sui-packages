module 0x42a9dcfeeaa04bb663dcad2dfcd62c2cc0d008ef19433bf6fadc6d366cd46d1::blackrock {
    struct BLACKROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKROCK>(arg0, 6, b"BLACKROCK", b"BlackRock", b"Code : Stone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/07666c720513066838884f374ffa2d2a_1b6985c315.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

