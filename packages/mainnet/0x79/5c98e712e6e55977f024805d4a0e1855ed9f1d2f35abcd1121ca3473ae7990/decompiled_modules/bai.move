module 0x795c98e712e6e55977f024805d4a0e1855ed9f1d2f35abcd1121ca3473ae7990::bai {
    struct BAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAI>(arg0, 6, b"BAI", b"Birds AI Agent", b"The official token of the leading Memecoin & GameFi Telegram mini-app. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BIRDS_ed6d455db8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

