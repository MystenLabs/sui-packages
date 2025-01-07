module 0x6d04fe7b9c1bf32f0de3b04bfca1fc3b02fc5166d5dc2d78813f1f805ccb4078::penguin {
    struct PENGUIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PENGUIN>, arg1: vector<0x2::coin::Coin<PENGUIN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<PENGUIN>>(&mut arg1);
        0x2::pay::join_vec<PENGUIN>(&mut v0, arg1);
        0x2::coin::burn<PENGUIN>(arg0, 0x2::coin::split<PENGUIN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<PENGUIN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<PENGUIN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<PENGUIN>(v0);
        };
    }

    fun init(arg0: PENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<PENGUIN>(arg0, 6, b"PEN", b"Penguin", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<PENGUIN>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUIN>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUIN>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PENGUIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PENGUIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<PENGUIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PENGUIN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

