module 0x44e357864a59504b601156997f59c1a542ac99681c3f8440cf2f9fae9dac0373::bonkofsui {
    struct BONKOFSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BONKOFSUI>, arg1: vector<0x2::coin::Coin<BONKOFSUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BONKOFSUI>>(&mut arg1);
        0x2::pay::join_vec<BONKOFSUI>(&mut v0, arg1);
        0x2::coin::burn<BONKOFSUI>(arg0, 0x2::coin::split<BONKOFSUI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BONKOFSUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BONKOFSUI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BONKOFSUI>(v0);
        };
    }

    fun init(arg0: BONKOFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<BONKOFSUI>(arg0, 9, b"BONK", b"BonkOfSUI", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<BONKOFSUI>(&mut v4, 10000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKOFSUI>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKOFSUI>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BONKOFSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BONKOFSUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BONKOFSUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BONKOFSUI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

