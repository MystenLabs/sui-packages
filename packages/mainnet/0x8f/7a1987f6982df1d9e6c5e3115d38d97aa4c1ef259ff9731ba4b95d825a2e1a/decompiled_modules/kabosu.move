module 0x8f7a1987f6982df1d9e6c5e3115d38d97aa4c1ef259ff9731ba4b95d825a2e1a::kabosu {
    struct KABOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSU>(arg0, 6, b"KABOSU", b"kabosu", x"546865206d656d6520717565656e2c20746865206f672c20746865206661636520626568696e6420646f67652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000371_e057c80ee5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

