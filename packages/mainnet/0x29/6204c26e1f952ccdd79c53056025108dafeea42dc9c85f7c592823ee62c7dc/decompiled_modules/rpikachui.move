module 0x296204c26e1f952ccdd79c53056025108dafeea42dc9c85f7c592823ee62c7dc::rpikachui {
    struct RPIKACHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RPIKACHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPIKACHUI>(arg0, 6, b"RPIKACHUI", b"THE REAL PIKACHUI", b"THE REAL PIKACHUI is blue. The main Pokemon ready to dominate all Pokemons in SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifdopard6scrlwvwdibuei5xi6rgfjh3tbkswd55jdid6fcaod5yi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPIKACHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RPIKACHUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

