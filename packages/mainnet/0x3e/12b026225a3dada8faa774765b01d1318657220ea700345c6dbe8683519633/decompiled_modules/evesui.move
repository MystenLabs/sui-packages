module 0x3e12b026225a3dada8faa774765b01d1318657220ea700345c6dbe8683519633::evesui {
    struct EVESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVESUI>(arg0, 6, b"EveSUI", b"Eevee SUI", b"Memes evolve. So do we", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaj2h7jttfigj7srdip6qrrulq5hn5qmwstebnzqhyehjrilgjgp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVESUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

