module 0x923c24a8df897d62a7428e6c07266f8adde112236929a94022ebbd737026cdd6::doodie {
    struct DOODIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODIE>(arg0, 6, b"DOODIE", b"DOODIE SUI", b"Blasting the Blockchain with Turd-Tastic Power!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihpf4smrtfn57imchfxzocouuac2mnaxb3k6jgmbx7cpsjtx7wzxa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOODIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

