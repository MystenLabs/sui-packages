module 0x3076a56fd55162c536444833a9eea837872193097e5b6326e1ea3fd569d621bb::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUICAT>, arg1: vector<0x2::coin::Coin<SUICAT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUICAT>>(&mut arg1);
        0x2::pay::join_vec<SUICAT>(&mut v0, arg1);
        0x2::coin::burn<SUICAT>(arg0, 0x2::coin::split<SUICAT>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUICAT>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUICAT>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUICAT>(v0);
        };
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/Qmcg67VMLGzqa6e8VBbgMaLdoHEVz3av4CWM5bYYVzYiaP"));
        let (v2, v3) = 0x2::coin::create_currency<SUICAT>(arg0, 9, b"SCAT", b"SuiCat", b"A catfish in the depths of the blockchain.SuiCat guides your adventure on the Sui network.", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICAT>>(v3);
        0x2::coin::mint_and_transfer<SUICAT>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICAT>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUICAT>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUICAT>>(arg0);
    }

    // decompiled from Move bytecode v6
}

