module 0x702fc2288e1bb75ea91bb780f043381e06eda66bca328b5b791c9878b8ee7843::sonny {
    struct SONNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONNY>(arg0, 6, b"SONNY", b"SONNY on SUI", x"492c20524f424f542e2057452c20524f424f542e20524f424f5453204e45564552204449452e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7t1_YUXV_9_400x400_79640754a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

