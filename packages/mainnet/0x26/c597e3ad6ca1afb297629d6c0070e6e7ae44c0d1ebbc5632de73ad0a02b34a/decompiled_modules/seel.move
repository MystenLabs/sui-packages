module 0x26c597e3ad6ca1afb297629d6c0070e6e7ae44c0d1ebbc5632de73ad0a02b34a::seel {
    struct SEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEL>(arg0, 6, b"SEEL", b"Seel on Sui", x"5468652063757465737420506f6bc3a96d6f6e207365616c206f6e20737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreien6ljgq6c2x5bkp33jzta6oqhibvcwpeafjw3cn44ivg27oezu6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

