module 0x9caf0442589877144543f3feda6def73144da8bf71366b35f2b24f7a978f86d2::lps {
    struct LPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPS>(arg0, 6, b"LPS", b"Lil Pump Sui", b"Community Trader Rapper is Key", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4254_69541b8ead.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

