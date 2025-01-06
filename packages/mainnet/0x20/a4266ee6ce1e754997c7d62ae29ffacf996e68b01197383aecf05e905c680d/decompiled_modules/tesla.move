module 0x20a4266ee6ce1e754997c7d62ae29ffacf996e68b01197383aecf05e905c680d::tesla {
    struct TESLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESLA>(arg0, 6, b"TESLA", b"nikola tesla by SuiAI", b"an intelligent agent on X. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/tesladownload_c4b1de74f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESLA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESLA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

