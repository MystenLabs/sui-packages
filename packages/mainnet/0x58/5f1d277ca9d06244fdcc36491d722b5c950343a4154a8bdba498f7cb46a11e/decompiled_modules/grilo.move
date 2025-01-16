module 0x585f1d277ca9d06244fdcc36491d722b5c950343a4154a8bdba498f7cb46a11e::grilo {
    struct GRILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRILO>(arg0, 6, b"Grilo", b"Grilo fendialfi", b"G F", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020461_73efad794e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRILO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRILO>>(v1);
    }

    // decompiled from Move bytecode v6
}

