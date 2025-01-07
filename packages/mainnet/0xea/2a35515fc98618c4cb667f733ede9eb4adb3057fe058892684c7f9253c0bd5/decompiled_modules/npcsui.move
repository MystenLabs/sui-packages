module 0xea2a35515fc98618c4cb667f733ede9eb4adb3057fe058892684c7f9253c0bd5::npcsui {
    struct NPCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPCSUI>(arg0, 6, b"NPCSUI", b"NPC on SUI", b"Admit it. You are a NPC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NPCSUI_4bad6d5390.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

