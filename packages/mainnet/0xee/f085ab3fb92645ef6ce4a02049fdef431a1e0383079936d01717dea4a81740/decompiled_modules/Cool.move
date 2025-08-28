module 0xeef085ab3fb92645ef6ce4a02049fdef431a1e0383079936d01717dea4a81740::Cool {
    struct COOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOL>(arg0, 9, b"COOL", b"Cool", b"just cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzOfVlYXcAALg5K?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

