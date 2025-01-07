module 0x784da49d8635c2462118f620dea63383e2019f9529799fcfdd267ef5b3c425a4::nitro {
    struct NITRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NITRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NITRO>(arg0, 6, b"NITRO", b"Nitro", b"Nitro have some GAS for Turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952505139.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NITRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NITRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

