module 0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::commission {
    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        refel_address: address,
    }

    public fun calculate_and_distribute_commission<T0>(arg0: &0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::init::Version, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::init::check_dexrouter_version(arg0);
        assert!(arg2 <= 300, 1);
        let v0 = arg4 * arg2 / (10000 - arg2);
        assert!(0x2::coin::value<T0>(arg1) >= v0 + arg4, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v0, arg5), arg3);
        let v1 = CommissionRecord{
            commission_amount : v0,
            refel_address     : arg3,
        };
        0x2::event::emit<CommissionRecord>(v1);
        0x2::coin::split<T0>(arg1, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

