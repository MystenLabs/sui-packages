module 0x6a960223955df29abd76e84c028ad496f897a627b166e61e8165ce1d2a4af299::hogwarts {
    struct HOGWARTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOGWARTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOGWARTS>(arg0, 6, b"HOGWARTS", b"Hairy Slother", b"ELON MUSKS Darling Sloth: Hairy Slother, the Wizard from Hogwarts!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/output_1_4630d7032f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOGWARTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOGWARTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

