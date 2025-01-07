module 0xae243ef222c19ea6427c70381adf286fa6a24a847f8f6c66e39542ca99d032e::marketccoin {
    struct MARKETCCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MARKETCCOIN>, arg1: vector<0x2::coin::Coin<MARKETCCOIN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MARKETCCOIN>>(&mut arg1);
        0x2::pay::join_vec<MARKETCCOIN>(&mut v0, arg1);
        0x2::coin::burn<MARKETCCOIN>(arg0, 0x2::coin::split<MARKETCCOIN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MARKETCCOIN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MARKETCCOIN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MARKETCCOIN>(v0);
        };
    }

    fun init(arg0: MARKETCCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<MARKETCCOIN>(arg0, 7, b"MCC", b"MARKETCCOIN", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<MARKETCCOIN>(&mut v4, 1000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARKETCCOIN>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARKETCCOIN>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MARKETCCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MARKETCCOIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MARKETCCOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MARKETCCOIN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

