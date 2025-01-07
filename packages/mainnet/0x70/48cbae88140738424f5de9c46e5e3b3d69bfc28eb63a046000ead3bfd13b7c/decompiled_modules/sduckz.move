module 0x7048cbae88140738424f5de9c46e5e3b3d69bfc28eb63a046000ead3bfd13b7c::sduckz {
    struct SDUCKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDUCKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDUCKZ>(arg0, 6, b"SDUCKZ", b"SUI DUCKZ", b"Suiduckz BuildOnSui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3569_73a49edaf4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDUCKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDUCKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

