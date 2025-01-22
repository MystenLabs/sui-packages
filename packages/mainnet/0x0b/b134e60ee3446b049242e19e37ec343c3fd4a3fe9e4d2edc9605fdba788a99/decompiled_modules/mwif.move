module 0xbb134e60ee3446b049242e19e37ec343c3fd4a3fe9e4d2edc9605fdba788a99::mwif {
    struct MWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MWIF>(arg0, 6, b"MWIF", b"melania wif hat by SuiAI", b"just for fun melania trump the first lady of united state ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/lea_1_3f0391c0cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MWIF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWIF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

