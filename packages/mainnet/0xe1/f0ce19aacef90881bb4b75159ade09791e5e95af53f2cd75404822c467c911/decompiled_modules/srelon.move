module 0xe1f0ce19aacef90881bb4b75159ade09791e5e95af53f2cd75404822c467c911::srelon {
    struct SRELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRELON>(arg0, 6, b"SRELON", b"Starship Rocket Elon", b"https://t.me/starshipelonn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017843_8aaca2f8d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

