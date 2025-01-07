module 0x2d6f912b8454f201a60f188734f41ac9230f00ac47c6c6788a06dc8b24307aed::taguro {
    struct TAGURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAGURO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAGURO>(arg0, 6, b"TAGURO", b"Taguro", b"Dragon Ball Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731330403278.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAGURO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAGURO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

