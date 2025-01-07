module 0x917e748c6f4c64bee9013514b6cbcd2fd43bd6528de494ad5208292a7d95337::lololi {
    struct LOLOLI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOLOLI>, arg1: vector<0x2::coin::Coin<LOLOLI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<LOLOLI>>(&mut arg1);
        0x2::pay::join_vec<LOLOLI>(&mut v0, arg1);
        0x2::coin::burn<LOLOLI>(arg0, 0x2::coin::split<LOLOLI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<LOLOLI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LOLOLI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<LOLOLI>(v0);
        };
    }

    fun init(arg0: LOLOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmTUtJH3La9HxveUQbR9kKkvkQtKFBrY4uraTzig3C7Jzc"));
        let (v2, v3) = 0x2::coin::create_currency<LOLOLI>(arg0, 7, b"LoLi", b"LoLoLi", b"Did you know Sydney has its own pygmy hippo at Tarongazoo?", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLOLI>>(v3);
        0x2::coin::mint_and_transfer<LOLOLI>(&mut v4, 10000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLOLI>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOLOLI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LOLOLI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<LOLOLI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOLOLI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

