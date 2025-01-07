module 0xcacd5e418433e6b124ce52276f786d4d056545904b273e0c153f1692f66ed8fd::pinut {
    struct PINUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINUT>(arg0, 6, b"PINUT", b"SUI PINUT", b"PINUT IN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731586670136.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

