module 0xee92c1bafdef5fe78a5aca196b9c1ab50d2f3ee62eae07cfe8c733bf2a7921e1::sgon {
    struct SGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGON>(arg0, 6, b"SGON", b"Sui Dragon", x"53474f4e204d656d6520546f6b656e204f6e2073756920436861696e200a68747470733a2f2f74656c656772612e70682f5375692d447261676f6e2d2d2d53474f4e2d31302d3133", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060232_a8364fdd29.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

