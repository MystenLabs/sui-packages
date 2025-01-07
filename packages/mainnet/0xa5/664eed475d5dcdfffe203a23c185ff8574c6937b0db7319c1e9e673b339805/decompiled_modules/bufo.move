module 0xa5664eed475d5dcdfffe203a23c185ff8574c6937b0db7319c1e9e673b339805::bufo {
    struct BUFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFO>(arg0, 6, b"BUFO", b"BUFO COIN", b"Bufo wants you to buy his coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bufo_Coin_babfe15f73.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

