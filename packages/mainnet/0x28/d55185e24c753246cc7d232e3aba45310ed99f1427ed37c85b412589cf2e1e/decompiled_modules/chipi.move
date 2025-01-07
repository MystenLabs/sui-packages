module 0x28d55185e24c753246cc7d232e3aba45310ed99f1427ed37c85b412589cf2e1e::chipi {
    struct CHIPI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHIPI>, arg1: vector<0x2::coin::Coin<CHIPI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<CHIPI>>(&mut arg1);
        0x2::pay::join_vec<CHIPI>(&mut v0, arg1);
        0x2::coin::burn<CHIPI>(arg0, 0x2::coin::split<CHIPI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<CHIPI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CHIPI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<CHIPI>(v0);
        };
    }

    fun init(arg0: CHIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<CHIPI>(arg0, 8, b"CHIPI", b"CHIPI", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<CHIPI>(&mut v4, 1000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPI>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIPI>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHIPI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHIPI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<CHIPI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHIPI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

