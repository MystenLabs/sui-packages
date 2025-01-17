module 0x2725fd798da2d126a69ebf4996c9e6b3c27bacb0822764c263f9fe120348ba39::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<A>(arg0, 6, b"A", b"a by SuiAI", b"a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ava_b825e54084.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<A>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

