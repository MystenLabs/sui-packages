module 0xa409f3d2d79ff693432ba4c923d3d2ec8202744fcf4d4fde05ef87505ef37358::bufo {
    struct BUFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFO>(arg0, 6, b"BUFO", b"BUFO COIN", b"Bufo wants you to buy his coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bufo_Coin_5537d05d43.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

