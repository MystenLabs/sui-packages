module 0x47556e4aecf758f6938ed6db4e0880f1f0c9977ee55620f312f711c313c7f8fc::fluri {
    struct FLURI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLURI>, arg1: vector<0x2::coin::Coin<FLURI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<FLURI>>(&mut arg1);
        0x2::pay::join_vec<FLURI>(&mut v0, arg1);
        0x2::coin::burn<FLURI>(arg0, 0x2::coin::split<FLURI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<FLURI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<FLURI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<FLURI>(v0);
        };
    }

    fun init(arg0: FLURI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<FLURI>(arg0, 7, b"FL", b"FLURI", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<FLURI>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLURI>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLURI>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLURI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FLURI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<FLURI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FLURI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

