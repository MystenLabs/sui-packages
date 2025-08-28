module 0xc389739618e491b713e8c16af1afecd6bdb8ce9c1c3e393b1021a64badce48af::reproduction {
    struct MockVault has key {
        id: 0x2::object::UID,
        balance: u64,
        paused: bool,
    }

    struct MockLendingMarket<phantom T0> has key {
        id: 0x2::object::UID,
        reserve_count: u64,
    }

    struct MockStrategies has key {
        id: 0x2::object::UID,
        strategy_count: u64,
    }

    struct MockCToken has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    public entry fun deposit_correct(arg0: &mut MockVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut MockLendingMarket<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &MockStrategies, arg6: &mut 0x2::tx_context::TxContext) {
        arg0.balance = arg0.balance + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg6));
        let v0 = MockCToken{
            id     : 0x2::object::new(arg6),
            amount : 1000,
        };
        0x2::transfer::public_transfer<MockCToken>(v0, 0x2::tx_context::sender(arg6));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MockVault{
            id      : 0x2::object::new(arg0),
            balance : 0,
            paused  : false,
        };
        0x2::transfer::share_object<MockVault>(v0);
        let v1 = MockLendingMarket<0x2::sui::SUI>{
            id            : 0x2::object::new(arg0),
            reserve_count : 1,
        };
        0x2::transfer::share_object<MockLendingMarket<0x2::sui::SUI>>(v1);
        let v2 = MockStrategies{
            id             : 0x2::object::new(arg0),
            strategy_count : 1,
        };
        0x2::transfer::share_object<MockStrategies>(v2);
    }

    // decompiled from Move bytecode v6
}

