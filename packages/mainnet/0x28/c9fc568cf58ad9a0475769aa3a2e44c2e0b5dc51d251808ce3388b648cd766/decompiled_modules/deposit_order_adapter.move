module 0x51c41ed66bac401798bf9a4e5d9ea4cd52625774bd3823fdf27e78100c69ae6d::deposit_order_adapter {
    public fun execute<T0>(arg0: &0x51c41ed66bac401798bf9a4e5d9ea4cd52625774bd3823fdf27e78100c69ae6d::aggregator::Config, arg1: &mut 0x51c41ed66bac401798bf9a4e5d9ea4cd52625774bd3823fdf27e78100c69ae6d::aggregator::FeeVault, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 != @0x0, 1);
        assert!(0x2::coin::value<T0>(&arg3) == arg4, 2);
        let (v0, v1) = 0x51c41ed66bac401798bf9a4e5d9ea4cd52625774bd3823fdf27e78100c69ae6d::aggregator::take_fee<T0>(arg0, arg1, arg2, arg3, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg5);
        0x51c41ed66bac401798bf9a4e5d9ea4cd52625774bd3823fdf27e78100c69ae6d::aggregator::complete_bridge(v1);
    }

    // decompiled from Move bytecode v7
}

