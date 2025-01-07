module 0xbd658a1dccd3db305a387a7961d64a8f54d5ac1671ac5c96b25cdc998d7eee54::suinchan {
    struct SUINCHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINCHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINCHAN>(arg0, 6, b"SUINCHAN", b"Suinchan", b"Im Suinchan!\" - A playful introduction of himself.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Web3_366a2a7807.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINCHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINCHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

