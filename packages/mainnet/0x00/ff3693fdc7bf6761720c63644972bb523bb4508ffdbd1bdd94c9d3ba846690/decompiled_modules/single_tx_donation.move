module 0xff3693fdc7bf6761720c63644972bb523bb4508ffdbd1bdd94c9d3ba846690::single_tx_donation {
    public entry fun donate_max(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        if (v0 > 100000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, v0 - 100000000, arg2), arg1);
        };
    }

    public entry fun donate_with_custom_gas(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 100000000, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        assert!(v0 > arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, v0 - arg2, arg3), arg1);
    }

    public entry fun donate_with_gas_reserve(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        assert!(v0 > 150000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, v0 - 150000000, arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

