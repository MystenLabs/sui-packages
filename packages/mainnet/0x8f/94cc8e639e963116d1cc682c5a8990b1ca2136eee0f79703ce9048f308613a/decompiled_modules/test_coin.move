module 0x8f94cc8e639e963116d1cc682c5a8990b1ca2136eee0f79703ce9048f308613a::test_coin {
    struct TEST_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST_COIN>(arg0, 8, 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"Rehearsal Test Coin"), 0x1::string::utf8(b"Disposable coin for a DEX listing rehearsal. It has no value."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TEST_COIN>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

