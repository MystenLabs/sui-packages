module 0x44c4c70a5402f654ab43f2220ea7447cc5e053a6140155c57c61695ed3299a80::bubble {
    struct BUBBLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BUBBLE>, arg1: vector<0x2::coin::Coin<BUBBLE>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BUBBLE>>(&mut arg1);
        0x2::pay::join_vec<BUBBLE>(&mut v0, arg1);
        0x2::coin::burn<BUBBLE>(arg0, 0x2::coin::split<BUBBLE>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BUBBLE>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BUBBLE>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BUBBLE>(v0);
        };
    }

    fun init(arg0: BUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmaUM6gY288bayacTZdx16grXSs5cQunko19fEPTqzr7dr"));
        let (v2, v3) = 0x2::coin::create_currency<BUBBLE>(arg0, 9, b"BUBB", b"BUBBLE", x"4d616b6520612073706c617368207769746820425542424c4520e280942077686572652065766572792077617665206272696e677320756e657870656374656420726577617264732e", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBBLE>>(v3);
        0x2::coin::mint_and_transfer<BUBBLE>(&mut v4, 10000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLE>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BUBBLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BUBBLE>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BUBBLE>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUBBLE>>(arg0);
    }

    // decompiled from Move bytecode v6
}

