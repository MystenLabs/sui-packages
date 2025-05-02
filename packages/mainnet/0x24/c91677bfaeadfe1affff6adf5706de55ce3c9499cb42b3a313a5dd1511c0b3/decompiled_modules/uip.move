module 0x24c91677bfaeadfe1affff6adf5706de55ce3c9499cb42b3a313a5dd1511c0b3::uip {
    struct UIP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<UIP>, arg1: 0x2::coin::Coin<UIP>) {
        0x2::coin::burn<UIP>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<UIP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UIP>>(0x2::coin::mint<UIP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: UIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UIP>(arg0, 9, b"UIP", b"UIP", b"TESTING UIP", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

