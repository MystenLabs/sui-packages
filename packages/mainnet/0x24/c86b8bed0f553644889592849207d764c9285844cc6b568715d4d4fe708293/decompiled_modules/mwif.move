module 0x24c86b8bed0f553644889592849207d764c9285844cc6b568715d4d4fe708293::mwif {
    struct MWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWIF>(arg0, 6, b"MWIF", b"Moo DengWif Hat", b"A fan based meme coin for the world's most famous baby hippo, Moo Deng, but wif a hat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005919_63dd16b874.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

