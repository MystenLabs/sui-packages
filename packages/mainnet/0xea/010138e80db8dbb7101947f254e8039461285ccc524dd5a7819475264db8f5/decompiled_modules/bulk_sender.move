module 0xea010138e80db8dbb7101947f254e8039461285ccc524dd5a7819475264db8f5::bulk_sender {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct FeeCollector has key {
        id: 0x2::object::UID,
        fee_amount: u64,
        accumulated_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun accumulated_fees(arg0: &FeeCollector) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.accumulated_fees)
    }

    public entry fun bulk_send<T0>(arg0: &mut FeeCollector, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u64>, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 == 0x1::vector::length<address>(&arg4), 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&arg2)) >= arg0.fee_amount, 13906834341847105537);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, *0x1::vector::borrow<u64>(&arg3, v1), arg5), *0x1::vector::borrow<address>(&arg4, v1));
            v1 = v1 + 1;
        };
        refund<T0>(arg1, arg5);
        if (arg0.fee_amount > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.accumulated_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.fee_amount, arg5)));
        };
        refund<0x2::sui::SUI>(arg2, arg5);
    }

    public fun fee_amount(arg0: &FeeCollector) : u64 {
        arg0.fee_amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeCollector{
            id               : 0x2::object::new(arg0),
            fee_amount       : 500000000,
            accumulated_fees : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<FeeCollector>(v1);
    }

    public fun refund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg0)) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public entry fun set_fee(arg0: &AdminCap, arg1: &mut FeeCollector, arg2: u64) {
        arg1.fee_amount = arg2;
    }

    public entry fun withdraw_fee(arg0: &AdminCap, arg1: &mut FeeCollector, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.accumulated_fees);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.accumulated_fees, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

