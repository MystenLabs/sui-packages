module 0x2f7c5d5d3b5286225b5872dea2340e5752492921a5e06dfbfffe6ed5dcc00c70::robo {
    struct ROBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBO>(arg0, 6, b"ROBO", x"5355c4b020524f424f5453", x"524f424f5453204f4e205355c4b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984850149.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

