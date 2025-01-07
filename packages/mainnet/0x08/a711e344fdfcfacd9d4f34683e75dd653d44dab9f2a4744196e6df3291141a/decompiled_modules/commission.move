module 0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::commission {
    public(friend) fun calculate_comission_fee(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun is_valid_commission(arg0: u16) : bool {
        arg0 <= 10000
    }

    public(friend) fun split_commission(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(is_valid_commission(arg1), 1);
        0x2::coin::split<0x2::sui::SUI>(arg0, calculate_comission_fee(0x2::coin::value<0x2::sui::SUI>(arg0), arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

