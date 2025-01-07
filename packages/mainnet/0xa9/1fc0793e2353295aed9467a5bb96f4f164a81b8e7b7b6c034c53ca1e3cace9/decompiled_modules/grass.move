module 0xa91fc0793e2353295aed9467a5bb96f4f164a81b8e7b7b6c034c53ca1e3cace9::grass {
    struct GRASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRASS>(arg0, 6, b"GRASS", b"Grass", b"This is just the parody of Grass in Solana. Do not buy because it will pump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/128x128_2x_8e5dcab403.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

