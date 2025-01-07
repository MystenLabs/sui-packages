module 0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd {
    struct IUSD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<IUSD>, arg1: 0x2::coin::Coin<IUSD>) {
        0x2::coin::burn<IUSD>(arg0, arg1);
    }

    public entry fun Mint(arg0: &mut 0x2::coin::TreasuryCap<IUSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<IUSD>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: IUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUSD>(arg0, 8, b"IUSD", b"iusd", b"Sui stable coin -1:1- USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/181119030?s=200&v=4"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

