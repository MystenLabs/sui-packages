module 0xeadbd5978e5489facd288d050778c69bb80b6630e8dbf69ff182364b0e136047::poo {
    struct POO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<POO>(arg0, 6, b"POO", b"poochan by SuiAI", b"very cute poodle girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0840_bd1e985a9f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

