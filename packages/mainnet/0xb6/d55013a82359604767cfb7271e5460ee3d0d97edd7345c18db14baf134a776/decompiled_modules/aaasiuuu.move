module 0xb6d55013a82359604767cfb7271e5460ee3d0d97edd7345c18db14baf134a776::aaasiuuu {
    struct AAASIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASIUUU>(arg0, 6, b"AAASIUUU", b"aaa siuuu", b"Can't stop won't stop (thinking about SIUUU) ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014831_fbee9a95b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASIUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAASIUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

