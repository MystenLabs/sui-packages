module 0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::atomic_arbitrage {
    struct AtomicArbitrageValidated has copy, drop {
        sender: address,
        input_amount: u64,
        min_profit: u64,
        dex_a: vector<u8>,
        dex_b: vector<u8>,
        timestamp: u64,
    }

    public fun get_cetus_config() : address {
        0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::cetus_package()
    }

    public fun get_deepbook_config() : (address, address) {
        (0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::deepbook_package(), 0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::deepbook_registry())
    }

    public fun get_flowx_config() : (address, address) {
        (0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::flowx_package(), 0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::flowx_container())
    }

    public fun get_kriya_config() : (address, address) {
        (0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::kriya_package(), 0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::kriya_amm_contract())
    }

    public fun get_turbos_config() : address {
        0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::turbos_package()
    }

    public fun is_cetus_operational() : bool {
        0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::cetus_package() != @0x0
    }

    public fun is_deepbook_operational() : bool {
        0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::deepbook_package() != @0x0
    }

    public fun is_flowx_operational() : bool {
        0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::flowx_package() != @0x0 && 0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::flowx_container() != @0x0
    }

    public fun is_kriya_operational() : bool {
        0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::kriya_package() != @0x0 && 0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::kriya_amm_contract() != @0x0
    }

    public fun is_turbos_operational() : bool {
        0xc42287296104c17376154579648c52703052e429216701166f8aaf2931840783::constants::turbos_package() != @0x0
    }

    public entry fun validate_atomic_arbitrage_deepbook_turbos(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 1001);
        assert!(arg1 > 0, 1002);
        assert!(is_deepbook_operational(), 1003);
        assert!(is_turbos_operational(), 1003);
        let v0 = AtomicArbitrageValidated{
            sender       : 0x2::tx_context::sender(arg3),
            input_amount : arg0,
            min_profit   : arg1,
            dex_a        : b"DEEPBOOK",
            dex_b        : b"TURBOS",
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AtomicArbitrageValidated>(v0);
    }

    public entry fun validate_atomic_arbitrage_flowx_kriya(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 1001);
        assert!(arg1 > 0, 1002);
        assert!(is_flowx_operational(), 1003);
        assert!(is_kriya_operational(), 1003);
        let v0 = AtomicArbitrageValidated{
            sender       : 0x2::tx_context::sender(arg3),
            input_amount : arg0,
            min_profit   : arg1,
            dex_a        : b"FLOWX",
            dex_b        : b"KRIYA",
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AtomicArbitrageValidated>(v0);
    }

    public entry fun validate_atomic_arbitrage_turbos_cetus(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 1001);
        assert!(arg1 > 0, 1002);
        assert!(is_turbos_operational(), 1003);
        assert!(is_cetus_operational(), 1003);
        let v0 = AtomicArbitrageValidated{
            sender       : 0x2::tx_context::sender(arg3),
            input_amount : arg0,
            min_profit   : arg1,
            dex_a        : b"TURBOS",
            dex_b        : b"CETUS",
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AtomicArbitrageValidated>(v0);
    }

    // decompiled from Move bytecode v6
}

