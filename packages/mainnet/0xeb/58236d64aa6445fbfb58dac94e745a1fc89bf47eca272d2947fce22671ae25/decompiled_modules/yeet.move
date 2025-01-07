module 0xeb58236d64aa6445fbfb58dac94e745a1fc89bf47eca272d2947fce22671ae25::yeet {
    struct YEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEET>(arg0, 6, b"YEET", b"YEET ON SUI", b"YEEEEEEET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yeet_scrabble_64941d8e8f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

