module 0xde2822598fbf949143cd57bf61d0ed07ae545e859222d380255109645c4d6cb6::testnet {
    struct TESTNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTNET>(arg0, 6, b"TESTNET", b"TEST NAME", b"TEST NAME TEST NAME TEST NAME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1784018864190.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTNET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTNET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

