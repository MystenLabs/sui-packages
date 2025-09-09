module 0x11bb09acf86db286bd42e444d6d63ce4a3a7d3bd84f2d81c2e2898a397cf31b0::broke {
    struct BROKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROKE>(arg0, 6, b"BROKE", b"JUST A BROKE GUY", b"Just a Broke Guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidtexzw77pfazxclszthhgyciafpfn6kjbxnwxrd2ew2p4ndz5ote")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BROKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

