module 0x5650d58030f361f60f81913b54bf026e93e957bfbf506234f8f2e83bd3bfbd85::test_sui {
    struct TEST_SUI has key {
        id: 0x2::object::UID,
    }

    struct Faucet has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<TEST_SUI>,
    }

    public fun mint(arg0: &mut Faucet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST_SUI> {
        0x2::coin::mint<TEST_SUI>(&mut arg0.treasury_cap, arg1, arg2)
    }

    public fun create(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<TEST_SUI>(arg0, 9, 0x1::string::utf8(b"TSUI"), 0x1::string::utf8(b"Test SUI"), 0x1::string::utf8(b"Worthless Quote for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TEST_SUI>(v0, arg1);
        let v2 = Faucet{
            id           : 0x2::object::new(arg1),
            treasury_cap : v1,
        };
        0x2::transfer::share_object<Faucet>(v2);
    }

    // decompiled from Move bytecode v7
}

