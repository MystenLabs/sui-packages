module 0xde2525242276db8b891fb2c3035fbbce85c0df2e1eb5f40e7197dbe98d15c523::catcar {
    struct CATCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CATCAR>(arg0, 6, b"CATCAR", b"CatCar agents by SuiAI", b"CatCar is cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_20250113_083542_225_cc79fcb594.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATCAR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCAR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

