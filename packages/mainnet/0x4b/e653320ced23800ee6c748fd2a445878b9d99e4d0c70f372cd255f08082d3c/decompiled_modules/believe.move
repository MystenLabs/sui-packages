module 0x4be653320ced23800ee6c748fd2a445878b9d99e4d0c70f372cd255f08082d3c::believe {
    struct BELIEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELIEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELIEVE>(arg0, 6, b"BELIEVE", b"Sui Believe", b"we all believe in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000073111_e68d7aa55e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELIEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELIEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

