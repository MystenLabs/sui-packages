module 0x9c31c6d5f518e7068c96ffee7b47a6e55e220cca0c56a9bc82bbc288041fa308::fake_sui_coin {
    struct FAKE_SUI_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAKE_SUI_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAKE_SUI_COIN>>(0x2::coin::mint<FAKE_SUI_COIN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: FAKE_SUI_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_SUI_COIN>(arg0, 9, b"SUI", b"Sui", b"Sui is a next-generation smart contract platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/20947.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_SUI_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE_SUI_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

