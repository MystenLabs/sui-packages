module 0x63bd57924933e244cb2d71442eeb28835b76b57fe684a45364ac501d01d4858e::tdog {
    struct TDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDOG>(arg0, 6, b"tDOG", b"Tiktok Dog", b"lest make some sweet in your life with tDOG on SUI, Woof...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TDOG_b1fa5d17d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

