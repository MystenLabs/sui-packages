module 0x205116a931195518e37894566d7582ee3e701099d6eeecc3a40daae8efadaf47::fatnig {
    struct FATNIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATNIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATNIG>(arg0, 6, b"FATNIG", b"Fat Nigga Coin", b"Just a Fat Nig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_ea9121e04f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATNIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATNIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

