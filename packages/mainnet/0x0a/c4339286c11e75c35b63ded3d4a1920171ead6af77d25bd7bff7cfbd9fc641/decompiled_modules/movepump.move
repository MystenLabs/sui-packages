module 0xac4339286c11e75c35b63ded3d4a1920171ead6af77d25bd7bff7cfbd9fc641::movepump {
    struct MOVEPUMP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOVEPUMP>, arg1: vector<0x2::coin::Coin<MOVEPUMP>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MOVEPUMP>>(&mut arg1);
        0x2::pay::join_vec<MOVEPUMP>(&mut v0, arg1);
        0x2::coin::burn<MOVEPUMP>(arg0, 0x2::coin::split<MOVEPUMP>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MOVEPUMP>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MOVEPUMP>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MOVEPUMP>(v0);
        };
    }

    fun init(arg0: MOVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/Qmc2mTMZr69EuZ9PGuCfHVWvKXswgYtiDrvTJ4TXvcPRNH"));
        let (v2, v3) = 0x2::coin::create_currency<MOVEPUMP>(arg0, 9, b"MOVE", b"MovePump", b"The First Meme Fair Launch Platform on SUI Network", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVEPUMP>>(v3);
        0x2::coin::mint_and_transfer<MOVEPUMP>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEPUMP>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOVEPUMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOVEPUMP>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MOVEPUMP>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOVEPUMP>>(arg0);
    }

    // decompiled from Move bytecode v6
}

