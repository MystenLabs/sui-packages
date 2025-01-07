module 0x2c7c8d82a7530e8cf6f45c61ea4bdd9feec569c1efdefd5b46aedd15631af8b9::habibi {
    struct HABIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HABIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HABIBI>(arg0, 6, b"HABIBI", b"Arab Punks", b"Can Promise Nothing | All in TON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Arab_7a76fc1ce8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HABIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HABIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

