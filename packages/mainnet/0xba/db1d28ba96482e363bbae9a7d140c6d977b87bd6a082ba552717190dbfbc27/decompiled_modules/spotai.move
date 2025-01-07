module 0xbadb1d28ba96482e363bbae9a7d140c6d977b87bd6a082ba552717190dbfbc27::spotai {
    struct SPOTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOTAI>(arg0, 6, b"SPOTAI", b"SPOT AI SUI", b"Just a trading buybot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005188_ec44518569.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

