module 0x61fc7b5f1af4b7f7a6a98270ec47c66ca52ba152115d32111cfd76d2215c41a7::event_contract {
    struct EventContractCreated has copy, drop {
        name: 0x1::ascii::String,
        ticker: 0x1::ascii::String,
        description: 0x1::ascii::String,
        image_url: 0x1::ascii::String,
        creator: 0x1::ascii::String,
        coin_types: vector<0x1::ascii::String>,
        weights: vector<u64>,
        fee_in: u64,
        fee_out: u64,
    }

    public fun create_etf_contract(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: vector<0x1::ascii::String>, arg6: vector<u64>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::ascii::String>(&arg5) == 0x1::vector::length<u64>(&arg6), 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 1000000000, 1);
        assert!(arg7 <= 1000, 2);
        assert!(arg8 <= 1000, 3);
        let v0 = EventContractCreated{
            name        : arg1,
            ticker      : arg2,
            description : arg3,
            image_url   : arg4,
            creator     : 0x2::address::to_ascii_string(0x2::tx_context::sender(arg9)),
            coin_types  : arg5,
            weights     : arg6,
            fee_in      : arg7,
            fee_out     : arg8,
        };
        0x2::event::emit<EventContractCreated>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x4b0d62f8d195e018fc43a47ae9b493bef6ff6ec06c50dcc5219e14f249b3e65a);
    }

    // decompiled from Move bytecode v6
}

