module 0x82b834b6a0924d88def64b5826f6cd4a4aaeed0880785df3660637a6f60d989a::mojo {
    struct MOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJO>(arg0, 6, b"MOJO", b"MOJO ON SUI", x"48492c2049276d204d6f6a6f206f6e2053554920616e642049276d2074686520666972737420696c6c757374726174696f6e20647261776e206279204d61747420467572696520696e20313938352e0a61667465722074686520646f776e66616c6c206f6620746865206c617374206d6f6a6f2066726f6d20706c616e65742073756920692074686f7567687420746861742077652063616e206275696c6420736f6d657468696e672066726f6d207468652073616d65206879706520746861742068616420746865206669727374206d6f6a6f2e2e2e206c65742773206275696c6420746865207472757374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731600900557.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOJO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

