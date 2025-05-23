module 0xae2a8df0c7292b7519b4cead588245160cc9be0256c61c64f8df7f9341a29a07::sntr {
    struct SNTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNTR>(arg0, 6, b"SNTR", b"Suinator", b"Good development", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2147483648_213482_c2a5ce757f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

