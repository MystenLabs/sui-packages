module 0xe231336d8279a247ac1a00e35e9129b369171a844da4430a9029b17709a7119d::suirizard {
    struct SUIRIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRIZARD>(arg0, 6, b"SUIRIZARD", b"Sui Charizard", b"Charizard on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif6vipns6ma43rwmtybfvxmxbtg7yh4z6lsgajsz67eazr7khaw4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRIZARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

