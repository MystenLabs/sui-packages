module 0x5278c40740123f68e82b5deef56f3faf73841c4258419cf3f19402d172e763cc::create_coin {
    struct CREATE_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CREATE_COIN>, arg1: 0x2::coin::Coin<CREATE_COIN>) {
        0x2::coin::burn<CREATE_COIN>(arg0, arg1);
    }

    fun init(arg0: CREATE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREATE_COIN>(arg0, 2, b"MANAGED", b"MNG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREATE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREATE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CREATE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CREATE_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

