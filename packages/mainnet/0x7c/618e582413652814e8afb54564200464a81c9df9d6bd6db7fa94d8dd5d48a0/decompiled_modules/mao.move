module 0x7c618e582413652814e8afb54564200464a81c9df9d6bd6db7fa94d8dd5d48a0::mao {
    struct MAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAO>(arg0, 6, b"MAO", b"aaaMao", b"aaa cat chinese version (aaaMo),Can't stop, won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6763_35e1bb4757.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

