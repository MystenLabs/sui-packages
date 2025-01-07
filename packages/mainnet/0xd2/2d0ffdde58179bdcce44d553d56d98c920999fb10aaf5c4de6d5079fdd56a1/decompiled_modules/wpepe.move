module 0xd22d0ffdde58179bdcce44d553d56d98c920999fb10aaf5c4de6d5079fdd56a1::wpepe {
    struct WPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WPEPE>, arg1: 0x2::coin::Coin<WPEPE>) {
        0x2::coin::burn<WPEPE>(arg0, arg1);
    }

    fun init(arg0: WPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WPEPE>(arg0, 0, b"WPEPE", b"WorryPepe", b"Enter the realm of WorryPepe: a memetic token on Sui blockchain. Amidst life's worries, it unites us, fuels dreams, and powers dApps like Launchpad, Dex, Derivative Dex. Together, we conquer fears, transforming worries into opportunities. Embrace the magic. Join the WorryPepe revolution: https://twitter.com/WorryPepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreih4v4buwz57pyljlncy6xkl7h2jkeq4ykjj2puyxlb4bagnoqvzmu.ipfs.nftstorage.link")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WPEPE>>(v2);
        let v4 = &mut v3;
        mint(v4, 21000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPEPE>>(v3, 0x2::tx_context::sender(arg1));
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<WPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

