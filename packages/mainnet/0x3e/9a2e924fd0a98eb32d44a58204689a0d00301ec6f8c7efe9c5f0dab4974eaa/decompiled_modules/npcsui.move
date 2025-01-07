module 0x3e9a2e924fd0a98eb32d44a58204689a0d00301ec6f8c7efe9c5f0dab4974eaa::npcsui {
    struct NPCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPCSUI>(arg0, 6, b"NPCSUI", b"NPC on SUI", b"Admit it. You are NPC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NPCSUI_5eee4e30ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

