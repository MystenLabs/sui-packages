module 0x8836840444a9d2942d2d32a26f5f417a9f70d5d427ed83f72b5ca1c2b1b4717a::nibbler {
    struct NIBBLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIBBLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIBBLER>(arg0, 6, b"Nibbler", b"LORD NIBBLER", b"Lord Nibbler is a Nibblonian who has existed since the beginning of time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_13ce21dde3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIBBLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIBBLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

