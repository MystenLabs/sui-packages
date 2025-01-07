module 0xb4e36b11b64261f6e6be1c50a474dbf35b58a801568a90b893eeb80ae11f1c5a::guychillsui {
    struct GUYCHILLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUYCHILLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUYCHILLSUI>(arg0, 6, b"GUYCHILLSUI", b"Guy Chill", b"just a guy chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avarta_d7ae5143ec.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUYCHILLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUYCHILLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

