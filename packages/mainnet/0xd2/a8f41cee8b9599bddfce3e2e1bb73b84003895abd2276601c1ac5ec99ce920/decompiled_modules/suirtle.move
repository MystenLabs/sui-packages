module 0xd2a8f41cee8b9599bddfce3e2e1bb73b84003895abd2276601c1ac5ec99ce920::suirtle {
    struct SUIRTLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIRTLE>, arg1: 0x2::coin::Coin<SUIRTLE>) {
        0x2::coin::burn<SUIRTLE>(arg0, arg1);
    }

    fun init(arg0: SUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRTLE>(arg0, 9, b"SUIR", b"Suirtle", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/vakM7MB.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRTLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIRTLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIRTLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

