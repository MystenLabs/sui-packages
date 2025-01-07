module 0xd2272ea3134d606b29deaff647be3c2fafafe50eb4774e9b34ae50d0f7daf539::capy_coin {
    struct CAPY_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CAPY_COIN>, arg1: 0x2::coin::Coin<CAPY_COIN>) {
        0x2::coin::burn<CAPY_COIN>(arg0, arg1);
    }

    fun init(arg0: CAPY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY_COIN>(arg0, 8, b"CAPY COIN", b"CAPY COIN", b"CAPYBARA Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CAPY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CAPY_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

