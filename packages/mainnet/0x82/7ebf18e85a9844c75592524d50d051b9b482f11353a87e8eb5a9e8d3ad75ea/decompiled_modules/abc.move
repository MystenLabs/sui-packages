module 0x827ebf18e85a9844c75592524d50d051b9b482f11353a87e8eb5a9e8d3ad75ea::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ABC>, arg1: vector<0x2::coin::Coin<ABC>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<ABC>>(&mut arg1);
        0x2::pay::join_vec<ABC>(&mut v0, arg1);
        0x2::coin::burn<ABC>(arg0, 0x2::coin::split<ABC>(&mut v0, arg2, arg3));
        if (0x2::coin::value<ABC>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ABC>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<ABC>(v0);
        };
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmZyPG8KuGUqcKFuyTTpA5xj8YxCRTdvhYYMcbYCkYYpdN"));
        let (v2, v3) = 0x2::coin::create_currency<ABC>(arg0, 2, b"ABC", b"ABC", b"This", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABC>>(v3);
        0x2::coin::mint_and_transfer<ABC>(&mut v4, 100000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ABC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ABC>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<ABC>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ABC>>(arg0);
    }

    // decompiled from Move bytecode v6
}

