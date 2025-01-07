module 0xbf362b18155b91c34fc580f8fe3ec4fdc04dc8b2ca8b3145d98eb9d91e50723e::blackmythgoku {
    struct BLACKMYTHGOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKMYTHGOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKMYTHGOKU>(arg0, 6, b"BlackMythGoku", b"Black Myth Goku", b"A meme coin developed based on Black Myth Goku", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_e3bd3ca5d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKMYTHGOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKMYTHGOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

