module 0x17119b205a387a48bdc4dcb9844abff31d198b14f0b1a1bf65bc0016d7beceeb::eeveesui {
    struct EEVEESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVEESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEVEESUI>(arg0, 6, b"EeveeSUI", b"Eevee SUI", b"Memes evolve. So do we", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaj2h7jttfigj7srdip6qrrulq5hn5qmwstebnzqhyehjrilgjgp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEVEESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EEVEESUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

