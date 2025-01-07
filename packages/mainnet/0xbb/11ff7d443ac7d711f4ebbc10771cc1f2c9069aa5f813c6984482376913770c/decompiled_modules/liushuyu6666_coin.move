module 0xbb11ff7d443ac7d711f4ebbc10771cc1f2c9069aa5f813c6984482376913770c::liushuyu6666_coin {
    struct LIUSHUYU6666_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LIUSHUYU6666_COIN>, arg1: 0x2::coin::Coin<LIUSHUYU6666_COIN>) {
        0x2::coin::burn<LIUSHUYU6666_COIN>(arg0, arg1);
    }

    fun init(arg0: LIUSHUYU6666_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIUSHUYU6666_COIN>(arg0, 9, b"LSYCOIN", b"LIUSHUYU6666_COIN", b"currency from liushuyu6666", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/58156532?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIUSHUYU6666_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIUSHUYU6666_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIUSHUYU6666_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LIUSHUYU6666_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

