module 0xf6e2280ec7f707f6f32efa1ab41230c383bf9b1c810d9f27ff6592a1ea7fc134::suigglypuff {
    struct SUIGGLYPUFF has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIGGLYPUFF>, arg1: vector<0x2::coin::Coin<SUIGGLYPUFF>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIGGLYPUFF>>(&mut arg1);
        0x2::pay::join_vec<SUIGGLYPUFF>(&mut v0, arg1);
        0x2::coin::burn<SUIGGLYPUFF>(arg0, 0x2::coin::split<SUIGGLYPUFF>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIGGLYPUFF>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIGGLYPUFF>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIGGLYPUFF>(v0);
        };
    }

    fun init(arg0: SUIGGLYPUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"data:image/jpeg"));
        let (v2, v3) = 0x2::coin::create_currency<SUIGGLYPUFF>(arg0, 6, b"Sgf", b"Suigglypuff", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGGLYPUFF>>(v3);
        0x2::coin::mint_and_transfer<SUIGGLYPUFF>(&mut v4, 1000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGGLYPUFF>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIGGLYPUFF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIGGLYPUFF>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIGGLYPUFF>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIGGLYPUFF>>(arg0);
    }

    // decompiled from Move bytecode v6
}

