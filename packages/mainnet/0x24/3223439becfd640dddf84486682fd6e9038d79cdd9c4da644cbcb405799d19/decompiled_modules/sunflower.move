module 0x243223439becfd640dddf84486682fd6e9038d79cdd9c4da644cbcb405799d19::sunflower {
    struct SUNFLOWER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUNFLOWER>, arg1: 0x2::coin::Coin<SUNFLOWER>) {
        0x2::coin::burn<SUNFLOWER>(arg0, arg1);
    }

    fun init(arg0: SUNFLOWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNFLOWER>(arg0, 6, b"Sunflower Token", b"SUNFLOWER", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/ccSv9Lf/sunflower.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNFLOWER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNFLOWER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUNFLOWER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUNFLOWER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

