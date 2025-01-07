module 0x99e42805a93e3ded2d94718aba1f7129024b68e4f06cc09b1546f3892cb40720::BAYC {
    struct BAYC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BAYC>, arg1: 0x2::coin::Coin<BAYC>) {
        0x2::coin::burn<BAYC>(arg0, arg1);
    }

    fun init(arg0: BAYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAYC>(arg0, 2, b"BAYC", b"BAYC", b"BAYC on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-vector/golden-coin-apecoin-ape-front-view-isolated-white-cryptocurrency-logo-icon-coin-tokens-allocated-bayc-mayc-nft-holders-web3-economy_337410-1899.jpg?w=300")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAYC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAYC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BAYC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BAYC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

