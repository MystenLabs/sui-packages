module 0xdd6285487368aadd4be7165098e50f7cda92d2e5af789922b4c8dcfe3ab95f19::belaunch {
    struct BELAUNCH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BELAUNCH>, arg1: vector<0x2::coin::Coin<BELAUNCH>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BELAUNCH>>(&mut arg1);
        0x2::pay::join_vec<BELAUNCH>(&mut v0, arg1);
        0x2::coin::burn<BELAUNCH>(arg0, 0x2::coin::split<BELAUNCH>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BELAUNCH>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BELAUNCH>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BELAUNCH>(v0);
        };
    }

    fun init(arg0: BELAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BELAUNCH>(arg0, 7, b"BLAT", b"BELAUNCH", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<BELAUNCH>(&mut v3, 10000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELAUNCH>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELAUNCH>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BELAUNCH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BELAUNCH>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BELAUNCH>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BELAUNCH>>(arg0);
    }

    // decompiled from Move bytecode v6
}

