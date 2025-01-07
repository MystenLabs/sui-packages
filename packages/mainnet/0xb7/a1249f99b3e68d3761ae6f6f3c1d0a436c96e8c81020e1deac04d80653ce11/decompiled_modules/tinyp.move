module 0xb7a1249f99b3e68d3761ae6f6f3c1d0a436c96e8c81020e1deac04d80653ce11::tinyp {
    struct TINYP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINYP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINYP>(arg0, 6, b"TINYP", b"Tiny Panda", b"Everyone has a home at $TINYP --- new or veteran to crypto, you are welcome!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017529_0dc2c89b7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINYP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINYP>>(v1);
    }

    // decompiled from Move bytecode v6
}

