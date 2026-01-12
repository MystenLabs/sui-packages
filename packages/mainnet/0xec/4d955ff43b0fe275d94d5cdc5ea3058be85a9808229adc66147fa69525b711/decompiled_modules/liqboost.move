module 0xec4d955ff43b0fe275d94d5cdc5ea3058be85a9808229adc66147fa69525b711::liqboost {
    struct LIQBOOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQBOOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQBOOST>(arg0, 6, b"LIQBOOST", b"WALUI - LIQBOOST", x"244c4951424f4f53543a2050756d7020746f20626f6f73742057414c5549206c697175696469747921204661697220547572626f73206c61756e636820e28692206761696e732066756e642057414c554920706f6f6c73202620726577617264732e20446567656e206675656c2120f09f92a6f09f8c9520436865636b2057414c5549204661726d206f6e2041667465726d61746820262043657274757320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1768181451953.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIQBOOST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQBOOST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

