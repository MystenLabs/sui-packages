module 0xfa0f68587c91520e98aaeaffea4fbe76cb24ae5c7482d4c4c3f031fb6c77708d::test_coin {
    struct TEST_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_COIN>>(0x2::coin::mint<TEST_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST_COIN>(arg0, 9, 0x1::string::utf8(b"Test Coin"), 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"Test coin for vesting contract testing"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TEST_COIN>>(0x2::coin_registry::finalize<TEST_COIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint_batch(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN>, arg1: vector<u64>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 == 0x1::vector::length<address>(&arg2), 0);
        let v1 = 0;
        while (v1 < v0) {
            mint(arg0, *0x1::vector::borrow<u64>(&arg1, v1), *0x1::vector::borrow<address>(&arg2, v1), arg3);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

