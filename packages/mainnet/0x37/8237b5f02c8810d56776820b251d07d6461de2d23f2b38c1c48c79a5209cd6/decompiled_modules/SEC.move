module 0x378237b5f02c8810d56776820b251d07d6461de2d23f2b38c1c48c79a5209cd6::SEC {
    struct SEC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SEC>, arg1: 0x2::coin::Coin<SEC>) {
        0x2::coin::burn<SEC>(arg0, arg1);
    }

    fun init(arg0: SEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEC>(arg0, 2, b"SEC", b"Stupid Egotistical Cocksuckers", b"fk them", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SEC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SEC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

