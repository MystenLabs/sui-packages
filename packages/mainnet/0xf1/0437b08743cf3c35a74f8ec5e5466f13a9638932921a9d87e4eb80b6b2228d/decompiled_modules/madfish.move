module 0xf10437b08743cf3c35a74f8ec5e5466f13a9638932921a9d87e4eb80b6b2228d::madfish {
    struct MADFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADFISH>(arg0, 6, b"MADFISH", b"$MADFISH", b"$MADFISH is a fierce fish in the deep ocean. Madfish has built a large army and has already become part of the vast Sui ocean world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_token_55072c9f45.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MADFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

