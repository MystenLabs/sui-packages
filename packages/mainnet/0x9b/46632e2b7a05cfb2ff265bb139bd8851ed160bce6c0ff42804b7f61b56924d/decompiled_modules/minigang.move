module 0x9b46632e2b7a05cfb2ff265bb139bd8851ed160bce6c0ff42804b7f61b56924d::minigang {
    struct MINIGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIGANG>(arg0, 6, b"MiniGang", b"Mini", b"Entering a \"Murad is right\" arc. If you're not paying attention, $mini has the attention of an entire spread of the market well before becoming consensus. Mindshare hasn't even begun, yet it's pulling engagement via VC leaning heads + well respected OG's alike. Tick tock. $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/15_971177d2e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIGANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINIGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

