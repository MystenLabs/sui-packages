module 0xa2bc47b47d7bc3e8afd0204eed6c2bea3838b2c049539dbe8e9085ad1bcfd562::erf {
    struct ERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERF>(arg0, 6, b"ERF", b"Erf Doge", b"Doge luv Erf. Much want cake care of. brin bark frenz. Such make wurld butter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_Jkf_SC_8_Q_400x400_12d124eee7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERF>>(v1);
    }

    // decompiled from Move bytecode v6
}

