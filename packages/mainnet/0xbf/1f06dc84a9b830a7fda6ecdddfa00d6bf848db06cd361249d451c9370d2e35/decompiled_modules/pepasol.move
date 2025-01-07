module 0xbf1f06dc84a9b830a7fda6ecdddfa00d6bf848db06cd361249d451c9370d2e35::pepasol {
    struct PEPASOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPASOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPASOL>(arg0, 6, b"PEPASOL", b"PepaSui", b"I'm here to show Pepe that leaving me was the biggest mistake of his life!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ea_f779bac3b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPASOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPASOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

