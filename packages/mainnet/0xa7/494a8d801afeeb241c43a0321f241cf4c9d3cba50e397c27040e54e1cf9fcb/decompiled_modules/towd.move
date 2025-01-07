module 0xa7494a8d801afeeb241c43a0321f241cf4c9d3cba50e397c27040e54e1cf9fcb::towd {
    struct TOWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOWD>(arg0, 6, b"TOWD", b"Towd", b"TOWD, a fwog with a flair for the bizarre, was kicked out from his swamp for being too... well, TOWD. So he decided to Join his fwens on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_3eaa64454c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOWD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

