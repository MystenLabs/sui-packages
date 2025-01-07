module 0x2725a47250429f05883266dd7027a1648855554bba01b904ccb44058ac06696a::enbi {
    struct ENBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENBI>(arg0, 6, b"ENBI", b"Enbi was spiddey", b"EN BI CI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_111717_c766d851dc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

