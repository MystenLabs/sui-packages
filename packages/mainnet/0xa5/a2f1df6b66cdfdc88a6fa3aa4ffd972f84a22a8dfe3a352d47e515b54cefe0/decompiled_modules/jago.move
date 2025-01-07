module 0xa5a2f1df6b66cdfdc88a6fa3aa4ffd972f84a22a8dfe3a352d47e515b54cefe0::jago {
    struct JAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAGO>(arg0, 6, b"Jago", b"sui jago", b"First ever $JAGO on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jago_7e8dba702a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

