module 0x67159d8fc795c6e51cc24110e3d3f20329daaac42139906fbff3e7ada6295e7d::testvesting {
    struct TESTVESTING has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTVESTING>, arg1: vector<0x2::coin::Coin<TESTVESTING>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<TESTVESTING>>(&mut arg1);
        0x2::pay::join_vec<TESTVESTING>(&mut v0, arg1);
        0x2::coin::burn<TESTVESTING>(arg0, 0x2::coin::split<TESTVESTING>(&mut v0, arg2, arg3));
        if (0x2::coin::value<TESTVESTING>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TESTVESTING>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<TESTVESTING>(v0);
        };
    }

    fun init(arg0: TESTVESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTVESTING>(arg0, 9, b"TVT", b"TESTVESTING", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<TESTVESTING>(&mut v3, 1000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTVESTING>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTVESTING>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTVESTING>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTVESTING>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTVESTING>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTVESTING>>(arg0);
    }

    // decompiled from Move bytecode v6
}

