module 0xf5b434c7e5ccb26245181bd45cc92d8597e51613ee7ba852a11d5048be10ba07::solby {
    struct SOLBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLBY>(arg0, 6, b"SOLBY", b"SOLBY by SUI", x"57686f2069732024534f4c4259200a4f6c64205363686f6f6c204d656d65200a68747470733a2f2f782e636f6d2f536f6c62795f7765623320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060548_9c54e727d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

