module 0xb449a2843c3d1764fbacea4a1a94780f16c9ee8887678753bb7e59e03469923c::slot {
    struct SLOT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SLOT>, arg1: 0x2::coin::Coin<SLOT>) {
        0x2::coin::burn<SLOT>(arg0, arg1);
    }

    fun init(arg0: SLOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOT>(arg0, 9, b"SLOT", b"SLOT", b"Custom SUI Token: SLOT", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLOT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLOT>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<SLOT>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SLOT>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

