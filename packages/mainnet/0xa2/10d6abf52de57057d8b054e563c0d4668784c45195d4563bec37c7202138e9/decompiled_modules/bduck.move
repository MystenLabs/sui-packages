module 0xa210d6abf52de57057d8b054e563c0d4668784c45195d4563bec37c7202138e9::bduck {
    struct BDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDUCK>(arg0, 6, b"BDUCK", b"BLUE DUCK", b"You didnt appreciate him", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_blueduck_6e20d7767e_1a2b6572d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

