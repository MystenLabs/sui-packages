module 0x12d904e0b8b6a30f074b3c4f7c976a436fc6e0cd8d8f56811aed4c2a354abdb8::robot {
    struct ROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOT>(arg0, 6, b"ROBOT", x"5355c4b020524f424f5453", x"524f424f5453204f4e205355c4b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984742781.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROBOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

