module 0xbef4aa0cb418602862659d50746a1cd7bed1af8012bea0907a83ddcea92b405d::Good_Morning {
    struct GOOD_MORNING has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOD_MORNING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOD_MORNING>(arg0, 9, b"GM", b"Good Morning", b"good morning degens. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzxBOpeW0AEmQxV?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOD_MORNING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOD_MORNING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

