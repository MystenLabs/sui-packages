module 0xeeb28ab2687ab7c5ad1e7f7c990d64dd2cc296deb6375e8fddca0691e152185b::peed {
    struct PEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEED>(arg0, 6, b"PEED", b"Koobpeed", b"It's deepbook backwards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/670c8bd67c3fe600017d3999_logo_16_0c4af65aef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

