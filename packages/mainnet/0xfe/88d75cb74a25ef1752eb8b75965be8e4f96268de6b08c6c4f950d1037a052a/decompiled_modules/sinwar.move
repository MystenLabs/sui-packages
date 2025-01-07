module 0xfe88d75cb74a25ef1752eb8b75965be8e4f96268de6b08c6c4f950d1037a052a::sinwar {
    struct SINWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINWAR>(arg0, 6, b"Sinwar", b"Yahya sinwar", b"A guy sitting on a chair ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027866_3a0f17c4c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINWAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINWAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

