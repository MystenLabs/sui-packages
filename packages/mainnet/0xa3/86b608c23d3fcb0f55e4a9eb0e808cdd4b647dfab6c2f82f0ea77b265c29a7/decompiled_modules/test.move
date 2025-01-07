module 0xa386b608c23d3fcb0f55e4a9eb0e808cdd4b647dfab6c2f82f0ea77b265c29a7::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: vector<0x2::coin::Coin<TEST>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<TEST>>(&mut arg1);
        0x2::pay::join_vec<TEST>(&mut v0, arg1);
        0x2::coin::burn<TEST>(arg0, 0x2::coin::split<TEST>(&mut v0, arg2, arg3));
        if (0x2::coin::value<TEST>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<TEST>(v0);
        };
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmWYa8xvStUbSJNRYPnWxuPgTfTSyJvLFEDB3H3ZoJ5SdV"));
        let (v2, v3) = 0x2::coin::create_currency<TEST>(arg0, 1, b"test", b"test", b"this is test", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v3);
        0x2::coin::mint_and_transfer<TEST>(&mut v4, 10000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TEST>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(arg0);
    }

    // decompiled from Move bytecode v6
}

