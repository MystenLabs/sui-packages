module 0x5e82c5dc70e06f7979f00e77cf7a1040b6405d840c1fa7551b6e3ef0d198bc2c::suibz {
    struct SUIBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBZ>(arg0, 6, b"SUIBZ", b"Suibiza Final Boss", b"SUIBZ CTO TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia7mlci7crmenpygrqjj6uf4nl7nvqyp2t373vir7x2iw7g5ysdlm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

