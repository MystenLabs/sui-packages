module 0x42eb3a2bdd987da05c87479c2e74502bcfd5b7d5972489ecb6e84f7c1edd5f17::jota {
    struct JOTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOTA>(arg0, 6, b"JOTA", b"RIP Diogo Jota", b"Token dedicated to mourn Diogo Jota", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiho6xbo7kpahztno2loshj25jtvyihhmiwsh2xg23as6x7hl2ujma")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOTA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

