module 0x8472e2c900d6d910ce239b003069bc1dec8b7b89f73b825f4adc225ff12e297::cai {
    struct CAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CAI>(arg0, 6, b"CAI", b"CAI by SuiAI", b"CAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_12_b8c64a0c4a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

