module 0xdb76153d1a655ccdf40eaea2d06689590bae0e01c67baf04fc1608b4e90334e5::fiji {
    struct FIJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIJI>(arg0, 6, b"FIJI", b"FIJI.EXE", b"The World Peace Coin initiative is a groundbreaking venture that merges blockchain with social impact, aiming to create a network of support that transcends borders and empowers global creative and charitable efforts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/A9e6JzPQstmz94pMnzxgyV14QUqoULSXuf5FPsq8UiRa.png?size=lg&key=0266df"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIJI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIJI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIJI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

