module 0x4122d14ed27180ac6362ccd573e75082bfc2ab391c8f096275637e69a4efbde3::tears {
    struct TEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEARS>(arg0, 6, b"TEARS", b"sui tears", b"every trades fucked, I don't need sex Crypto Fucks Me Everyday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7bln7h_3c89fb2079.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

