module 0x1ae031a1c9910468fb9063b9373cdf320d50a2a1cb6d947503486b49808591c7::chui {
    struct CHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUI>(arg0, 6, b"CHUI", b"CHUI ON SUI", b"MEET CHUI ON SUI - CHUI SUPPORTS SUI AND GME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHUI_2_d1a86add43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

