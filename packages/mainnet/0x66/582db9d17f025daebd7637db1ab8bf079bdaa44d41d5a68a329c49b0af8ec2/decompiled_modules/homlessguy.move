module 0x66582db9d17f025daebd7637db1ab8bf079bdaa44d41d5a68a329c49b0af8ec2::homlessguy {
    struct HOMLESSGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMLESSGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMLESSGUY>(arg0, 6, b"HOMLESSGUY", b"Homeless Guy", b"Chill Guy turned Homeless Guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1735840067282_143737ef5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMLESSGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMLESSGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

