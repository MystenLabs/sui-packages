module 0x452d5c062054a3c4d51ab259bed3e0605abf0043c10e93859d844b6b3e114ecf::suiquirtle {
    struct SUIQUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIQUIRTLE>(arg0, 6, b"Suiquirtle", b"Suirtle", b"Squirtle on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/carapuce_pokemon_8305c07341.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIQUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIQUIRTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

