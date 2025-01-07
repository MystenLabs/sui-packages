module 0xc5a8fcd06bf5050bfa2595cde8f1eb18d003b5ca9ee310917786532938f9f498::sadsui {
    struct SADSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADSUI>(arg0, 6, b"SADSUI", b"SAD SUI", b"SUI IS SAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sadsui_96995d429f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

