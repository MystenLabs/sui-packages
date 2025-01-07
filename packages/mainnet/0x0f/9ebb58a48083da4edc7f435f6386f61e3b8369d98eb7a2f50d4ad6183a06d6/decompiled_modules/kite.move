module 0xf9ebb58a48083da4edc7f435f6386f61e3b8369d98eb7a2f50d4ad6183a06d6::kite {
    struct KITE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KITE>, arg1: vector<0x2::coin::Coin<KITE>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<KITE>>(&mut arg1);
        0x2::pay::join_vec<KITE>(&mut v0, arg1);
        0x2::coin::burn<KITE>(arg0, 0x2::coin::split<KITE>(&mut v0, arg2, arg3));
        if (0x2::coin::value<KITE>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<KITE>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<KITE>(v0);
        };
    }

    fun init(arg0: KITE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<KITE>(arg0, 7, b"KITE", b"KITE", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<KITE>(&mut v4, 10000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITE>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITE>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KITE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KITE>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<KITE>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KITE>>(arg0);
    }

    // decompiled from Move bytecode v6
}

