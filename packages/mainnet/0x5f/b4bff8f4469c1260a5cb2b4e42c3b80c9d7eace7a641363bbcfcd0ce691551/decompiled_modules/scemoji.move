module 0x5fb4bff8f4469c1260a5cb2b4e42c3b80c9d7eace7a641363bbcfcd0ce691551::scemoji {
    struct SCEMOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCEMOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCEMOJI>(arg0, 6, b"SCEMOJI", b"SUICATEMOJI", b"The Original Cat Emoji on The Water Chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_1_a60f8ffeb9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCEMOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCEMOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

