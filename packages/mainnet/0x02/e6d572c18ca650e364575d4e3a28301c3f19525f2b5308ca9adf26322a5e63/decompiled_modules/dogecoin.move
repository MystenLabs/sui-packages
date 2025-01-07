module 0x2e6d572c18ca650e364575d4e3a28301c3f19525f2b5308ca9adf26322a5e63::dogecoin {
    struct DOGECOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGECOIN>, arg1: vector<0x2::coin::Coin<DOGECOIN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<DOGECOIN>>(&mut arg1);
        0x2::pay::join_vec<DOGECOIN>(&mut v0, arg1);
        0x2::coin::burn<DOGECOIN>(arg0, 0x2::coin::split<DOGECOIN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<DOGECOIN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<DOGECOIN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<DOGECOIN>(v0);
        };
    }

    fun init(arg0: DOGECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmPvFPCfocpJGj2DS6CPBKiqfJodUaebgnr9EexqiunRGj"));
        let (v2, v3) = 0x2::coin::create_currency<DOGECOIN>(arg0, 7, b"DOGE", b"Dogecoin", b"At its heart, Dogecoin is the accidental crypto movement that makes people smile! It is also an opensource peer-to-peer cryptocurrency that utilises blockchain technology, a highly secure decentralised system of storing information as a public ledger that is maintained by a network of computers called nodes. More than this, though, is the ethos of Dogecoin, summarised in the Dogecoin Manifesto , and its amazing, vibrant community made up of friendly folks just like you!", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGECOIN>>(v3);
        0x2::coin::mint_and_transfer<DOGECOIN>(&mut v4, 1996900000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGECOIN>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGECOIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<DOGECOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGECOIN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

