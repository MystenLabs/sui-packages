module 0x2ccbeb2838d895ebc5a336116b699d1fb6e2155dd1c430399a2150b114c48814::suigure {
    struct SUIGURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGURE>(arg0, 6, b"SUIgure", b"Shigure", b"shigureui.live . Roll with the $SUIgure Crew: Shigure Badass Gang!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c862247e_469e_41e1_907a_11ce14f089d5_removebg_preview_d33f3054ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

