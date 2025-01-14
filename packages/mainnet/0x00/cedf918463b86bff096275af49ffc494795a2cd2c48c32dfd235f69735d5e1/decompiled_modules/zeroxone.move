module 0xcedf918463b86bff096275af49ffc494795a2cd2c48c32dfd235f69735d5e1::zeroxone {
    struct ZEROXONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEROXONE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZEROXONE>(arg0, 6, b"ZEROXONE", b"SuiPlay0X1 by SuiAI", b"0X1 the first-of-its-kind handheld gaming console with integrated AI, supporting a wide range of PC games and new AAA titles developed using Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/a1ccb883_abd0_4a8f_b031_9e6b5f6bce5f_2873c0f529.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZEROXONE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEROXONE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

