module 0x792276a80eb38811e1a9238ab72659e3e31672164812c1d8f9c4dc1703b422d4::belugana {
    struct BELUGANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGANA>(arg0, 6, b"BELUGANA", b"Belugana", b"I'm a baby dolphin, Belugana.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_225725_c393a58e5a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELUGANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

