module 0x5e2f2f9f5d3b962e669f99505562090f53998a383489c51665ac86cb0adde3c7::dddd {
    struct DDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDDD>(arg0, 6, b"dddd", b"sss", b"sadasdsadasadsdsa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBGKQ13Y6FNVNTP0JMBHCN76/01JBGRX4VD6YGK2CM69ZNFQVWK")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DDDD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

