module 0xdfb015ce7c492795c5e073ba09ff99d6104b667a35be0df4589122d0bd40bf4e::Orange_Pill {
    struct ORANGE_PILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGE_PILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANGE_PILL>(arg0, 9, b"OP", b"Orange Pill", b"which pill?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GyoLE4fXwAAfPNt?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORANGE_PILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGE_PILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

