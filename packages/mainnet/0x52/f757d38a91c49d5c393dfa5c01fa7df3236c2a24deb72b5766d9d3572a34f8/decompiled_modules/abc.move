module 0x52f757d38a91c49d5c393dfa5c01fa7df3236c2a24deb72b5766d9d3572a34f8::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ABC>(arg0, 6, b"ABC", b"ABC by SuiAI", b"ABC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ANIME_5e1f16d63e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

