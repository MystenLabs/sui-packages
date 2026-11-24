module 0xa4f1404edfe8c9de4caff58b41655bc661e10ba07aafe0e12178eb4e1b598e9e::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nBlue";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dBlue";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"BLUE", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/zQRLs5mqCnE3tElk")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

