module 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager {
    struct BalanceUpdateEvent<phantom T0> has copy, drop {
        owner: address,
        value: u64,
    }

    struct BalanceManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
        balances: 0x2::vec_map::VecMap<address, 0x2::balance::Balance<T0>>,
    }

    public fun new<T0>(arg0: 0x2::balance::Supply<T0>, arg1: &mut 0x2::tx_context::TxContext) : BalanceManager<T0> {
        BalanceManager<T0>{
            id       : 0x2::object::new(arg1),
            supply   : arg0,
            balances : 0x2::vec_map::empty<address, 0x2::balance::Balance<T0>>(),
        }
    }

    public fun add_balance<T0>(arg0: &mut BalanceManager<T0>, arg1: address, arg2: u64) : u64 {
        if (!0x2::vec_map::contains<address, 0x2::balance::Balance<T0>>(&arg0.balances, &arg1)) {
            0x2::vec_map::insert<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, arg1, 0x2::balance::zero<T0>());
        };
        let v0 = 0x2::balance::join<T0>(0x2::vec_map::get_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, &arg1), 0x2::balance::increase_supply<T0>(&mut arg0.supply, arg2));
        let v1 = BalanceUpdateEvent<T0>{
            owner : arg1,
            value : v0,
        };
        0x2::event::emit<BalanceUpdateEvent<T0>>(v1);
        v0
    }

    public fun balance_of<T0>(arg0: &BalanceManager<T0>, arg1: address) : &0x2::balance::Balance<T0> {
        let v0 = 0x2::vec_map::get_idx_opt<address, 0x2::balance::Balance<T0>>(&arg0.balances, &arg1);
        assert!(0x1::option::is_some<u64>(&v0), 101);
        let (_, v2) = 0x2::vec_map::get_entry_by_idx<address, 0x2::balance::Balance<T0>>(&arg0.balances, 0x1::option::extract<u64>(&mut v0));
        v2
    }

    public fun balance_of_mut<T0>(arg0: &mut BalanceManager<T0>, arg1: address) : &mut 0x2::balance::Balance<T0> {
        0x2::vec_map::get_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, &arg1)
    }

    public fun burn<T0>(arg0: &mut BalanceManager<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::decrease_supply<T0>(&mut arg0.supply, arg1)
    }

    public fun drop<T0>(arg0: BalanceManager<T0>) : (0x2::balance::Supply<T0>, 0x2::vec_map::VecMap<address, u64>) {
        let BalanceManager {
            id       : v0,
            supply   : v1,
            balances : v2,
        } = arg0;
        let v3 = v1;
        0x2::object::delete(v0);
        let (v4, v5) = 0x2::vec_map::into_keys_values<address, 0x2::balance::Balance<T0>>(v2);
        let v6 = vector[];
        let v7 = v5;
        0x1::vector::reverse<0x2::balance::Balance<T0>>(&mut v7);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x2::balance::Balance<T0>>(&v7)) {
            0x1::vector::push_back<u64>(&mut v6, 0x2::balance::decrease_supply<T0>(&mut v3, 0x1::vector::pop_back<0x2::balance::Balance<T0>>(&mut v7)));
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<0x2::balance::Balance<T0>>(v7);
        (v3, 0x2::vec_map::from_keys_values<address, u64>(v4, v6))
    }

    public fun saturating_sub_balance<T0>(arg0: &mut BalanceManager<T0>, arg1: address, arg2: u64) : u64 {
        if (!0x2::vec_map::contains<address, 0x2::balance::Balance<T0>>(&arg0.balances, &arg1)) {
            0x2::vec_map::insert<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, arg1, 0x2::balance::zero<T0>());
        };
        let v0 = 0x2::vec_map::get_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, &arg1);
        let v1 = if (0x2::balance::value<T0>(v0) > arg2) {
            0x2::balance::split<T0>(v0, arg2)
        } else {
            0x2::balance::withdraw_all<T0>(v0)
        };
        let v2 = BalanceUpdateEvent<T0>{
            owner : arg1,
            value : 0x2::balance::value<T0>(0x2::vec_map::get<address, 0x2::balance::Balance<T0>>(&arg0.balances, &arg1)),
        };
        0x2::event::emit<BalanceUpdateEvent<T0>>(v2);
        0x2::balance::decrease_supply<T0>(&mut arg0.supply, v1)
    }

    public fun saturating_transfer<T0>(arg0: &mut BalanceManager<T0>, arg1: address, arg2: address, arg3: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(0x2::vec_map::get<address, 0x2::balance::Balance<T0>>(&arg0.balances, &arg1));
        let v1 = if (v0 >= arg3) {
            arg3
        } else {
            v0
        };
        let v2 = BalanceUpdateEvent<T0>{
            owner : arg1,
            value : 0x2::balance::value<T0>(0x2::vec_map::get<address, 0x2::balance::Balance<T0>>(&arg0.balances, &arg1)),
        };
        0x2::event::emit<BalanceUpdateEvent<T0>>(v2);
        let v3 = BalanceUpdateEvent<T0>{
            owner : arg2,
            value : 0x2::balance::value<T0>(0x2::vec_map::get<address, 0x2::balance::Balance<T0>>(&arg0.balances, &arg2)),
        };
        0x2::event::emit<BalanceUpdateEvent<T0>>(v3);
        0x2::balance::join<T0>(0x2::vec_map::get_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, &arg2), 0x2::balance::split<T0>(0x2::vec_map::get_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, &arg1), v1))
    }

    public fun sub_balance<T0>(arg0: &mut BalanceManager<T0>, arg1: address, arg2: u64) : u64 {
        if (!0x2::vec_map::contains<address, 0x2::balance::Balance<T0>>(&arg0.balances, &arg1)) {
            0x2::vec_map::insert<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, arg1, 0x2::balance::zero<T0>());
        };
        let v0 = BalanceUpdateEvent<T0>{
            owner : arg1,
            value : 0x2::balance::value<T0>(0x2::vec_map::get<address, 0x2::balance::Balance<T0>>(&arg0.balances, &arg1)),
        };
        0x2::event::emit<BalanceUpdateEvent<T0>>(v0);
        0x2::balance::decrease_supply<T0>(&mut arg0.supply, 0x2::balance::split<T0>(0x2::vec_map::get_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, &arg1), arg2))
    }

    public fun supply<T0>(arg0: &BalanceManager<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.supply)
    }

    public fun transfer<T0>(arg0: &mut BalanceManager<T0>, arg1: address, arg2: address, arg3: u64) : u64 {
        let v0 = BalanceUpdateEvent<T0>{
            owner : arg1,
            value : 0x2::balance::value<T0>(0x2::vec_map::get<address, 0x2::balance::Balance<T0>>(&arg0.balances, &arg1)),
        };
        0x2::event::emit<BalanceUpdateEvent<T0>>(v0);
        let v1 = BalanceUpdateEvent<T0>{
            owner : arg2,
            value : 0x2::balance::value<T0>(0x2::vec_map::get<address, 0x2::balance::Balance<T0>>(&arg0.balances, &arg2)),
        };
        0x2::event::emit<BalanceUpdateEvent<T0>>(v1);
        0x2::balance::join<T0>(0x2::vec_map::get_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, &arg2), 0x2::balance::split<T0>(0x2::vec_map::get_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, &arg1), arg3))
    }

    // decompiled from Move bytecode v6
}

