module 0x265b29648f038872d7153fd60b5e03733f19976240c9595bf0d0760bf0174883::suica {
    struct SUICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICA>(arg0, 6, b"SUICA", b"Suica", x"245355494341202d2041206c6567656e646172792066696374696f6e616c2063686172616374657220647261776e20627920436869686172752053616b617a616b692e200a0a4f6666696369616c206d6173636f74206f6620746865204a6170616e65736520737562776179200a4865726520746f207377696d206f76657220746865207375692065636f73797374656d20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_suica_tel_aa49a5672f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

