module 0x9835df6f083b8f6c24a62e24653990a2fc5e0a73375d089353973c088d426815::brattet {
    struct BRATTET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRATTET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRATTET>(arg0, 6, b"BRATTET", b"Bratt Brett On Sui", b"Dexscreener soon.Check here: https://www.brattsui.monster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/top_1_d43cb676db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRATTET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRATTET>>(v1);
    }

    // decompiled from Move bytecode v6
}

