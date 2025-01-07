module 0xd23dc2dd8363d4fd2ac94607292b9dd814a164cb7dc668dd328a6c24907802cc::shibdoge {
    struct SHIBDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBDOGE>(arg0, 6, b"Shibdoge", b"Shibadoge", x"4d69737365642053686962613f204d697373656420446f67653f20446f6e2774206d697373205368696261446f6765210a5368696261446f67652069732074686520666972737420636f6d6d756e6974792d64726976656e207574696c69747920746f6b656e2063726561746564206279205368696261202620446f6765636f696e207768616c657320636f6d696e6720746f67657468657220666f7220746865206772656174657220676f6f64206f6620626f746820636f6d6d756e69746965732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734540932473.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

