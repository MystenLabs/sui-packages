module 0xbd74104b08bd9bd95b3f44b40f8631f461a861ec56c2c59a5c0bc4d8b5d47673::aftrn {
    struct AFTRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFTRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFTRN>(arg0, 6, b"AFTRN", b"antifrontrunner", b"antifrontrunner we dont like them", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihaso3rtthdk65kwh3rk7ji2kdiyegxvzgsjyj62eaeelsv47txbq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFTRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AFTRN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

