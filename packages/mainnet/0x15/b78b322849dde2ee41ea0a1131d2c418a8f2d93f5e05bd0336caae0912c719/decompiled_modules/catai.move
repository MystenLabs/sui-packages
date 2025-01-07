module 0x15b78b322849dde2ee41ea0a1131d2c418a8f2d93f5e05bd0336caae0912c719::catai {
    struct CATAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CATAI>, arg1: 0x2::coin::Coin<CATAI>) {
        0x2::coin::burn<CATAI>(arg0, arg1);
    }

    fun init(arg0: CATAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATAI>(arg0, 2, b"CATAI", b"SUI CAT AI", b"test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/xQXgQfk.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CATAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CATAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

