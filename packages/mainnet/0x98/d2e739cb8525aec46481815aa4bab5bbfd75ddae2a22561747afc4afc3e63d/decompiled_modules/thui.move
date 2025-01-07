module 0x98d2e739cb8525aec46481815aa4bab5bbfd75ddae2a22561747afc4afc3e63d::thui {
    struct THUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THUI>(arg0, 6, b"ThUI", b"Mike on SUI", b"Mike is all in on SUI... He'll tell ya'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mike_hoodie_6e2f8aa1c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

