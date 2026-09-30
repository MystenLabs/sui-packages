module 0x24ed801fe1476dc1d69ac518d585c046719bebba43f52c28c1f703b8d47b108d::tes {
    struct TES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TES>(arg0, 9, b"tes", b"tes", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TES>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TES>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

