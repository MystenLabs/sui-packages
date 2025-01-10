module 0x23bd81ce5ebfb06ee229d0b707be2f0b5b888bddafb6b24ea33c34443c719142::russianwif {
    struct RUSSIANWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSSIANWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSSIANWIF>(arg0, 6, b"RUSSIANWIF", b"Russian Dog Wif Hat", b"Cyka Blyat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736535700953.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUSSIANWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSSIANWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

