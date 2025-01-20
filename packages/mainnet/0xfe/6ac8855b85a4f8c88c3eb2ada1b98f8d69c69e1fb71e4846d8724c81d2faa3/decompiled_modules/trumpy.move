module 0xfe6ac8855b85a4f8c88c3eb2ada1b98f8d69c69e1fb71e4846d8724c81d2faa3::trumpy {
    struct TRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPY>(arg0, 6, b"Trumpy", b"DJ Trumpy", b"President Trumpy 2025 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Trumpy1_c5a3f74286.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

