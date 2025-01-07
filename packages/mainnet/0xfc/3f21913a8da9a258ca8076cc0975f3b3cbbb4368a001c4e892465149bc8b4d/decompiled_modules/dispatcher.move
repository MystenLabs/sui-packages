module 0xfc3f21913a8da9a258ca8076cc0975f3b3cbbb4368a001c4e892465149bc8b4d::dispatcher {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeCollector has key {
        id: 0x2::object::UID,
        fee_amount: u64,
        accumulated_fees: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct FeeChanged has copy, drop {
        fee_amount: u64,
        user: address,
    }

    struct FeeWithdrawn has copy, drop {
        fee_amount: u64,
        user: address,
    }

    public fun accumulated_fees(arg0: &FeeCollector) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.accumulated_fees)
    }

    public entry fun dispatch<T0>(arg0: &mut FeeCollector, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u64>, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        let v1 = 0;
        assert!(v0 == 0x1::vector::length<address>(&arg4), 0);
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, *0x1::vector::borrow<u64>(&arg3, v1), arg5), *0x1::vector::borrow<address>(&arg4, v1));
            v1 = v1 + 1;
        };
        refund<T0>(arg1, arg5);
        if (arg0.fee_amount > 0) {
            0x2::coin::join<0x2::sui::SUI>(&mut arg0.accumulated_fees, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.fee_amount, arg5));
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
            fee_amount       : 0,
            accumulated_fees : 0x2::coin::zero<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::share_object<FeeCollector>(v1);
    }

    fun refund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public entry fun set_fee(arg0: &AdminCap, arg1: &mut FeeCollector, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee_amount = arg2;
        let v0 = FeeChanged{
            fee_amount : arg2,
            user       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeChanged>(v0);
    }

    public entry fun withdraw_fee(arg0: &AdminCap, arg1: &mut FeeCollector, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1.accumulated_fees);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.accumulated_fees, v0, arg2), 0x2::tx_context::sender(arg2));
        };
        let v1 = FeeWithdrawn{
            fee_amount : v0,
            user       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FeeWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

