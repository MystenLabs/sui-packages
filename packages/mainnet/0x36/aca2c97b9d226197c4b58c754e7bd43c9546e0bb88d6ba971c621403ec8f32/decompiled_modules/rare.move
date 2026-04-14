module 0x36aca2c97b9d226197c4b58c754e7bd43c9546e0bb88d6ba971c621403ec8f32::rare {
    struct RARE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<RARE>, arg1: 0x2::coin::Coin<RARE>) {
        0x2::coin::burn<RARE>(arg0, arg1);
    }

    fun init(arg0: RARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RARE>(arg0, 9, b"RARE", b"RARE", b"Custom SUI Token: RARE", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RARE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RARE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RARE>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<RARE>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RARE>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

