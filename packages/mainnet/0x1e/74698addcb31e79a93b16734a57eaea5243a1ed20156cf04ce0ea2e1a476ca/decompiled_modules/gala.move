module 0x1e74698addcb31e79a93b16734a57eaea5243a1ed20156cf04ce0ea2e1a476ca::gala {
    struct GALA has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GALA>, arg1: 0x2::coin::Coin<GALA>) {
        0x2::coin::burn<GALA>(arg0, arg1);
    }

    fun init(arg0: GALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GALA>(arg0, 9, b"GALA", b"GALA", b"Custom SUI Token: GALA", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GALA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GALA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GALA>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<GALA>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GALA>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

