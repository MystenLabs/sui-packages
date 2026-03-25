module 0x4ecf4bc5690b5feffc40326261370e38cf92ea7049a18f353125fe744a3b7dd0::arb {
    struct ArbExecutada has copy, drop {
        executor: address,
        lucro_mist: u64,
        timestamp: u64,
    }

    public fun registrar_lucro(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = ArbExecutada{
            executor   : 0x2::tx_context::sender(arg2),
            lucro_mist : v0,
            timestamp  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ArbExecutada>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

