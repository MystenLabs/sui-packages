module 0x8850b4f44503d792702a6c1c704727de13d801ba4999a2bca50b60761005719f::test_simple {
    struct TestEvent has copy, drop {
        sender: address,
        amount: u64,
        timestamp: u64,
    }

    public entry fun test_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = TestEvent{
            sender    : v0,
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            timestamp : 0,
        };
        0x2::event::emit<TestEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
    }

    public entry fun test_with_clock(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = TestEvent{
            sender    : v0,
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TestEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

