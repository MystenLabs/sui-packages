module 0x588e5f98e14b0833ac02c8ce6a1a656b0805ac107dd0a9c9e383eb01f813656e::suirich {
    struct SUIRICH has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIRICH>, arg1: 0x2::coin::Coin<SUIRICH>) {
        0x2::coin::burn<SUIRICH>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<SUIRICH>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRICH>>(arg0, @0x0);
    }

    fun init(arg0: SUIRICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRICH>(arg0, 6, b"SUIRICH", b"SUIRICH", x"f09f9a80205375695269636820746f6b656e20776974682072656e6f756e636564206f776e657273686970202d2068747470733a2f2f737569726963682e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/YmSHeL9.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRICH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRICH>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIRICH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIRICH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

