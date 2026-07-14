module 0x410d64894d2c941a1599ad1c3aa54ecb59bab73755ddb6b6f63b06e85c4eee63::namete {
    struct NAMETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMETE>(arg0, 6, b"NAMETE", b"test name", b"test name test name test name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1784018593922.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMETE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMETE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

