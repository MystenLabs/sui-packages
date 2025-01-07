module 0xb8a39dc51be7e4ca2899c97fb04f3ec3d370c665f287926f9109097677298571::a_673800357_coin {
    struct A_673800357_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<A_673800357_COIN>, arg1: 0x2::coin::Coin<A_673800357_COIN>) {
        0x2::coin::burn<A_673800357_COIN>(arg0, arg1);
    }

    fun init(arg0: A_673800357_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A_673800357_COIN>(arg0, 6, b"a_673800357 coin", b"a_673800357 coin", b"Awesome Coint", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A_673800357_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A_673800357_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<A_673800357_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<A_673800357_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

