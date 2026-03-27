module 0x3c952c3e8e6fa444d89f99d45eda0c84e64775c8e11b5d926d6a062062b00b4c::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<COIN>(arg0, 9, 0x1::string::utf8(b"GOVEX_LP_TOKEN"), 0x1::string::utf8(b"GOVEX_LP_TOKEN"), 0x1::string::utf8(b"Test coin for launchpad E2E testing"), 0x1::string::utf8(b"https://raw.githubusercontent.com/govex-dao/docs/main/govex-icon.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<COIN>>(0x2::coin_registry::finalize<COIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

