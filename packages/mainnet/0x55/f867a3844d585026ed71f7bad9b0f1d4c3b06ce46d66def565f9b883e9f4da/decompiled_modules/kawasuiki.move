module 0x55f867a3844d585026ed71f7bad9b0f1d4c3b06ce46d66def565f9b883e9f4da::kawasuiki {
    struct KAWASUIKI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KAWASUIKI>, arg1: vector<0x2::coin::Coin<KAWASUIKI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<KAWASUIKI>>(&mut arg1);
        0x2::pay::join_vec<KAWASUIKI>(&mut v0, arg1);
        0x2::coin::burn<KAWASUIKI>(arg0, 0x2::coin::split<KAWASUIKI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<KAWASUIKI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<KAWASUIKI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<KAWASUIKI>(v0);
        };
    }

    fun init(arg0: KAWASUIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmQ28Hh7Cr9w6bNobf32PJjnFp9otbkA3Y616JGkPZ2y7S"));
        let (v2, v3) = 0x2::coin::create_currency<KAWASUIKI>(arg0, 8, b"Ksui", b"Kawasuiki", b" the fastest ", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAWASUIKI>>(v3);
        0x2::coin::mint_and_transfer<KAWASUIKI>(&mut v4, 12000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAWASUIKI>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KAWASUIKI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KAWASUIKI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<KAWASUIKI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KAWASUIKI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

