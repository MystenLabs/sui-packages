module 0x8cd09648b7cfb38bfa1cb40c22b7fd6833912c705440ffde75fb7a2587083c10::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 6, b"BLAST", b"Blastoise sui", x"424c41535420205761746572205479706520506f6bc3a96d6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihhp32dvijgx6nz2hdjftqiobimsb3th37lncshl6553v7lswrtum")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLAST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

