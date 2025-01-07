module 0x29ace1b94b1e5d6693e54261857b771ee50247230c78ed8a7289a8a83454ed38::tomjerrysui {
    struct TOMJERRYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMJERRYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMJERRYSUI>(arg0, 6, b"Tomjerrysui", b"Tomjerry", b"Fun and activity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000907774_5b6a78429b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMJERRYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOMJERRYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

