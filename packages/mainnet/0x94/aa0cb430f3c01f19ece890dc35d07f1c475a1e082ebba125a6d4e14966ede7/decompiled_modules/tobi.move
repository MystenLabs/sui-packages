module 0x94aa0cb430f3c01f19ece890dc35d07f1c475a1e082ebba125a6d4e14966ede7::tobi {
    struct TOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBI>(arg0, 6, b"TOBI", b"Tobi on Sui", b"Meet $TOBI, Just a frog named Tobi on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J_Ii_J_Uf_Lj_400x400_dea03cf0ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

