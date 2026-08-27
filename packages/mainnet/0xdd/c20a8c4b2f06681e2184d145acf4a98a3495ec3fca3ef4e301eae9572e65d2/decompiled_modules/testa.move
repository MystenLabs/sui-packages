module 0xddc20a8c4b2f06681e2184d145acf4a98a3495ec3fca3ef4e301eae9572e65d2::testa {
    struct TESTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTA>(arg0, 9, b"TESTA", b"TESTA", b"TESTA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/uc-MLiD_Y9pCYHs1nlJS6z00MfXVVfGE7XthPWrWin4")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTA>>(0x2::coin::mint<TESTA>(&mut v2, 1000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTA>>(v1);
    }

    // decompiled from Move bytecode v7
}

