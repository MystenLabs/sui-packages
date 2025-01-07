module 0x1b6d95ee5218b2c1bebf130318f4832336eb433de99481da91388a3030913e11::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<UNI>, arg1: vector<0x2::coin::Coin<UNI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<UNI>>(&mut arg1);
        0x2::pay::join_vec<UNI>(&mut v0, arg1);
        0x2::coin::burn<UNI>(arg0, 0x2::coin::split<UNI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<UNI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<UNI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<UNI>(v0);
        };
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<UNI>(arg0, 9, b"UNI", b"UNI", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<UNI>(&mut v4, 1000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNI>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<UNI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<UNI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<UNI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<UNI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

