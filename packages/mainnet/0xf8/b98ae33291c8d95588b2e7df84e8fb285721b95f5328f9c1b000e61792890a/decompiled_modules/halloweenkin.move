module 0xf8b98ae33291c8d95588b2e7df84e8fb285721b95f5328f9c1b000e61792890a::halloweenkin {
    struct HALLOWEENKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEENKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEENKIN>(arg0, 6, b"HALLOWEENKIN", b"Halloweenkin", b"Halloween Pumpkin ready for halloween ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031395_577928eb90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWEENKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOWEENKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

