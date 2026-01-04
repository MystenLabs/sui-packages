module 0x7b6dee5c8850f1134eb505d75d630363a05c67c21aafe720e42cac46dbfdea18::XCOIN {
    struct XCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XCOIN>, arg1: 0x2::coin::Coin<XCOIN>) {
        0x2::coin::burn<XCOIN>(arg0, arg1);
    }

    fun init(arg0: XCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCOIN>(arg0, 9, b"SUI", x"d0857569", b"Ecosystem coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdPsqEurFWTSFWPX7Nj5kTNjnreWeNJNbQf3pyjqYLBkj")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

