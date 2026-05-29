module 0xa396969db52b50bb28b7ac1f165d018f0cb7b10c8dcc35c83791f13da982bafe::note {
    struct NOTE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NOTE>, arg1: 0x2::coin::Coin<NOTE>) {
        0x2::coin::burn<NOTE>(arg0, arg1);
    }

    fun init(arg0: NOTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTE>(arg0, 9, b"NOTE", b"NOTE", b"Custom SUI Token: NOTE", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOTE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTE>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<NOTE>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NOTE>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

