module 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::balances {
    struct BalanceItem has copy, drop {
        value: u64,
        balance_type: 0x1::type_name::TypeName,
    }

    struct Balances has store {
        balances: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        balances_list: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        bag: 0x2::bag::Bag,
    }

    public fun destroy_empty(arg0: Balances) {
        let Balances {
            balances      : v0,
            balances_list : _,
            bag           : v2,
        } = arg0;
        0x2::table::destroy_empty<0x1::type_name::TypeName, u64>(v0);
        0x2::bag::destroy_empty(v2);
    }

    public fun is_empty(arg0: &Balances) : bool {
        0x2::bag::is_empty(&arg0.bag)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Balances {
        Balances{
            balances      : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
            balances_list : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            bag           : 0x2::bag::new(arg0),
        }
    }

    public fun value<T0>(arg0: &Balances) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.balances, v0)) {
            return 0
        };
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.balances, v0)
    }

    public fun deposit<T0>(arg0: &mut Balances, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0) = 0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0), arg1);
        } else {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.balances_list, v0);
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0, 0x2::balance::value<T0>(&arg1));
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0, arg1);
        };
    }

    public fun into_values(arg0: BalanceItem) : (0x1::type_name::TypeName, u64) {
        let BalanceItem {
            value        : v0,
            balance_type : v1,
        } = arg0;
        (v1, v0)
    }

    public fun list(arg0: &Balances) : vector<BalanceItem> {
        let v0 = *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.balances_list);
        let v1 = 0x1::vector::empty<BalanceItem>();
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v0)) {
            let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v0);
            let v3 = BalanceItem{
                value        : *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.balances, v2),
                balance_type : v2,
            };
            0x1::vector::push_back<BalanceItem>(&mut v1, v3);
        };
        v1
    }

    public fun partial_withdraw<T0>(arg0: &mut Balances, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, v0)) {
            return 0x2::balance::zero<T0>()
        };
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0);
        if (0x2::balance::value<T0>(&v1) == 0) {
            0x2::balance::destroy_zero<T0>(v1);
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.balances_list, &v0);
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0);
            return 0x2::balance::split<T0>(&mut v1, arg1)
        };
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0) = 0x2::balance::value<T0>(&v1);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0, v1);
        0x2::balance::split<T0>(&mut v1, arg1)
    }

    public fun withdraw<T0>(arg0: &mut Balances) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.balances_list, &v0);
        0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0)
    }

    // decompiled from Move bytecode v6
}

