module 0xe0e4494e6a7a88100a32a2d2734e1449f2bacffc9db67939be68022ba168fbdd::npcsui {
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

