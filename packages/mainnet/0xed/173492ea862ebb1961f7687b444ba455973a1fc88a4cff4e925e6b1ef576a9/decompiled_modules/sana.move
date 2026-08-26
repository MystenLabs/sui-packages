module 0xed173492ea862ebb1961f7687b444ba455973a1fc88a4cff4e925e6b1ef576a9::sana {
    struct SANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANA>(arg0, 9, b"SANA", b"SANA", b"SANA is a cute little lamb with a big heart. Soft, fluffy, and full of charm, MANA brings sweetness and fun to the crypto world. Just a tiny lamb here to make you smile.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/2mmTyguD6kcUFsB8pQ2I3hgwqQ7yaXV7MliLMT7i8V8")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SANA>>(0x2::coin::mint<SANA>(&mut v2, 1000000000000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SANA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANA>>(v1);
    }

    // decompiled from Move bytecode v7
}

