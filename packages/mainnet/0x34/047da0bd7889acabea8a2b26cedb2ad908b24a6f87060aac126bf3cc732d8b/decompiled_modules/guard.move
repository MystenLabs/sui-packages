module 0x34047da0bd7889acabea8a2b26cedb2ad908b24a6f87060aac126bf3cc732d8b::guard {
    public fun assert_min_output_and_return(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 0);
        arg0
    }

    public fun assert_min_profit_and_return(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: u64) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= arg1, 0);
        assert!(v0 - arg1 >= arg2 + arg3, 0);
        arg0
    }

    // decompiled from Move bytecode v7
}

