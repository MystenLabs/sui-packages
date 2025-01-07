module 0xe3dc4cc7e7439e7a33235e7c3a383234fa6e900cdffb505b95a28c77a7173dae::suirk {
    struct SUIRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRK>(arg0, 6, b"SUIRK", b"suirg", b"WELCOME TO SEA OF MONEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/23_c2f3492906.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

