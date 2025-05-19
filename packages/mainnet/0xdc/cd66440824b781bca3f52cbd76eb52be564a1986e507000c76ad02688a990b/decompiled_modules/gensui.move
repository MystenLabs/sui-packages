module 0xdccd66440824b781bca3f52cbd76eb52be564a1986e507000c76ad02688a990b::gensui {
    struct GENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENSUI>(arg0, 6, b"GENSUI", b"GENGAR ON SUI", b"GENSUI is ticker. Explore Pokeverse!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieptbx5hsaaiyu2tgdc4dstcqxvhnzhhjcw43j6s3jjmwus5cvoqe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

