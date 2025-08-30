module 0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::zusdc {
    struct ZUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUSDC>(arg0, 6, b"ZUSDC", b"Zing version USDC", b"Zing USDC is the yield bearing token to collect the rewards from different strategies created by Zing Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/yYckWz3N/zusd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZUSDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

