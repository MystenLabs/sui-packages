module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_math {
    public(friend) fun price_per_share(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 1000000
        };
        ((((arg0 as u256) + (1000 as u256)) * (1000000 as u256) / ((arg1 as u256) + (1000 as u256))) as u128)
    }

    public(friend) fun to_assets(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg0 > 0, 2);
        if (arg2 == 0) {
            return 0
        };
        (((arg0 as u256) * ((arg1 as u256) + (1000 as u256)) / ((arg2 as u256) + (1000 as u256))) as u128)
    }

    public(friend) fun to_shares(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg0 > 0, 1);
        (((arg0 as u256) * ((arg2 as u256) + (1000 as u256)) / ((arg1 as u256) + (1000 as u256))) as u128)
    }

    // decompiled from Move bytecode v7
}

