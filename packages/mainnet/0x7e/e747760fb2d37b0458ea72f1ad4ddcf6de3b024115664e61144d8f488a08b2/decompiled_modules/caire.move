module 0x7ee747760fb2d37b0458ea72f1ad4ddcf6de3b024115664e61144d8f488a08b2::caire {
    struct CAIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CAIRE>(arg0, 6, b"CAIRE", b"C.A.I.R.E by SuiAI", x"432e412e492e522e452e20e2809320436f6d70617373696f6e617465204172746966696369616c20496e74656c6c6967656e636520666f7220526573696c69656e6365202620456d7061746879", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/d0556480_f824_4011_a817_552c02cb0155_b764f685dc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAIRE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAIRE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

