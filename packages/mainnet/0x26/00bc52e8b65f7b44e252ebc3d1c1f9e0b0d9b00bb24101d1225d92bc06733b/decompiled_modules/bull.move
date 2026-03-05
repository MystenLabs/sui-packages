module 0x2600bc52e8b65f7b44e252ebc3d1c1f9e0b0d9b00bb24101d1225d92bc06733b::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BULL>, arg1: 0x2::coin::Coin<BULL>) {
        0x2::coin::burn<BULL>(arg0, arg1);
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 9, b"BULL", b"BULL", b"Custom SUI Token: BULL", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULL>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULL>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<BULL>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BULL>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

