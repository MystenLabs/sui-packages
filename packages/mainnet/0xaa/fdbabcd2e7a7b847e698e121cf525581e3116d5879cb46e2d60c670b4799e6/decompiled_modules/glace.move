module 0xaafdbabcd2e7a7b847e698e121cf525581e3116d5879cb46e2d60c670b4799e6::glace {
    struct GLACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLACE>(arg0, 6, b"GLACE", b"GLACE SUI", x"476c6163656f6e2063616e20636f6e74726f6c2069747320626f64792074656d706572617475726520667265656c792e205468697320506f6bc3a96d6f6e20667265657a65732061746d6f73706865726963206c697175696420616e642063726561746573204469616d6f6e6420447573742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicmecva74ifsl6df7a3rwp2324vfn45rhoa77raibak4n6xzdgury")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLACE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

