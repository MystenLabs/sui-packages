module 0xf755917435680fb77095195c2e2b12de5dd80a67101bf2eefbb8019189d7beee::strike {
    struct STRIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRIKE>(arg0, 6, b"STRIKE", b"SUI STRIKE", b"We are launching the first real online game on the Sui Network. You can play online games with Sui Strike and win Sui Strike. The V1 version of the game is now live, many more will come soon. You can enter Sui Strike award-winning battles with your friends, we are coming soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiac47xxblfxel7njfgb345wbl3j5b6lgul262ivujmr3jss2myjxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STRIKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

