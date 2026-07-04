module 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
        coin_types: vector<0x1::type_name::TypeName>,
        total_collected_usdc_equiv: u64,
    }

    struct FeeDeposited has copy, drop {
        amount: u64,
        amount_usdc_equiv: u64,
        coin_type: 0x1::type_name::TypeName,
        depositor: address,
        epoch: u64,
    }

    struct FeeWithdrawn has copy, drop {
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        recipient: address,
        withdrawn_by: address,
        epoch: u64,
    }

    struct RefundProcessed has copy, drop {
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        recipient: address,
        processed_by: address,
        epoch: u64,
    }

    public fun balance_of<T0>(arg0: &Treasury) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun calculate_refund(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0 || arg2 == 0) {
            0
        } else if (arg2 >= arg1) {
            arg0
        } else {
            arg0 * arg2 / arg1
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: u64) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        let v1 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1, 0x2::coin::into_balance<T0>(arg1));
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.coin_types, v1);
        };
        arg0.total_collected_usdc_equiv = arg0.total_collected_usdc_equiv + arg3;
        let v2 = FeeDeposited{
            amount            : v0,
            amount_usdc_equiv : arg3,
            coin_type         : v1,
            depositor         : arg2,
            epoch             : arg4,
        };
        0x2::event::emit<FeeDeposited>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id                         : 0x2::object::new(arg0),
            balances                   : 0x2::bag::new(arg0),
            coin_types                 : 0x1::vector::empty<0x1::type_name::TypeName>(),
            total_collected_usdc_equiv : 0,
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun process_refund<T0>(arg0: &0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 602);
        assert!(arg3 != @0x0, 603);
        take_and_send<T0>(arg1, arg2, arg3, 601, arg4);
        let v0 = RefundProcessed{
            amount       : arg2,
            coin_type    : 0x1::type_name::with_original_ids<T0>(),
            recipient    : arg3,
            processed_by : 0x2::tx_context::sender(arg4),
            epoch        : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<RefundProcessed>(v0);
    }

    public fun supported_coin_types(arg0: &Treasury) : &vector<0x1::type_name::TypeName> {
        &arg0.coin_types
    }

    fun take_and_send<T0>(arg0: &mut Treasury, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 604);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg4), arg2);
    }

    public fun total_collected(arg0: &Treasury) : u64 {
        arg0.total_collected_usdc_equiv
    }

    public fun withdraw<T0>(arg0: &0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 602);
        assert!(arg3 != @0x0, 603);
        take_and_send<T0>(arg1, arg2, arg3, 600, arg4);
        let v0 = FeeWithdrawn{
            amount       : arg2,
            coin_type    : 0x1::type_name::with_original_ids<T0>(),
            recipient    : arg3,
            withdrawn_by : 0x2::tx_context::sender(arg4),
            epoch        : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<FeeWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

