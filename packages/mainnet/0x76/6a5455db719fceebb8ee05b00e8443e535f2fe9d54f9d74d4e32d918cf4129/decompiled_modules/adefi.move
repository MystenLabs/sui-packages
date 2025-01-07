module 0x766a5455db719fceebb8ee05b00e8443e535f2fe9d54f9d74d4e32d918cf4129::adefi {
    struct ADEFI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ADEFI>, arg1: vector<0x2::coin::Coin<ADEFI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<ADEFI>>(&mut arg1);
        0x2::pay::join_vec<ADEFI>(&mut v0, arg1);
        0x2::coin::burn<ADEFI>(arg0, 0x2::coin::split<ADEFI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<ADEFI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ADEFI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<ADEFI>(v0);
        };
    }

    fun init(arg0: ADEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ADEFI>(arg0, 9, b"ADE", b"ADEFI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<ADEFI>(&mut v3, 10000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADEFI>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADEFI>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ADEFI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ADEFI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<ADEFI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ADEFI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

