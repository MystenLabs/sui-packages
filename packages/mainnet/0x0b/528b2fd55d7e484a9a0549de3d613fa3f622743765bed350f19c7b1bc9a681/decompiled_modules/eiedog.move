module 0xb528b2fd55d7e484a9a0549de3d613fa3f622743765bed350f19c7b1bc9a681::eiedog {
    struct EIEDOG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EIEDOG>, arg1: vector<0x2::coin::Coin<EIEDOG>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<EIEDOG>>(&mut arg1);
        0x2::pay::join_vec<EIEDOG>(&mut v0, arg1);
        0x2::coin::burn<EIEDOG>(arg0, 0x2::coin::split<EIEDOG>(&mut v0, arg2, arg3));
        if (0x2::coin::value<EIEDOG>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<EIEDOG>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<EIEDOG>(v0);
        };
    }

    fun init(arg0: EIEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<EIEDOG>(arg0, 9, b"RIE", b"EIEDOG", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<EIEDOG>(&mut v4, 1000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIEDOG>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EIEDOG>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EIEDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EIEDOG>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<EIEDOG>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EIEDOG>>(arg0);
    }

    // decompiled from Move bytecode v6
}

