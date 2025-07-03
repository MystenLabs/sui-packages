module 0xf4525ee7d469e5c1981e37ba768e285a9eb80da279cf9a320895a2e0ce6483::p {
    struct P has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<P>, arg1: 0x2::coin::Coin<P>) {
        0x2::coin::burn<P>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<P>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P>>(arg0, @0x0);
    }

    fun init(arg0: P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P>(arg0, 6, b"P", b"POOR", x"f09f9a8020506f6f7220746f6b656e20776974682072656e6f756e636564206f776e657273686970202d2068747470733a2f2f746573742e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/K9UFbIJ.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<P>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<P>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

