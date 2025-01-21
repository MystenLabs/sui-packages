module 0xcbddb34322c9dd282e4fe1c8f5457696b5467159a103b5c247ff8e99c2f1ab17::catfu {
    struct CATFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CATFU>(arg0, 6, b"CATFU", b"The Shaolin Kitty by SuiAI", b"An agent dealt the task of creating a story around a cat trying to become a kung fu master", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/catfu_1_45d9bbc9b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATFU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

