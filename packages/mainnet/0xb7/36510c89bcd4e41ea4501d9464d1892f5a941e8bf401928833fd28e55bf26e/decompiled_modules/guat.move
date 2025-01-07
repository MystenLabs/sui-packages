module 0xb736510c89bcd4e41ea4501d9464d1892f5a941e8bf401928833fd28e55bf26e::guat {
    struct GUAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUAT>(arg0, 6, b"GUAT", b"Global Unity And Teamwork", b"Token of Global Unity and Teamwork on Sui Blockchain. 2024.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008829_754b7cac6c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

