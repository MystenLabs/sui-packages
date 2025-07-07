module 0xd2549904677bfa0a14b075436d4347978fa308e93de0c668e47e8f6d5c28a41b::atomic_arbitrage {
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
        let v0 = KriyaPoolRef{id: @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305};
        let v1 = TurbosPoolRef{id: @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78};
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(v0.id == @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305, 2);
        assert!(v1.id == @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public entry fun execute_multi_dex_atomic_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(arg1 != arg2, 2);
        if (arg1 == 1 && arg2 == 3) {
            let v0 = KriyaPoolRef{id: @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305};
            let v1 = CetusPoolRef{id: @0x2e041f3fd93646dcc877f783c1f2b7fa62d30271bdef1f21ef002cebf857bded};
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
            assert!(v0.id == @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305, 2);
            assert!(v1.id == @0x2e041f3fd93646dcc877f783c1f2b7fa62d30271bdef1f21ef002cebf857bded, 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            assert!(arg1 == 2 && arg2 == 1, 2);
            let v2 = TurbosPoolRef{id: @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78};
            let v3 = KriyaPoolRef{id: @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305};
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
            assert!(v2.id == @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78, 2);
            assert!(v3.id == @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305, 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        };
    }

    public fun get_contract_version() : u64 {
        1
    }

    public fun is_claude_compliant_amount(arg0: u64) : bool {
        arg0 == 10000000
    }

    public entry fun sdk_atomic_swap_validation(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(arg1 != arg2, 2);
        assert!(arg1 >= 1 && arg1 <= 3, 2);
        assert!(arg2 >= 1 && arg2 <= 3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public entry fun verify_sdk_deployment(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::zero<0x2::sui::SUI>(arg0), 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

