module 0x44857d60cd20392290ba08b68c3dab6771a153979df83e417eadbe0398a5e524::pps {
    struct PPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPS>(arg0, 6, b"PPS", b"PAPAPUMPSUI", b"PAPA COME HERE TO PUMP IT! FOLLOW PAPA, GROW UR SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PAPAPUMPSUI_29023c8e86.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

