module 0xa0254ffb01f4f671a1ae085dd785edd442eb81295d73aba9a6ad64b100257f6a::aaacat {
    struct AAACAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AAACAT>, arg1: vector<0x2::coin::Coin<AAACAT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<AAACAT>>(&mut arg1);
        0x2::pay::join_vec<AAACAT>(&mut v0, arg1);
        0x2::coin::burn<AAACAT>(arg0, 0x2::coin::split<AAACAT>(&mut v0, arg2, arg3));
        if (0x2::coin::value<AAACAT>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<AAACAT>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<AAACAT>(v0);
        };
    }

    fun init(arg0: AAACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmbD9daEheM5E1EU3tuj3DgEsEfZuz5bmJKkPAyt12CoR5"));
        let (v2, v3) = 0x2::coin::create_currency<AAACAT>(arg0, 9, b"AAA", b"aaacat", b"Cant stop wont stop thinking about Sui", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAACAT>>(v3);
        0x2::coin::mint_and_transfer<AAACAT>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAACAT>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AAACAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AAACAT>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<AAACAT>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AAACAT>>(arg0);
    }

    // decompiled from Move bytecode v6
}

