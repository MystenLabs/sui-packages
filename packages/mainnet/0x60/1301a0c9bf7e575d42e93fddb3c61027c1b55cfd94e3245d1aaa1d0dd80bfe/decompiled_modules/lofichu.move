module 0x601301a0c9bf7e575d42e93fddb3c61027c1b55cfd94e3245d1aaa1d0dd80bfe::lofichu {
    struct LOFICHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFICHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFICHU>(arg0, 6, b"Lofichu", b"Lofi Pikachu", b"Pikachu and Lofi are two meme-inspired cryptocurrency projects that have gained attention for their connection to internet culture nostalgia and pop aesthetics", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihaqyjl4gukdl63b4o4xxz2mlmzmfh6rco2ghbjq4jane4rokpjvm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFICHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOFICHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

