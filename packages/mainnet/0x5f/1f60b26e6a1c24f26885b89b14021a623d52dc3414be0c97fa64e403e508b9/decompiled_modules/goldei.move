module 0x5f1f60b26e6a1c24f26885b89b14021a623d52dc3414be0c97fa64e403e508b9::goldei {
    struct GOLDEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDEI>(arg0, 6, b"GOLDEI", b"Sui Goldei", x"57656c636f6d6520746f20476f6c64696520200a466f7220746865206c6f7665206f6620646f67732c20657370656369616c6c7920476f6c64656e20526574726965766572732120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014250_eee2541367.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

