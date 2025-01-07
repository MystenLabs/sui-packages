module 0xa8ff90a362d7c6b900821123f3809f19742f798ed3fed365ef3e33f93371c6bc::boysclub {
    struct BOYSCLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYSCLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYSCLUB>(arg0, 6, b"BOYSCLUB", b"Boysclub on Sui", b"Where memes meet friendship in perfect harmony. Step into the world of Pepe, Andy, Brett, Bird Dog and Landwolf!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732227291248.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOYSCLUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYSCLUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

