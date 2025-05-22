module 0x9817cf10f22229e52b0cff0dd2c6e7c52043008d62984cd80e0d8d8e39541d65::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 6, b"Cetus", b"Cetus Hacked", b"Cetus Protocol, a key decentralized exchange DEX and liquidity provider on the Sui blockchain, was suspected to be the target of a cyberattack on Thursday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid42e57tjrmepsscj5qjqov5kxnsr7l7fytcgtahtpk3bohb5zk7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CETUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

