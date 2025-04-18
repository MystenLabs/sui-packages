module 0x52a890fd5a9000e4a91515cb4ea51b49d24965b39a5dfcb2b5a55411ec66e5cd::mrnimbus {
    struct MRNIMBUS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MRNIMBUS>, arg1: vector<0x2::coin::Coin<MRNIMBUS>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MRNIMBUS>>(&mut arg1);
        0x2::pay::join_vec<MRNIMBUS>(&mut v0, arg1);
        0x2::coin::burn<MRNIMBUS>(arg0, 0x2::coin::split<MRNIMBUS>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MRNIMBUS>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MRNIMBUS>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MRNIMBUS>(v0);
        };
    }

    fun init(arg0: MRNIMBUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<MRNIMBUS>(arg0, 9, b"Buy", b"MrNimbus", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<MRNIMBUS>(&mut v4, 6900000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRNIMBUS>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRNIMBUS>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MRNIMBUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MRNIMBUS>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MRNIMBUS>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MRNIMBUS>>(arg0);
    }

    // decompiled from Move bytecode v6
}

