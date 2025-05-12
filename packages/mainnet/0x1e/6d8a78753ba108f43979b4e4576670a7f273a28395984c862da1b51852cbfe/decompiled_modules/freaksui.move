module 0x1e6d8a78753ba108f43979b4e4576670a7f273a28395984c862da1b51852cbfe::freaksui {
    struct FREAKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREAKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREAKSUI>(arg0, 6, b"FreakSUI", b"FreakySUI", b"Be weird. Be wild. Be $FREAK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifeao6mnta3gl2gw6awxdqeddus52i73hwltd6ifxymeybqnwpj3a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREAKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FREAKSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

