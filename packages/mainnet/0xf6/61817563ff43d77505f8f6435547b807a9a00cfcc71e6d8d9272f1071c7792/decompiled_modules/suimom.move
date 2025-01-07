module 0xf661817563ff43d77505f8f6435547b807a9a00cfcc71e6d8d9272f1071c7792::suimom {
    struct SUIMOM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIMOM>, arg1: vector<0x2::coin::Coin<SUIMOM>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIMOM>>(&mut arg1);
        0x2::pay::join_vec<SUIMOM>(&mut v0, arg1);
        0x2::coin::burn<SUIMOM>(arg0, 0x2::coin::split<SUIMOM>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIMOM>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIMOM>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIMOM>(v0);
        };
    }

    fun init(arg0: SUIMOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmVtUwEPJquEJbwfQ6Buhx5meygZUXVQpjLxGkoi9ZkLsx"));
        let (v2, v3) = 0x2::coin::create_currency<SUIMOM>(arg0, 7, b"SUIMOM", b"SUIMOM", b"Mom of SUI", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMOM>>(v3);
        0x2::coin::mint_and_transfer<SUIMOM>(&mut v4, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOM>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIMOM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIMOM>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIMOM>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIMOM>>(arg0);
    }

    // decompiled from Move bytecode v6
}

