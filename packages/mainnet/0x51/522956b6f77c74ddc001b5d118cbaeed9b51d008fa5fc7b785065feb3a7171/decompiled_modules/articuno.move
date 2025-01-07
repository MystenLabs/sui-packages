module 0x51522956b6f77c74ddc001b5d118cbaeed9b51d008fa5fc7b785065feb3a7171::articuno {
    struct ARTICUNO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ARTICUNO>, arg1: vector<0x2::coin::Coin<ARTICUNO>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<ARTICUNO>>(&mut arg1);
        0x2::pay::join_vec<ARTICUNO>(&mut v0, arg1);
        0x2::coin::burn<ARTICUNO>(arg0, 0x2::coin::split<ARTICUNO>(&mut v0, arg2, arg3));
        if (0x2::coin::value<ARTICUNO>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ARTICUNO>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<ARTICUNO>(v0);
        };
    }

    fun init(arg0: ARTICUNO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/full/144.png"));
        let (v2, v3) = 0x2::coin::create_currency<ARTICUNO>(arg0, 8, b"Articuno", b"Articuno", b"Hodl", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARTICUNO>>(v3);
        0x2::coin::mint_and_transfer<ARTICUNO>(&mut v4, 10000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTICUNO>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ARTICUNO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ARTICUNO>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<ARTICUNO>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ARTICUNO>>(arg0);
    }

    // decompiled from Move bytecode v6
}

