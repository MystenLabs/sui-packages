module 0x8b2124ba75cc59ad5308073ea695a545cd67523b956d3389be49250a02aa50f9::meowdeng {
    struct MEOWDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWDENG>(arg0, 6, b"MEOWDENG", b"MEOWDENGSUI", x"4865723a204920776f6e64657220696620686573207468696e6b696e672061626f7574206d653f20200a4d653a2043617420737a6e202b204d4f4f44454e47203d204d656f772044656e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018212_d5aa5ca3c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

