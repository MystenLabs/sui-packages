module 0xd9269c98d5d950d95a303bd862cb39198f694d134b1c29219f1d0249d3edd801::sarinew {
    struct SARINEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARINEW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SARINEW>(arg0, 6, b"SARINEW", b"SARINEW by SuiAI", b"SARINEW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_b109eb2d39.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SARINEW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARINEW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

