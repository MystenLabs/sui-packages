module 0x6d325f24942565d1c43aa1a6ad519292014b40abca9c64b4f7228a35d4c46616::suiplup {
    struct SUIPLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPLUP>(arg0, 6, b"SUIPLUP", b"Sui Plup", b"Suiplup is live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028543_04ea9bb332.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

