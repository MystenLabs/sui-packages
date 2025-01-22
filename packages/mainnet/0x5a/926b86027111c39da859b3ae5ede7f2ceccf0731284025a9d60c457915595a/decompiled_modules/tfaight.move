module 0x5a926b86027111c39da859b3ae5ede7f2ceccf0731284025a9d60c457915595a::tfaight {
    struct TFAIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFAIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TFAIGHT>(arg0, 6, b"TFAIGHT", b"Trump Fight by SuiAI", b"Sui's AI Agent: Redefining the future, making it great like Trump MAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/super_resolution_20250119224204729_83747466456631929246447_09152063868835068748879_ad1ebec299.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TFAIGHT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFAIGHT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

