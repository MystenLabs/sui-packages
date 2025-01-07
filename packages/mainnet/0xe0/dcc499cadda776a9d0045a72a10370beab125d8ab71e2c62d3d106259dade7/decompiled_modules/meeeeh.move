module 0xe0dcc499cadda776a9d0045a72a10370beab125d8ab71e2c62d3d106259dade7::meeeeh {
    struct MEEEEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEEEEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEEEEH>(arg0, 6, b"MEEEEH", b"FLUFFY SEAL", b"MEEEEEEEEEH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949655522.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEEEEH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEEEEH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

