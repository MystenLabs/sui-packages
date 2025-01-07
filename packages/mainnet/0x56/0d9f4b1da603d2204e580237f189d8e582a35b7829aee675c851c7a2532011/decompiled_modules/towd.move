module 0x560d9f4b1da603d2204e580237f189d8e582a35b7829aee675c851c7a2532011::towd {
    struct TOWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOWD>(arg0, 6, b"TOWD", b"Towd", b"TOWD, a fwog with a flair for the bizarre, was kicked out from his swamp for being too... well, TOWD. So he decided to Join his fwens on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_7d3aa032f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOWD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

