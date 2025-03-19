module 0x3fe4a8d8ab9b6eda40eed931d845bea4da3b61a831e8ca2b58017f22826d6114::xbtc {
    struct XBTC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XBTC>, arg1: 0x2::coin::Coin<XBTC>) {
        0x2::coin::burn<XBTC>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XBTC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XBTC>>(0x2::coin::mint<XBTC>(arg0, arg1 * 2, arg3), arg2);
    }

    fun init(arg0: XBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XBTC>(arg0, 9, b"XBTC", b"Upgradable Bitcoin", b"An upgradable version of Bitcoin on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

