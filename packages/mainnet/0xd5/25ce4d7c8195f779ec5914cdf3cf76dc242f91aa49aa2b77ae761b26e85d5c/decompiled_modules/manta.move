module 0xd525ce4d7c8195f779ec5914cdf3cf76dc242f91aa49aa2b77ae761b26e85d5c::manta {
    struct MANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANTA>(arg0, 6, b"MANTA", b"Sui Manta", b"The first Manta on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/manta_8a8edecb06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

