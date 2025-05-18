module 0x7cafdee20065ea06ad7bfaf804e1519b1caf2383201d43669b37db3657923cb7::dualipa {
    struct DUALIPA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUALIPA>, arg1: 0x2::coin::Coin<DUALIPA>) {
        0x2::coin::burn<DUALIPA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUALIPA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DUALIPA>>(0x2::coin::mint<DUALIPA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DUALIPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUALIPA>(arg0, 9, b"DUALIPA", b"DUALIPA", b"Testing Dua Lipa Pussy", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUALIPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUALIPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

