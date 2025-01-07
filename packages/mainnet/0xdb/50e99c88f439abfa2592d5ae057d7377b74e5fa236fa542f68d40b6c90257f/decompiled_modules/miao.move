module 0xdb50e99c88f439abfa2592d5ae057d7377b74e5fa236fa542f68d40b6c90257f::miao {
    struct MIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAO>(arg0, 6, b"MIAO", b"Sui Miao", b"MIAO Coin is a cute and adorable Real Emotionless Cat Meow Meow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012557_c921f025c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

