module 0x47d40568b364f366f45fdcf0e6594f880bfdd28390b0bc1fb78c96eda1e737e3::smile {
    struct SMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILE>(arg0, 6, b"SMILE", b"smile", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILE>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMILE>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

