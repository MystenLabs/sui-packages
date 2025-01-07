module 0x7dfb5f3434335cd366b4a9929821b50b4ae9a20f5c0184d461ada4f20e4a3b32::cumcoin {
    struct CUMCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUMCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUMCOIN>(arg0, 6, b"CUMCOIN", b"CUMCOIN_CTO", x"46726f6d2020746865206f726967696e616c2046617274636f696e206465762e2043554d434f494e0a54686520706572666563742043554d4241434b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735981983493.dexscreener")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUMCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUMCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

