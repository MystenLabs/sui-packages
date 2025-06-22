module 0x45461691dc5e5971768dcbce2cbbb5c5031d2fb03047992d47731134f826db67::atomic_arbitrage {
    struct PTBArbitrageValidated has copy, drop {
        sender: address,
        input_amount: u64,
        min_profit: u64,
        dex_a: vector<u8>,
        dex_b: vector<u8>,
        timestamp: u64,
    }

    public entry fun validate_ptb_arbitrage_deepbook_turbos(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 1001);
        assert!(arg1 > 0, 1002);
        let v0 = PTBArbitrageValidated{
            sender       : 0x2::tx_context::sender(arg3),
            input_amount : arg0,
            min_profit   : arg1,
            dex_a        : b"DEEPBOOK",
            dex_b        : b"TURBOS",
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PTBArbitrageValidated>(v0);
    }

    public entry fun validate_ptb_arbitrage_flowx_kriya(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 1001);
        assert!(arg1 > 0, 1002);
        let v0 = PTBArbitrageValidated{
            sender       : 0x2::tx_context::sender(arg3),
            input_amount : arg0,
            min_profit   : arg1,
            dex_a        : b"FLOWX",
            dex_b        : b"KRIYA",
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PTBArbitrageValidated>(v0);
    }

    public entry fun validate_ptb_arbitrage_turbos_cetus(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 1001);
        assert!(arg1 > 0, 1002);
        let v0 = PTBArbitrageValidated{
            sender       : 0x2::tx_context::sender(arg3),
            input_amount : arg0,
            min_profit   : arg1,
            dex_a        : b"TURBOS",
            dex_b        : b"CETUS",
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PTBArbitrageValidated>(v0);
    }

    // decompiled from Move bytecode v6
}

