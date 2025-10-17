module 0x177549e7aedead3a0eabb8ca1346183a2f77d64fde569a4b231d63af985074f0::test_coin {
    struct TEST_COIN has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_COIN>>(0x2::coin::mint<TEST_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST_COIN>(arg0, 6, 0x1::string::utf8(b"tCOIN2"), 0x1::string::utf8(b"tCOIN2"), 0x1::string::utf8(b"tCOIN2"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TEST_COIN>>(0x2::coin_registry::finalize<TEST_COIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

