module 0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin {
    struct M2887_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<M2887_COIN>, arg1: 0x2::coin::Coin<M2887_COIN>) {
        0x2::coin::burn<M2887_COIN>(arg0, arg1);
    }

    fun init(arg0: M2887_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M2887_COIN>(arg0, 9, b"M2887", b"M2887_COIN", b"M2887 Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/49989931")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M2887_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M2887_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<M2887_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<M2887_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

