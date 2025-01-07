module 0x865f2457c1473acc6b47318220cf1a3915a3ed37ec98bf11cab300a9d8ecc21a::toke {
    struct TOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKE>(arg0, 9, b"TOKE", b"TOKENIC", b"Tokenomic with luv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a30f6b5-3f7d-4891-8143-43de549b5a19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

