module 0x12323a6e03f101477171f7bc5b50b3e3200ced0bc753c9b7ba4f1c89d2a81483::titcoin {
    struct TITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITCOIN>(arg0, 6, b"TITCOIN", b"TITCOIN SUI", b"The boob meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiau4wktr4ssfst7hjkvkyh7escc7gdtrrep4j3rul7xiidqbqfy5u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TITCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

