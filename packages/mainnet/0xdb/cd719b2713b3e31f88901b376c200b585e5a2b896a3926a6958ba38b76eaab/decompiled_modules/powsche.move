module 0xdbcd719b2713b3e31f88901b376c200b585e5a2b896a3926a6958ba38b76eaab::powsche {
    struct POWSCHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POWSCHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POWSCHE>(arg0, 6, b"POWSCHE", b"POWSCHE ON SUI", b"First POWSCHE on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/powsche_flying_bills_1_540ecd1af5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POWSCHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POWSCHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

