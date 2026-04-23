module 0x1600f2aa9c908bfcb19182b87227165e02fa6ac13824f34c6aef54817e659021::sock {
    struct SOCK has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SOCK>, arg1: 0x2::coin::Coin<SOCK>) {
        0x2::coin::burn<SOCK>(arg0, arg1);
    }

    fun init(arg0: SOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCK>(arg0, 9, b"SOCK", b"SOCK", b"Custom SUI Token: SOCK", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOCK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCK>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOCK>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<SOCK>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SOCK>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

