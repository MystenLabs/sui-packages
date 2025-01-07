module 0x94f84fe3897f011059da4278d81abc611e27988c57f6218070a774cd27f8f95b::moist {
    struct MOIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOIST>(arg0, 6, b"MOIST", b"moist", b"Sui, the water network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moist_9866b72184.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

