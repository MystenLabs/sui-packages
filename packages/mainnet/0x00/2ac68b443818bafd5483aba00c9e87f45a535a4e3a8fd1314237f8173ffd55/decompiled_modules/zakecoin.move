module 0x2ac68b443818bafd5483aba00c9e87f45a535a4e3a8fd1314237f8173ffd55::zakecoin {
    struct ZAKECOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZAKECOIN>, arg1: 0x2::coin::Coin<ZAKECOIN>) {
        0x2::coin::burn<ZAKECOIN>(arg0, arg1);
    }

    fun init(arg0: ZAKECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAKECOIN>(arg0, 9, b"ZAKECOIN", b"ZAKECOIN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAKECOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAKECOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZAKECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZAKECOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

