module 0xf4c88e38e89f240ec901406563f67f6bcefa1d5aa6a6df04936dd9213d336aee::suitropolis {
    struct SUITROPOLIS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITROPOLIS>, arg1: vector<0x2::coin::Coin<SUITROPOLIS>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUITROPOLIS>>(&mut arg1);
        0x2::pay::join_vec<SUITROPOLIS>(&mut v0, arg1);
        0x2::coin::burn<SUITROPOLIS>(arg0, 0x2::coin::split<SUITROPOLIS>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUITROPOLIS>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUITROPOLIS>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUITROPOLIS>(v0);
        };
    }

    fun init(arg0: SUITROPOLIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<SUITROPOLIS>(arg0, 6, b"TCT", b"SUITROPOLIS", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SUITROPOLIS>(&mut v4, 20000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITROPOLIS>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITROPOLIS>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITROPOLIS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITROPOLIS>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUITROPOLIS>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUITROPOLIS>>(arg0);
    }

    // decompiled from Move bytecode v6
}

