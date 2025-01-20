module 0x8738767ce43e1e7080afad657ec8a93686a49f0bd43737fad775b9d63217fdff::zuckerberg {
    struct ZUCKERBERG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUCKERBERG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUCKERBERG>(arg0, 6, b"Zuckerberg", b"Mark Zuckerberg", b"Mark Zuckerberg caught in Donald Trumps inauguration", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_21_030118_b1c9abb3ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUCKERBERG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUCKERBERG>>(v1);
    }

    // decompiled from Move bytecode v6
}

