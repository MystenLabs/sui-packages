module 0x2dd1b9eadeb1acdc03768b22c1f59a7d7294d2bddaecb06085362824183964d9::batch_dispatcher {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeCollector has key {
        id: 0x2::object::UID,
        fee_amount: u64,
        accumulated_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct FeeChanged has copy, drop {
        new_fee: u64,
        admin: address,
    }

    struct FeeWithdrawn has copy, drop {
        amount: u64,
        admin: address,
    }

    struct BatchDispatched has copy, drop {
        coin_type: vector<u8>,
        recipients: u64,
        total_amount: u64,
        sender: address,
    }

    public entry fun batch_dispatch<T0>(arg0: &mut FeeCollector, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u64>, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::vector::length<address>(&arg4);
        assert!(0x1::vector::length<u64>(&arg3) == v1, 0);
        let v2 = 0;
        let v3 = 0;
        while (v2 < v1) {
            let v4 = *0x1::vector::borrow<u64>(&arg3, v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v4, arg5), *0x1::vector::borrow<address>(&arg4, v2));
            v3 = v3 + v4;
            v2 = v2 + 1;
        };
        if (arg0.fee_amount > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.accumulated_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.fee_amount, arg5)));
        };
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v5 = BatchDispatched{
            coin_type    : b"",
            recipients   : v1,
            total_amount : v3,
            sender       : v0,
        };
        0x2::event::emit<BatchDispatched>(v5);
    }

    public fun get_accumulated_fees(arg0: &FeeCollector) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.accumulated_fees)
    }

    public fun get_fee_amount(arg0: &FeeCollector) : u64 {
        arg0.fee_amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = FeeCollector{
            id               : 0x2::object::new(arg0),
            fee_amount       : 0,
            accumulated_fees : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<FeeCollector>(v1);
    }

    public entry fun set_fee(arg0: &AdminCap, arg1: &mut FeeCollector, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee_amount = arg2;
        let v0 = FeeChanged{
            new_fee : arg2,
            admin   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeChanged>(v0);
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut FeeCollector, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.accumulated_fees);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.accumulated_fees, v0), arg2), 0x2::tx_context::sender(arg2));
        };
        let v1 = FeeWithdrawn{
            amount : v0,
            admin  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FeeWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

