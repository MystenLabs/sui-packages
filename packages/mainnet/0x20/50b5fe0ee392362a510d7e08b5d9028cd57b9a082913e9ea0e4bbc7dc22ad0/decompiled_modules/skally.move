module 0x2050b5fe0ee392362a510d7e08b5d9028cd57b9a082913e9ea0e4bbc7dc22ad0::skally {
    struct SKALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKALLY>(arg0, 6, b"SKALLY", b"OOSKALLY", b"SKALL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifzgaugat3tmvbuszvanasyyifoxrgmogzf4yu2yod5wrgczjrg7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKALLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

