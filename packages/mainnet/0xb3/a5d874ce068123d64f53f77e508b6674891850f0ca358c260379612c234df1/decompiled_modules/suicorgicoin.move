module 0xb3a5d874ce068123d64f53f77e508b6674891850f0ca358c260379612c234df1::suicorgicoin {
    struct SUICORGICOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUICORGICOIN>, arg1: vector<0x2::coin::Coin<SUICORGICOIN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUICORGICOIN>>(&mut arg1);
        0x2::pay::join_vec<SUICORGICOIN>(&mut v0, arg1);
        0x2::coin::burn<SUICORGICOIN>(arg0, 0x2::coin::split<SUICORGICOIN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUICORGICOIN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUICORGICOIN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUICORGICOIN>(v0);
        };
    }

    fun init(arg0: SUICORGICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUICORGICOIN>(arg0, 7, b"SGC", b"SUICORGICOIN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<SUICORGICOIN>(&mut v3, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICORGICOIN>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICORGICOIN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICORGICOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICORGICOIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUICORGICOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUICORGICOIN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

