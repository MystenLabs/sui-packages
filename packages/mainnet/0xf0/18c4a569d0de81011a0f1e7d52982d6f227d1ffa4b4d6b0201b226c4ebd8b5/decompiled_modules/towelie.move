module 0xf018c4a569d0de81011a0f1e7d52982d6f227d1ffa4b4d6b0201b226c4ebd8b5::towelie {
    struct TOWELIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOWELIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOWELIE>(arg0, 6, b"TOWELIE", b"Towelie", b"Were so high right now wait, what were we doing? Oh yeah, TO THE MOON! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dgoe4ct_2189238c_33dc_4387_9afc_e0e4fe652db8_b45a07667a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOWELIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOWELIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

