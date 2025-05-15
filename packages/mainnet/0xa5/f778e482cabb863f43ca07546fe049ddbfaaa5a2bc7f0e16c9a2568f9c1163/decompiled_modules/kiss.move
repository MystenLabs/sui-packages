module 0xa5f778e482cabb863f43ca07546fe049ddbfaaa5a2bc7f0e16c9a2568f9c1163::kiss {
    struct KISS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KISS>(arg0, 6, b"Kiss", b"Poseidon Kiss", b"Are you ready to be kissed?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibqzanh7wsjk4h4d56ytgwaoevdvj2rknxu2txwquandl5oijjdte")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KISS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KISS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

