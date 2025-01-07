module 0x314ad87a385d786446ca08c1813dae6282c48e540e5c90adaac35335bbf57129::jack {
    struct JACK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JACK>, arg1: 0x2::coin::Coin<JACK>) {
        0x2::coin::burn<JACK>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JACK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JACK>>(0x2::coin::mint<JACK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACK>(arg0, 9, b"jack", b"JACK", b"Hello World!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

