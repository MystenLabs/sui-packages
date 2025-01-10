module 0x8013c98c416f3d4548b6df559ed37453884a4946754f3e303032438cdfa47b76::suiad {
    struct SUIAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIAD>(arg0, 6, b"SUIAD", b"SUIAD by SuiAI", b"SUIAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_20250111_030143_259_89ac482445.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIAD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

