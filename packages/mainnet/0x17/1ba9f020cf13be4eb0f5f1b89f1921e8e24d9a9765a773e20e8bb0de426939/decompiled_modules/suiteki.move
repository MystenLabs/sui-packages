module 0x171ba9f020cf13be4eb0f5f1b89f1921e8e24d9a9765a773e20e8bb0de426939::suiteki {
    struct SUITEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEKI>(arg0, 6, b"SUITEKI", b"Suiteki", x"0a4d6565742053756974656b692c20746865206d656d65207468617473206d616b696e6720612073706c617368206f6e207468652053554920626c6f636b636861696e2e20496e204a6170616e6573652c2053756974656b69206d65616e732077617465722064726f706c65742c20616e642074686973206d656d652063617074757265732074686520657373656e6365206f6620776174657220696e20626f746820697473206e616d6520616e64207370697269742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitledsds_design_b27c3cdd00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

