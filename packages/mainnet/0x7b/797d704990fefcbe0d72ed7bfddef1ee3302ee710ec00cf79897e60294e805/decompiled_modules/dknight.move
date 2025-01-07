module 0x7b797d704990fefcbe0d72ed7bfddef1ee3302ee710ec00cf79897e60294e805::dknight {
    struct DKNIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKNIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKNIGHT>(arg0, 6, b"DKNIGHT", b"DarkKnight on SUI", x"5468652024444b4e4947485420697320636f6d696e672e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BATSUI_4734e9b138.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKNIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DKNIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

