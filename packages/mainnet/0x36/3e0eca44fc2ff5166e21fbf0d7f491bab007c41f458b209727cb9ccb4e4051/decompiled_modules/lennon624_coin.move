module 0x363e0eca44fc2ff5166e21fbf0d7f491bab007c41f458b209727cb9ccb4e4051::lennon624_coin {
    struct LENNON624_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LENNON624_COIN>, arg1: 0x2::coin::Coin<LENNON624_COIN>) {
        0x2::coin::burn<LENNON624_COIN>(arg0, arg1);
    }

    fun init(arg0: LENNON624_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENNON624_COIN>(arg0, 6, b"lennon624 COIN", b"lennon624 COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LENNON624_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENNON624_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LENNON624_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LENNON624_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

