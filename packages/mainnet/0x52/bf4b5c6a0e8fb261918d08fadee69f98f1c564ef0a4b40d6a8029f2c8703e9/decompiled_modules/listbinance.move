module 0x52bf4b5c6a0e8fb261918d08fadee69f98f1c564ef0a4b40d6a8029f2c8703e9::listbinance {
    struct LISTBINANCE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LISTBINANCE>, arg1: vector<0x2::coin::Coin<LISTBINANCE>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<LISTBINANCE>>(&mut arg1);
        0x2::pay::join_vec<LISTBINANCE>(&mut v0, arg1);
        0x2::coin::burn<LISTBINANCE>(arg0, 0x2::coin::split<LISTBINANCE>(&mut v0, arg2, arg3));
        if (0x2::coin::value<LISTBINANCE>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LISTBINANCE>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<LISTBINANCE>(v0);
        };
    }

    fun init(arg0: LISTBINANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LISTBINANCE>(arg0, 7, b"LB", b"LISTBINANCE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<LISTBINANCE>(&mut v3, 10000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LISTBINANCE>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LISTBINANCE>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LISTBINANCE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LISTBINANCE>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<LISTBINANCE>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LISTBINANCE>>(arg0);
    }

    // decompiled from Move bytecode v6
}

