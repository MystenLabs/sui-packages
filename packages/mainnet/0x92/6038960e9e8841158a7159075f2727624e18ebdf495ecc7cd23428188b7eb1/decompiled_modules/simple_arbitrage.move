module 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::simple_arbitrage {
    public fun calculate_profit(arg0: u64, arg1: u64) : u64 {
        if (arg1 > arg0) {
            arg1 - arg0
        } else {
            0
        }
    }

    public fun is_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        calculate_profit(arg0, arg1) >= arg2
    }

    public entry fun simple_sui_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= arg1, 101);
        assert!(v0 > 0, 102);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun test_coin_operations(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 0x2::coin::value<0x2::sui::SUI>(&arg0), 102);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

