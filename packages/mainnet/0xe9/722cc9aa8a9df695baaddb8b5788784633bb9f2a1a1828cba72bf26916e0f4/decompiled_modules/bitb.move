module 0xe9722cc9aa8a9df695baaddb8b5788784633bb9f2a1a1828cba72bf26916e0f4::bitb {
    struct BITB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITB>(arg0, 6, b"BITB", b"BitBean", b"The world economy is entirely pegged to the bean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_4c01dc67be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITB>>(v1);
    }

    // decompiled from Move bytecode v6
}

