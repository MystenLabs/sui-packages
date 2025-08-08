module 0xefc6b0b085759f5f9ac28389b0ec2e85dbedc131d41fad5cc77570b36ad11fa6::suiwag {
    struct SUIWAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWAG>(arg0, 6, b"SUIWAG", b"WAG ON SUI", b"Welcome SUIWAG, the new trendsetter on Moonbags!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihthzz7vpjhcw5u3asokbq2hoopr5qfs7wio5pc3sumy24dhkhz7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIWAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

