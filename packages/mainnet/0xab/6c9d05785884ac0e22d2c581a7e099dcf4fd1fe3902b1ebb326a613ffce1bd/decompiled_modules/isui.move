module 0xab6c9d05785884ac0e22d2c581a7e099dcf4fd1fe3902b1ebb326a613ffce1bd::isui {
    struct ISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISUI>(arg0, 6, b"ISUI", b"ISUISPEED", b"Community Token to support our friendly vlogger IShowSpeed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_09_05_55_24_abb8c16177.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

