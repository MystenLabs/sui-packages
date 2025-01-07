module 0x170d2dc3087d077bec1a38d151ac8987e6b145c312d274b46d040557a486897e::tothemoon {
    struct TOTHEMOON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOTHEMOON>, arg1: vector<0x2::coin::Coin<TOTHEMOON>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<TOTHEMOON>>(&mut arg1);
        0x2::pay::join_vec<TOTHEMOON>(&mut v0, arg1);
        0x2::coin::burn<TOTHEMOON>(arg0, 0x2::coin::split<TOTHEMOON>(&mut v0, arg2, arg3));
        if (0x2::coin::value<TOTHEMOON>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TOTHEMOON>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<TOTHEMOON>(v0);
        };
    }

    fun init(arg0: TOTHEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOTHEMOON>(arg0, 7, b"TTM", b"TOTHEMOON", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<TOTHEMOON>(&mut v3, 10000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTHEMOON>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOTHEMOON>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOTHEMOON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOTHEMOON>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TOTHEMOON>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOTHEMOON>>(arg0);
    }

    // decompiled from Move bytecode v6
}

