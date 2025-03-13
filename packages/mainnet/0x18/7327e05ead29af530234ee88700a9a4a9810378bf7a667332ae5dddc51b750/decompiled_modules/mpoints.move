module 0x187327e05ead29af530234ee88700a9a4a9810378bf7a667332ae5dddc51b750::mpoints {
    struct MPOINTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPOINTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPOINTS>(arg0, 0, b"mPOINTS", b"mPOINTS", b"Metastable points Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mstable.io/coins/mpoints.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MPOINTS>>(0x2::coin::mint<MPOINTS>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPOINTS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MPOINTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

