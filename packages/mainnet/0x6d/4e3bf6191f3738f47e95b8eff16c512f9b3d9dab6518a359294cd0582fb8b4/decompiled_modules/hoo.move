module 0x6d4e3bf6191f3738f47e95b8eff16c512f9b3d9dab6518a359294cd0582fb8b4::hoo {
    struct HOO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HOO>, arg1: vector<0x2::coin::Coin<HOO>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<HOO>>(&mut arg1);
        0x2::pay::join_vec<HOO>(&mut v0, arg1);
        0x2::coin::burn<HOO>(arg0, 0x2::coin::split<HOO>(&mut v0, arg2, arg3));
        if (0x2::coin::value<HOO>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<HOO>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<HOO>(v0);
        };
    }

    fun init(arg0: HOO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://3dndd7sgmh65ph35bogu3er5knnuxllaj3tldb2wvkqt3pt3geba.arweave.net/2Nox_kZh_deffQuNTZI9U1tLrWBO5rGHVqqhPb57MQI"));
        let (v2, v3) = 0x2::coin::create_currency<HOO>(arg0, 6, b"HOO", b"HOO", b"HOO IS LITERALLY A MEME COIN.", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOO>>(v3);
        0x2::coin::mint_and_transfer<HOO>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOO>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HOO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HOO>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<HOO>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HOO>>(arg0);
    }

    // decompiled from Move bytecode v6
}

