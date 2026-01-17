module 0x98d055d82d3d43047ed995a3ef81230472cc9ef5d33da64f2b0dcf83228cc7dc::fee_collector {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        owner: address,
        standard_swaps: u64,
        private_swaps: u64,
    }

    struct FeeCollected has copy, drop {
        amount: u64,
        fee_type: u8,
        user: address,
    }

    struct FeeWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    fun collect_fee_internal<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1) * arg2 / 10000;
        if (v0 == 0) {
            return arg1
        };
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v1)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v0, arg4)));
        } else {
            0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v0, arg4)));
        };
        if (arg3 == 0) {
            arg0.standard_swaps = arg0.standard_swaps + 1;
        } else {
            arg0.private_swaps = arg0.private_swaps + 1;
        };
        let v2 = FeeCollected{
            amount   : v0,
            fee_type : arg3,
            user     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<FeeCollected>(v2);
        arg1
    }

    public fun collect_private_fee<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        collect_fee_internal<T0>(arg0, arg1, 200, 1, arg2)
    }

    public fun collect_standard_fee<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        collect_fee_internal<T0>(arg0, arg1, 100, 0, arg2)
    }

    public fun get_balance<T0>(arg0: &Treasury) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Treasury{
            id             : 0x2::object::new(arg0),
            owner          : 0x2::tx_context::sender(arg0),
            standard_swaps : 0,
            private_swaps  : 0,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Treasury>(v1);
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.id, v0), 1);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, arg2, arg4), arg3);
        let v2 = FeeWithdrawn{
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<FeeWithdrawn>(v2);
    }

    // decompiled from Move bytecode v6
}

