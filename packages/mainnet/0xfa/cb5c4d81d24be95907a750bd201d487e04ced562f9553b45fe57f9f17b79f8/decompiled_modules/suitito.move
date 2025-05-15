module 0xfacb5c4d81d24be95907a750bd201d487e04ced562f9553b45fe57f9f17b79f8::suitito {
    struct SUITITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITITO>(arg0, 6, b"SUITITO", b"Suitito PokeGuns", b"Suitito PokeGuns is the first pokemon shooting game on Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidd4ij57vuq56pi37mysuoh46quhs3lhpykpb3ota4hm7tz3s2klu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITITO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

