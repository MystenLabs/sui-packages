module 0xd6e0077802ef2d7d42c3928d5e17c013efc51518d087f18b474d50145425a590::bookmanai {
    struct BOOKMANAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOKMANAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOKMANAI>(arg0, 6, b"BookmanAI", b"Bookman AI Agent", b"The smartest AI Agent is Bookman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3452345_c538db61ce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOKMANAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOKMANAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

