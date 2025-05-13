module 0x38ecfc7de31ce69963fac7177130e0f96910e5cf686a335892bc41d52ac8c61c::kyurem {
    struct KYUREM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYUREM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYUREM>(arg0, 6, b"Kyurem", b"SUIKYUREM", b"This legendary ice Pokemoon brings a hero who can fill the missing body parts with truth and idealism.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihqxdzbtgwxxvq2mjcbolcpexd5lvs4ssobeudyy73gndy3ggeibi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYUREM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KYUREM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

