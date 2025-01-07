module 0x506ca3f482f1b02fc6a5860d494b70c061a26716eddff79db120ad821e2917f1::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOODENG>, arg1: vector<0x2::coin::Coin<MOODENG>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MOODENG>>(&mut arg1);
        0x2::pay::join_vec<MOODENG>(&mut v0, arg1);
        0x2::coin::burn<MOODENG>(arg0, 0x2::coin::split<MOODENG>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MOODENG>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MOODENG>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MOODENG>(v0);
        };
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmSem8nLND3nGHBsDf37F13TyWh2V6sGJN3CjkRtnCXTTw"));
        let (v2, v3) = 0x2::coin::create_currency<MOODENG>(arg0, 7, b"MOODENG", b"MooDeng", b"Little Hippopotamus in the sui network.", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODENG>>(v3);
        0x2::coin::mint_and_transfer<MOODENG>(&mut v4, 10000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOODENG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOODENG>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MOODENG>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOODENG>>(arg0);
    }

    // decompiled from Move bytecode v6
}

