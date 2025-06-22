module 0x724ed8b72d75afd4359dda2b991ab09a53203cc1c9c6e6040afabe0aeebc4077::validation_only {
    struct ArbitrageValidated has copy, drop {
        sender: address,
        input_amount: u64,
        min_profit: u64,
        timestamp: u64,
    }

    public entry fun validate_arbitrage_params(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 > 0, 1001);
        assert!(arg1 > 0, 1002);
        assert!(v1 >= arg1, 1003);
        let v2 = ArbitrageValidated{
            sender       : v0,
            input_amount : v1,
            min_profit   : arg1,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<ArbitrageValidated>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

