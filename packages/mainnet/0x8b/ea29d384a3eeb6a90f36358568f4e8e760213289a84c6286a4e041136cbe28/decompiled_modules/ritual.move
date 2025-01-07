module 0x8bea29d384a3eeb6a90f36358568f4e8e760213289a84c6286a4e041136cbe28::ritual {
    struct RITUAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RITUAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RITUAL>(arg0, 6, b"Ritual", b"Ritual on Sui", b"666 <>", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zyzx9_W8_AA_0_Zi9_6d2370c7e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RITUAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RITUAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

