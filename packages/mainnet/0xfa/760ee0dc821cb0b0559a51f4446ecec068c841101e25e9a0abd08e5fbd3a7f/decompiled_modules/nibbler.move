module 0xfa760ee0dc821cb0b0559a51f4446ecec068c841101e25e9a0abd08e5fbd3a7f::nibbler {
    struct NIBBLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIBBLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIBBLER>(arg0, 6, b"NIBBLER", b"LORD NIBBLER", b"Lord Nibbler is a Nibblonian who has existed since the beginning of time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_7d7ebea780.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIBBLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIBBLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

