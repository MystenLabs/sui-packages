module 0xdbd32b72f6b46e5853fb0dd0373f82746f1a521a6a6561de6ba9d73bc6d9a266::pen {
    struct PEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEN>, arg1: vector<0x2::coin::Coin<PEN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<PEN>>(&mut arg1);
        0x2::pay::join_vec<PEN>(&mut v0, arg1);
        0x2::coin::burn<PEN>(arg0, 0x2::coin::split<PEN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<PEN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<PEN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<PEN>(v0);
        };
    }

    fun init(arg0: PEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<PEN>(arg0, 5, b"PEN", b"pen", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<PEN>(&mut v4, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEN>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEN>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<PEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

