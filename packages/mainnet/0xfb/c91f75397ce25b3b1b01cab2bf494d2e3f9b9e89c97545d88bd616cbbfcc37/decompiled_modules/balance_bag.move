module 0xfbc91f75397ce25b3b1b01cab2bf494d2e3f9b9e89c97545d88bd616cbbfcc37::balance_bag {
    struct BalanceBag has store {
        balances: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        bag: 0x2::bag::Bag,
    }

    public(friend) fun destroy_empty(arg0: BalanceBag) {
        let BalanceBag {
            balances : _,
            bag      : v1,
        } = arg0;
        0x2::bag::destroy_empty(v1);
    }

    public fun is_empty(arg0: &BalanceBag) : bool {
        0x2::vec_map::is_empty<0x1::type_name::TypeName, u64>(&arg0.balances)
    }

    public fun balances(arg0: &BalanceBag) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.balances
    }

    public(friend) fun join<T0>(arg0: &mut BalanceBag, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.balances, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, &v0) = 0xfbc91f75397ce25b3b1b01cab2bf494d2e3f9b9e89c97545d88bd616cbbfcc37::utils::add_balance_to_bag<T0>(&mut arg0.bag, arg1);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0, 0xfbc91f75397ce25b3b1b01cab2bf494d2e3f9b9e89c97545d88bd616cbbfcc37::utils::add_balance_to_bag<T0>(&mut arg0.bag, arg1));
        };
    }

    public(friend) fun new_balance_bag(arg0: &mut 0x2::tx_context::TxContext) : BalanceBag {
        BalanceBag{
            balances : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            bag      : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun split<T0>(arg0: &mut BalanceBag, arg1: u64) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0xfbc91f75397ce25b3b1b01cab2bf494d2e3f9b9e89c97545d88bd616cbbfcc37::utils::remove_balance_from_bag<T0>(&mut arg0.bag, arg1, false);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.balances, &v2)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, &v2) = v1;
        };
        v0
    }

    public fun value<T0>(arg0: &BalanceBag) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.balances, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.balances, &v0)
        } else {
            0
        }
    }

    public(friend) fun withdraw_all<T0>(arg0: &mut BalanceBag) : 0x2::balance::Balance<T0> {
        let (v0, _) = 0xfbc91f75397ce25b3b1b01cab2bf494d2e3f9b9e89c97545d88bd616cbbfcc37::utils::remove_balance_from_bag<T0>(&mut arg0.bag, 0, true);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.balances, &v2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.balances, &v2);
        };
        v0
    }

    // decompiled from Move bytecode v6
}

