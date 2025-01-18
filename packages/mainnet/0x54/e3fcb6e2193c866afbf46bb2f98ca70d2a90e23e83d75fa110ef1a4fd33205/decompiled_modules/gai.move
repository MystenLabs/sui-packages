module 0x54e3fcb6e2193c866afbf46bb2f98ca70d2a90e23e83d75fa110ef1a4fd33205::gai {
    struct GAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GAI>(arg0, 6, b"GAI", b"GordonAi by SuiAI", b"You want money? Buy more. Lets send this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0080_82c1965791.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

