module 0xf5c7c8b6d2fdc1be7cda65a5537ed7b157309c924648bf7954ccf4abd2af758d::blefcat {
    struct BLEFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLEFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLEFCAT>(arg0, 6, b"BLEFCAT", b"Blue Eyed Fish Cat", b"With whiskers sharp as their trading instincts, these blue-eyed fishcats dominate the crypto seas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/04de8e6973daaf5f409e747b9f81d5f1_edad1908c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLEFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLEFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

