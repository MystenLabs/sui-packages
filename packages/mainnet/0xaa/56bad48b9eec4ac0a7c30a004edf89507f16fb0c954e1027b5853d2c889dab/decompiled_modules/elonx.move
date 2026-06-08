module 0xaa56bad48b9eec4ac0a7c30a004edf89507f16fb0c954e1027b5853d2c889dab::elonx {
    struct ELONX has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ELONX>, arg1: 0x2::coin::Coin<ELONX>) {
        0x2::coin::burn<ELONX>(arg0, arg1);
    }

    fun init(arg0: ELONX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONX>(arg0, 9, b"ELONX", b"ELONX", b"Custom SUI Token: ELONX", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELONX>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONX>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONX>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<ELONX>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ELONX>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

