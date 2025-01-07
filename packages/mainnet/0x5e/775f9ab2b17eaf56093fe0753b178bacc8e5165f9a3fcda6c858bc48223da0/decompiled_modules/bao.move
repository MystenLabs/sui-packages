module 0x5e775f9ab2b17eaf56093fe0753b178bacc8e5165f9a3fcda6c858bc48223da0::bao {
    struct BAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BAO>(arg0, 6, b"BAO", b"BAO by SuiAI", b"YOU DIM SUM, YOU LOSE SUM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_2f682508b5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

