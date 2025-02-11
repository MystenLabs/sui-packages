module 0xbd328e5bbefe84f0772a910f476d1b2af49b5074c77899fbbfab0b15c8a5a173::blacky {
    struct BLACKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKY>(arg0, 6, b"BLACKY", b"The Blacky Cat", b"Meet Blacky: Sleek and stylish, he'll slap you so hard wit his with you wont know what happened", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035513_6a447cd900.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

