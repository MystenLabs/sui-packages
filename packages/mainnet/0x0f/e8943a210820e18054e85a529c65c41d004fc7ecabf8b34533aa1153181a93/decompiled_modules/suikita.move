module 0xfe8943a210820e18054e85a529c65c41d004fc7ecabf8b34533aa1153181a93::suikita {
    struct SUIKITA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIKITA>, arg1: vector<0x2::coin::Coin<SUIKITA>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIKITA>>(&mut arg1);
        0x2::pay::join_vec<SUIKITA>(&mut v0, arg1);
        0x2::coin::burn<SUIKITA>(arg0, 0x2::coin::split<SUIKITA>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIKITA>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIKITA>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIKITA>(v0);
        };
    }

    fun init(arg0: SUIKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIKITA>(arg0, 9, b"SKITA", b"SUIKITA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<SUIKITA>(&mut v3, 10000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKITA>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKITA>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIKITA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIKITA>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIKITA>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIKITA>>(arg0);
    }

    // decompiled from Move bytecode v6
}

