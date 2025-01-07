module 0xc7804b2f2c470ad2d314f1bbb431a511b2e3b498f6310c9b507a15ee4498c6fe::ethos_example_coin {
    struct ETHOS_EXAMPLE_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ETHOS_EXAMPLE_COIN>, arg1: 0x2::coin::Coin<ETHOS_EXAMPLE_COIN>) {
        0x2::coin::burn<ETHOS_EXAMPLE_COIN>(arg0, arg1);
    }

    fun init(arg0: ETHOS_EXAMPLE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETHOS_EXAMPLE_COIN>(arg0, 9, b"EEC", b"EthosExampleCoin", b"An example coin made by Ethos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://arweave.net/jlumw0-GYXXg8qgWd4q9v6vVVhmnon68nW8jzTDs584"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETHOS_EXAMPLE_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ETHOS_EXAMPLE_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ETHOS_EXAMPLE_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ETHOS_EXAMPLE_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

