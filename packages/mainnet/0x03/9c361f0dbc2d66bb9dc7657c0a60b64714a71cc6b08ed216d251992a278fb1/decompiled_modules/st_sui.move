module 0x39c361f0dbc2d66bb9dc7657c0a60b64714a71cc6b08ed216d251992a278fb1::st_sui {
    struct ST_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST_SUI>(arg0, 9, b"ST_SUI", b"Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ST_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

