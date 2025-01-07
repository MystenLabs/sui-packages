module 0x768c61263e48736745cbc8f5bb49ee3167eafbee7abfd3d9aeab21cde1c59a7e::dlub {
    struct DLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLUB>(arg0, 6, b"DLUB", b"Sui Fish Dlub", b"In $DLUB, we always calculate billion-dollar conversions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043796_cc474aa83f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

