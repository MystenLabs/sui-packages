module 0x25808186bbe4f19ef4bc31a891cd1d1f75eaa42efeaf19c4f5b250265df6aa0f::suindaquil {
    struct SUINDAQUIL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUINDAQUIL>, arg1: vector<0x2::coin::Coin<SUINDAQUIL>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUINDAQUIL>>(&mut arg1);
        0x2::pay::join_vec<SUINDAQUIL>(&mut v0, arg1);
        0x2::coin::burn<SUINDAQUIL>(arg0, 0x2::coin::split<SUINDAQUIL>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUINDAQUIL>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUINDAQUIL>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUINDAQUIL>(v0);
        };
    }

    fun init(arg0: SUINDAQUIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/sonicpokemon/images/a/a2/155_cyndaquil_by_pklucario.png/revision/latest?cb=20130617041606"));
        let (v2, v3) = 0x2::coin::create_currency<SUINDAQUIL>(arg0, 9, b"Squil", b"Suindaquil", b"Hold", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINDAQUIL>>(v3);
        0x2::coin::mint_and_transfer<SUINDAQUIL>(&mut v4, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINDAQUIL>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUINDAQUIL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUINDAQUIL>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUINDAQUIL>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUINDAQUIL>>(arg0);
    }

    // decompiled from Move bytecode v6
}

