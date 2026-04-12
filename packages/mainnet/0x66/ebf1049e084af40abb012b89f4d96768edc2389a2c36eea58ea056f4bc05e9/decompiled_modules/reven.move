module 0x66ebf1049e084af40abb012b89f4d96768edc2389a2c36eea58ea056f4bc05e9::reven {
    struct REVEN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<REVEN>, arg1: 0x2::coin::Coin<REVEN>) {
        0x2::coin::burn<REVEN>(arg0, arg1);
    }

    fun init(arg0: REVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REVEN>(arg0, 9, b"REVEN", b"REVEN", b"Custom SUI Token: REVEN", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REVEN>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REVEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REVEN>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<REVEN>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<REVEN>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

