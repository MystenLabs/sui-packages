module 0x47f64c1b9ec8c3b2d046d136a38ff2be911e873b54f340bf276d9a9ac57100b::yoran {
    struct YORAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YORAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YORAN>(arg0, 6, b"Yoran", b"Yorancat", b"$yoran", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028372_2a5ba059c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YORAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YORAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

