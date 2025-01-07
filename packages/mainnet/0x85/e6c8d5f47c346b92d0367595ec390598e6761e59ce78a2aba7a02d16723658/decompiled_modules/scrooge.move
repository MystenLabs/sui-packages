module 0x85e6c8d5f47c346b92d0367595ec390598e6761e59ce78a2aba7a02d16723658::scrooge {
    struct SCROOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCROOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCROOGE>(arg0, 6, b"SCROOGE", b"Scrooge", x"5363726f6f6765206d656d6520636f696e206f6e20535549204e4554574f524b0a49742773206162736f6c7574656c792067656d2c2062757920697421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Scrooge_1987_ba8188ee3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCROOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCROOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

