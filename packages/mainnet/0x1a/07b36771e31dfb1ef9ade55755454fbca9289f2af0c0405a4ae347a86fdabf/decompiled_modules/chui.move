module 0x1a07b36771e31dfb1ef9ade55755454fbca9289f2af0c0405a4ae347a86fdabf::chui {
    struct CHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUI>(arg0, 6, b"CHUI", b"CHUI ON SUI", b"MEET CHUI ON SUI - RELAUNCH - IN SUPPORT OF GME OF SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHUI_2_560c18bb3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

