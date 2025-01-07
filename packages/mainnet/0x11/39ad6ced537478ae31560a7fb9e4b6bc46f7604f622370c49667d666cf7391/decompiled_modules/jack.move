module 0x1139ad6ced537478ae31560a7fb9e4b6bc46f7604f622370c49667d666cf7391::jack {
    struct JACK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JACK>, arg1: 0x2::coin::Coin<JACK>) {
        0x2::coin::burn<JACK>(arg0, arg1);
    }

    fun init(arg0: JACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACK>(arg0, 9, b"JACK", b"JACK", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tickerperry.xyz/jack.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JACK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JACK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

