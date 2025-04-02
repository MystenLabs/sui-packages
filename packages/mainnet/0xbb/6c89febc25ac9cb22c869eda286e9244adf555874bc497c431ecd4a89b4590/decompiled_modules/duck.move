module 0xbb6c89febc25ac9cb22c869eda286e9244adf555874bc497c431ecd4a89b4590::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"Duck", b"DuckToken", b"Welcome to the next generation of meme coins, the cutest duck ever making everyone feel safe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_C15_D474_716_F_43_C4_8772_55_E48085_C141_31f71f3cb4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

