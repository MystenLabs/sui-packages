module 0x2a43e918e1b554eb879893dd6ffd7498990558d4064cc5b8ad7b24edcabfc344::TASTYBONES {
    struct TASTYBONES has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TASTYBONES>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TASTYBONES>>(0x2::coin::mint<TASTYBONES>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: TASTYBONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TASTYBONES>(arg0, 9, b"TASTYBONES", b"TASTYBONES", b"NFT collection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.coingecko.com/nft_contracts/images/606/small/tasty-bones-xyz.gif?1657754592"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TASTYBONES>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TASTYBONES>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TASTYBONES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

