module 0x774cade3bcc366a62b1a1ed6dae46642ec511a0f86f5c5a11c0c5fe9d7c79a00::gaga {
    struct GAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAGA>(arg0, 6, b"GAGA", b"GAGAGOUGOU", b"SRXKOIF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TELEGRAM_BETEU_4d6041890d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

