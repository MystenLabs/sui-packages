module 0x9b6faae547f3cf54bb0430c2ae196b8c41cc0e922e0d8212c0c3dba14ce07677::test_app {
    struct TEST_APP has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST_APP>, arg1: 0x2::coin::Coin<TEST_APP>) {
        0x2::coin::burn<TEST_APP>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_APP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST_APP> {
        0x2::coin::mint<TEST_APP>(arg0, arg1, arg2)
    }

    fun init(arg0: TEST_APP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_APP>(arg0, 6, b"TEST_APP", b"test_app_1", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://lks3-bucket.s3.ap-southeast-1.amazonaws.com/175464719410974ai.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_APP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_APP>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<TEST_APP>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST_APP> {
        assert!(0x2::coin::total_supply<TEST_APP>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<TEST_APP>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

