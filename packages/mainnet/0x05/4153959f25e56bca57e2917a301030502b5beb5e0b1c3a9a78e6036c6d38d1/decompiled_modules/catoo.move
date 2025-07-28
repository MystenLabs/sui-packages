module 0x54153959f25e56bca57e2917a301030502b5beb5e0b1c3a9a78e6036c6d38d1::catoo {
    struct CATOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATOO>(arg0, 6, b"CATOO", b"Chief Adeniyi Take Over Officer", b"Let him cook!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif23khjazvorv2kbertqd6s4pk47cgezlp6nuncj726e2s6qg5mpq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

