module 0x3434f0e1503ecb30eded0fa7bb9a33f746da2e0dcef2682e52b750fe0c8dc0cf::mwif {
    struct MWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWIF>(arg0, 6, b"Mwif", b"Maga Wif", b"The hat stays on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0597_8b8e5fe9fc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

