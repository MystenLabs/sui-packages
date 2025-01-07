module 0x3896175ae44a44ebe7e19367eed0d29724f44c95769e7ad0f342dbf676856308::tmc {
    struct TMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMC>(arg0, 6, b"TMC", b"TibetanMastiffCoin", b"$TMC born From our majestic Tibetan Mastiff to the network thats always pushing boundaries. Heres to many more years of growth, innovation, and reaching for the stars!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017490_638337af07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

