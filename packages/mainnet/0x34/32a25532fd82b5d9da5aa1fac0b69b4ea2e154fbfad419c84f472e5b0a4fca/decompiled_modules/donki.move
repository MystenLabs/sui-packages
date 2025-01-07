module 0x3432a25532fd82b5d9da5aa1fac0b69b4ea2e154fbfad419c84f472e5b0a4fca::donki {
    struct DONKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKI>(arg0, 6, b"DONKI", b"Tiny Donki", x"546869732054696e7920446f6e6b6920697320736f20736d6f6c2068652066697473206f6e6c79206f6e2075722066696e676572746970732c2068652069732074686520666c6f6f666965737420646f6e6b692e200a486973206e616d65206973204461766520696620796f75206c6f76652064617665206c65742068696d206b6e6f7720696e206869732074656c656772616d2067726f757021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Log_A_21af55ecdb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

