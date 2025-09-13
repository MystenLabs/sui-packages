module 0x9430ec6d9756c20e2edcbb1bf7d86172639e600352cff03971e8462d55338ea0::cruger {
    struct CRUGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUGER>(arg0, 6, b"CRUGER", b"Cruger on Sui", x"4e6f206d6f72650a437275676572206a7573742061206d656d65636f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiati4ynaolncsxvgvmpvl7wgx4iwjb63djc4as3dud6npt4eywhei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRUGER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

