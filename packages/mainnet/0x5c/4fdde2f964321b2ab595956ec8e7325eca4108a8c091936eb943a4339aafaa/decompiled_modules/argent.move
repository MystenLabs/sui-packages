module 0x5c4fdde2f964321b2ab595956ec8e7325eca4108a8c091936eb943a4339aafaa::argent {
    struct ARGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARGENT>(arg0, 6, b"ARGENT", b"donne", b"XD ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TELEGRAM_BETEU_4605fdc661.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

