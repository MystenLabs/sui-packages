module 0xc8b2959e6f0bfd29a3dd56a4b7eb467e3ea8e5ea63f154cd5f928cdbd5b8ac7d::squid_money_478239 {
    struct SQUIDTOKEN478239 has drop {
        dummy_field: bool,
    }

    fun internal_init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SQUIDTOKEN478239{dummy_field: true};
        let (v1, v2) = 0x2::coin::create_currency<SQUIDTOKEN478239>(v0, 9, b"SQD239", b"SQUIDTOKEN478239", b"The ultra-rare squid beast of the deep. Mint at your own risk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/IFK9dSr.png")), arg0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIDTOKEN478239>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDTOKEN478239>>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SQUIDTOKEN478239>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SQUIDTOKEN478239>(arg0, arg1, arg2, arg3);
    }

    public entry fun start(arg0: &mut 0x2::tx_context::TxContext) {
        internal_init(arg0);
    }

    // decompiled from Move bytecode v6
}

