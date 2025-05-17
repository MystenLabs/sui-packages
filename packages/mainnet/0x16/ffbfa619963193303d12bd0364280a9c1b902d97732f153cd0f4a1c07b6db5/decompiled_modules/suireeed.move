module 0x16ffbfa619963193303d12bd0364280a9c1b902d97732f153cd0f4a1c07b6db5::suireeed {
    struct SUIREEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREEED>(arg0, 6, b"SUIREEED", b"RED FROM PALLET TOWN", b"RED is the young legend from Pallet Town to ever defeat the Team Rocket with his tough Pokemons and became a champion at 11 years old.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifhfx6xwsygbkvi5u2mtvjx3lu242odpecwhk7oplsiw4zbmybiza")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIREEED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

