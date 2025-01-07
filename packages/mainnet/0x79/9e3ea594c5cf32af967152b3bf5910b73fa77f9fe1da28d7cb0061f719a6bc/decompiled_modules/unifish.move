module 0x799e3ea594c5cf32af967152b3bf5910b73fa77f9fe1da28d7cb0061f719a6bc::unifish {
    struct UNIFISH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<UNIFISH>, arg1: vector<0x2::coin::Coin<UNIFISH>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<UNIFISH>>(&mut arg1);
        0x2::pay::join_vec<UNIFISH>(&mut v0, arg1);
        0x2::coin::burn<UNIFISH>(arg0, 0x2::coin::split<UNIFISH>(&mut v0, arg2, arg3));
        if (0x2::coin::value<UNIFISH>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<UNIFISH>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<UNIFISH>(v0);
        };
    }

    fun init(arg0: UNIFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmNV2rTN31vr2mFwyoF7dxCAxkD1Bxzc6mCDAjoBY6418h"));
        let (v2, v3) = 0x2::coin::create_currency<UNIFISH>(arg0, 7, b"UFISH", b"UniFish", b"UNI FISH HAS COMES TO LIFE IN THE SUI NETWORK AND IS SHARING THE EXCITEMENT WITH THE COMMUNITY.", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIFISH>>(v3);
        0x2::coin::mint_and_transfer<UNIFISH>(&mut v4, 1120000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIFISH>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<UNIFISH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<UNIFISH>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<UNIFISH>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<UNIFISH>>(arg0);
    }

    // decompiled from Move bytecode v6
}

