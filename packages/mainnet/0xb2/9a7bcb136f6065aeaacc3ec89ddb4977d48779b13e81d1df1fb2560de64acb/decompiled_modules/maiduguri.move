module 0xb29a7bcb136f6065aeaacc3ec89ddb4977d48779b13e81d1df1fb2560de64acb::maiduguri {
    struct MAIDUGURI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAIDUGURI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIDUGURI>(arg0, 8, b"MAIDUGURI", b"MAIDUGURI ON SUI", b"MAIDUGURI Taught Sui. Here's proof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://framerusercontent.com/images/0KKocValgAmB9XHzcFI6tALxGGQ.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MAIDUGURI>>(0x2::coin::mint<MAIDUGURI>(&mut v2, 30000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAIDUGURI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAIDUGURI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

