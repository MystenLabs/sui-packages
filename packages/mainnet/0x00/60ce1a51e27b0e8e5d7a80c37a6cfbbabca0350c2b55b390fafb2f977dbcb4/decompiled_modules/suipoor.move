module 0x60ce1a51e27b0e8e5d7a80c37a6cfbbabca0350c2b55b390fafb2f977dbcb4::suipoor {
    struct SUIPOOR has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPOOR>, arg1: 0x2::coin::Coin<SUIPOOR>) {
        0x2::coin::burn<SUIPOOR>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<SUIPOOR>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOOR>>(arg0, @0x0);
    }

    fun init(arg0: SUIPOOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOOR>(arg0, 6, b"SUIPOOR", b"SUIPOOR POOR", x"f09f9a8020537569506f6f7220746f6b656e20776974682072656e6f756e636564206f776e657273686970202d2068747470733a2f2f73756920706f6f722e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/YmSHeL9.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPOOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPOOR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPOOR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

