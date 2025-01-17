module 0xa0ed1b4e63a992ede9625dabdd75b5cea9d88ef4f7b6b6953337352d1832d294::trumptrix {
    struct TRUMPTRIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPTRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPTRIX>(arg0, 6, b"Trumptrix", b"Matrix trump", b"limber", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737145048893.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPTRIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPTRIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

