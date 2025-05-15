module 0x729a21668a59f218b8ee7afc4812d80251f5c723a3e2e07a7d020c940b2e899b::poliwag {
    struct POLIWAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLIWAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLIWAG>(arg0, 6, b"Poliwag", b"Poliwag On SUI", b"poliwag is a character in pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poliwag_29ab4f2f36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLIWAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLIWAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

