module 0x900b867c3c4c17abe26957083a27d7bb67f0d5d5111f75c5c9647bef5c4db3eb::igor {
    struct IGOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGOR>(arg0, 6, b"IGOR", b"Igor Tiger", b"Pepe and Igor were close friends who always stuck together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Asset_33_768x668_b0f2b3c76c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IGOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

