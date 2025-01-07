module 0x5c373c9352ce3fc744776b2b24135f7619de15ef66eeddc74c2c35cee782fcb3::esui {
    struct ESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESUI>(arg0, 6, b"Esui", b"elonsui", b"elon + sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_a_a_a_a_a_a_a_2024_11_01_171225_74ee9c7787.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

