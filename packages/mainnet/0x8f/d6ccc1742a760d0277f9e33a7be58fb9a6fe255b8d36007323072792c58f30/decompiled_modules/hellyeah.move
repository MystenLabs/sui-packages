module 0x8fd6ccc1742a760d0277f9e33a7be58fb9a6fe255b8d36007323072792c58f30::hellyeah {
    struct HELLYEAH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HELLYEAH>, arg1: 0x2::coin::Coin<HELLYEAH>) {
        0x2::coin::burn<HELLYEAH>(arg0, arg1);
    }

    fun init(arg0: HELLYEAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLYEAH>(arg0, 2, b"HELL", b"HELLYEAH", b"HELL YEAH", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLYEAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLYEAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HELLYEAH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HELLYEAH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

