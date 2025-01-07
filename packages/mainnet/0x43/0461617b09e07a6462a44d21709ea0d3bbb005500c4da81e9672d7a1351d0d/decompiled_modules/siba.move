module 0x430461617b09e07a6462a44d21709ea0d3bbb005500c4da81e9672d7a1351d0d::siba {
    struct SIBA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIBA>, arg1: 0x2::coin::Coin<SIBA>) {
        0x2::coin::burn<SIBA>(arg0, arg1);
    }

    fun init(arg0: SIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIBA>(arg0, 9, b"SIBA", b"SibaSui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/7bNJWlo.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIBA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIBA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

