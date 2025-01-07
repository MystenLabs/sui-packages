module 0x7317fb14448ac01e881c908335d1bd62e2744131358ae047227cf5ca62ac7eb0::suifox {
    struct SUIFOX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIFOX>, arg1: vector<0x2::coin::Coin<SUIFOX>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIFOX>>(&mut arg1);
        0x2::pay::join_vec<SUIFOX>(&mut v0, arg1);
        0x2::coin::burn<SUIFOX>(arg0, 0x2::coin::split<SUIFOX>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIFOX>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIFOX>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIFOX>(v0);
        };
    }

    fun init(arg0: SUIFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIFOX>(arg0, 9, b"SFOX", b"SUIFOX", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<SUIFOX>(&mut v3, 10000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFOX>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFOX>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIFOX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIFOX>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIFOX>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIFOX>>(arg0);
    }

    // decompiled from Move bytecode v6
}

