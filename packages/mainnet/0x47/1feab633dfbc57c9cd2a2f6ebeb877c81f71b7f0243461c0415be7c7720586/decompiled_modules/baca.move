module 0x471feab633dfbc57c9cd2a2f6ebeb877c81f71b7f0243461c0415be7c7720586::baca {
    struct BACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACA>(arg0, 6, b"BACA", b"A Bathing Cat", b"A Cat waiting for bath...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009965_302042dde2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

