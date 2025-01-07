module 0x145a095aa95961c6292ae19ff2b93bf31caee89a05a81d42467d1ddc91fb6cac::BETTA {
    struct BETTA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BETTA>, arg1: vector<0x2::coin::Coin<BETTA>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BETTA>>(&mut arg1);
        0x2::pay::join_vec<BETTA>(&mut v0, arg1);
        0x2::coin::burn<BETTA>(arg0, 0x2::coin::split<BETTA>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BETTA>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BETTA>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BETTA>(v0);
        };
    }

    fun init(arg0: BETTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETTA>(arg0, 9, b"BETTA", b"BETTA", b"BETTA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaZBVmQmLKxJurPtc4ywd2TJMXXCb6tFf7sTBt1yS58rn")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BETTA>(&mut v2, 100000000000000000, @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETTA>>(v2, @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BETTA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BETTA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

