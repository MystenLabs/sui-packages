module 0xea3b0e16108398a26f4f63477a79a3921bd59fee2b761ababc79f11853ee96f7::peppa {
    struct PEPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPPA>(arg0, 6, b"Peppa", b"Peppa Pig", b"the most popular pig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmexport1625720603067_3de629b476.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

