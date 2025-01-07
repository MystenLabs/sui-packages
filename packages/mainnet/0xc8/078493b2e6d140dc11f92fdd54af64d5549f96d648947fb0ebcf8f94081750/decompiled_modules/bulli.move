module 0xc8078493b2e6d140dc11f92fdd54af64d5549f96d648947fb0ebcf8f94081750::bulli {
    struct BULLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLI>(arg0, 6, b"BULLI", b"Bullishify.sui", b"Sui Maxi | DeFi Researcher & Alpha Hunter | Sui Ecosystem Advocate | Future ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bully_5140179b60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

