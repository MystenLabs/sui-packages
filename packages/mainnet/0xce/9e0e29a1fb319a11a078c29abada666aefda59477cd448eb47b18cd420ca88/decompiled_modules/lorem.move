module 0xce9e0e29a1fb319a11a078c29abada666aefda59477cd448eb47b18cd420ca88::lorem {
    struct LOREM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOREM>, arg1: vector<0x2::coin::Coin<LOREM>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<LOREM>>(&mut arg1);
        0x2::pay::join_vec<LOREM>(&mut v0, arg1);
        0x2::coin::burn<LOREM>(arg0, 0x2::coin::split<LOREM>(&mut v0, arg2, arg3));
        if (0x2::coin::value<LOREM>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LOREM>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<LOREM>(v0);
        };
    }

    fun init(arg0: LOREM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/bitcoin-btc-logo.png"));
        let (v2, v3) = 0x2::coin::create_currency<LOREM>(arg0, 2, b"Lorem", b"Lorem", b"a b c A a 32 234 32 32a f", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOREM>>(v3);
        0x2::coin::mint_and_transfer<LOREM>(&mut v4, 12212122100, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOREM>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOREM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LOREM>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<LOREM>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOREM>>(arg0);
    }

    // decompiled from Move bytecode v6
}

