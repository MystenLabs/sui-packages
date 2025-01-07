module 0xbec97f3f98a25d8b49a822bb9aec96fad17c2a453bf7d00345e64eb7a20eaa1b::lander {
    struct LANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LANDER>(arg0, 6, b"LANDER", b"SUI LANDER", b"The hero Sui deserves!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000075269_94fa5ab9da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

