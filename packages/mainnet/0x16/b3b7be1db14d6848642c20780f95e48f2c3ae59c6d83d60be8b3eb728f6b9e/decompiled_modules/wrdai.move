module 0x16b3b7be1db14d6848642c20780f95e48f2c3ae59c6d83d60be8b3eb728f6b9e::wrdai {
    struct WRDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WRDAI>(arg0, 6, b"WRDAI", b"suiaiword", b"universal insane token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000035447_f8188aaaf5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WRDAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRDAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

