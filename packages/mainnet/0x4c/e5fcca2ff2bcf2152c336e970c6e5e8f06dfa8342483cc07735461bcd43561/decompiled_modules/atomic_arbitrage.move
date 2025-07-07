module 0x4ce5fcca2ff2bcf2152c336e970c6e5e8f06dfa8342483cc07735461bcd43561::atomic_arbitrage {
    struct KriyaPoolRef has copy, drop, store {
        id: address,
    }

    struct TurbosPoolRef has copy, drop, store {
        id: address,
    }

    struct CetusPoolRef has copy, drop, store {
        id: address,
    }

    public entry fun execute_atomic_swap_kriya_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        KriyaPoolRef{id: @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305};
        TurbosPoolRef{id: @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78};
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public entry fun execute_multi_dex_atomic_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(arg1 != arg2, 2);
        if (arg1 == 1 && arg2 == 3) {
            KriyaPoolRef{id: @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305};
            CetusPoolRef{id: @0x2e041f3fd93646dcc877f783c1f2b7fa62d30271bdef1f21ef002cebf857bded};
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            assert!(arg1 == 2 && arg2 == 1, 2);
            TurbosPoolRef{id: @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78};
            KriyaPoolRef{id: @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305};
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        };
    }

    public fun get_contract_version() : u64 {
        1
    }

    public fun is_claude_compliant_amount(arg0: u64) : bool {
        arg0 == 10000000
    }

    public entry fun verify_sdk_deployment(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::zero<0x2::sui::SUI>(arg0), 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

