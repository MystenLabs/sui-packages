module 0xbe014cf2e79ba0a39c04fe8a616b19b18e2747248f3190165f28035e712271cc::lumpy {
    struct LUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMPY>(arg0, 6, b"LUMPY", b"LUMPYTOKEN", b"Introducing the Community-First meme token! EVERYONE loves Lumpy, the big blue moose from Happy Tree Friends. This fan token on the Base network has no formal team. Instead, an enthusiastic community of Lumpy fans keeps Lumpy alive, and as Lumpy fans know, that's no small feat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lumpy_7806f028c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

