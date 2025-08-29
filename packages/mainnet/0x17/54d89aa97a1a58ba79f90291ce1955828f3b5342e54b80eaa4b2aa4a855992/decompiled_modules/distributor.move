module 0x1754d89aa97a1a58ba79f90291ce1955828f3b5342e54b80eaa4b2aa4a855992::distributor {
    struct Distributor has store {
        default: DistributorEntry,
        entries: 0x2::vec_map::VecMap<0x1::type_name::TypeName, DistributorEntry>,
        source_balances: 0x2::bag::Bag,
        target_balances: 0x2::bag::Bag,
    }

    struct DistributorEntry has copy, drop, store {
        total_weight: u64,
        entries: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct DepositTargetEvent has copy, drop, store {
        target_type_name: 0x1::type_name::TypeName,
        type_: u8,
        amount: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Distributor {
        let v0 = DistributorEntry{
            total_weight : 0,
            entries      : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        Distributor{
            default         : v0,
            entries         : 0x2::vec_map::empty<0x1::type_name::TypeName, DistributorEntry>(),
            source_balances : 0x2::bag::new(arg0),
            target_balances : 0x2::bag::new(arg0),
        }
    }

    public fun add_distribute<T0>(arg0: &mut DistributorEntry, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.entries, &v0), 13906834732689522695);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.entries, v0, arg1);
        arg0.total_weight = arg0.total_weight + arg1;
    }

    public(friend) fun deposit<T0>(arg0: &mut Distributor, arg1: 0x2::balance::Balance<T0>) {
        let v0 = get_routes<T0>(arg0);
        assert!(0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v0.entries) > 0, 13906834917372723201);
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v0.entries) == 1) {
            let (v2, _) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v0.entries, 0);
            if (v2 == &v1) {
                merge_to_target_balances<T0>(arg0, arg1, 0);
                return
            };
        };
        let v4 = 0;
        while (v4 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v0.entries)) {
            let (v5, v6) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v0.entries, v4);
            let v7 = 0;
            if (v6 == &v7 || v5 == &v1) {
                v4 = v4 + 1;
                continue
            };
            merge_to_source_balances<T0>(arg0, *v5, 0x2::balance::split<T0>(&mut arg1, 0x1::u64::min(0x2::balance::value<T0>(&arg1), 0x1754d89aa97a1a58ba79f90291ce1955828f3b5342e54b80eaa4b2aa4a855992::full_math_u64::mul_div_ceil(0x2::balance::value<T0>(&arg1), *v6, v0.total_weight))));
            v4 = v4 + 1;
        };
        merge_to_target_balances<T0>(arg0, arg1, 0);
    }

    public fun entries(arg0: &DistributorEntry) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        arg0.entries
    }

    public fun get_default_entry(arg0: &Distributor) : DistributorEntry {
        arg0.default
    }

    public fun get_distribute_entry<T0>(arg0: &Distributor) : DistributorEntry {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, DistributorEntry>(&arg0.entries, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, DistributorEntry>(&arg0.entries, &v0)
        } else {
            arg0.default
        }
    }

    public fun get_routes<T0>(arg0: &Distributor) : DistributorEntry {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, DistributorEntry>(&arg0.entries, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, DistributorEntry>(&arg0.entries, &v0)
        } else {
            arg0.default
        }
    }

    fun merge_to_source_balances<T0>(arg0: &mut Distributor, arg1: 0x1::type_name::TypeName, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.source_balances, v0)) {
            let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(&mut arg0.source_balances, v0);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, &arg1)) {
                0x2::balance::join<T0>(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, &arg1), arg2);
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, arg1, arg2);
            };
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(&mut arg0.source_balances, v0, 0x2::vec_map::from_keys_values<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(0x1::vector::singleton<0x1::type_name::TypeName>(arg1), 0x1::vector::singleton<0x2::balance::Balance<T0>>(arg2)));
        };
    }

    public(friend) fun merge_to_target_balances<T0>(arg0: &mut Distributor, arg1: 0x2::balance::Balance<T0>, arg2: u8) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.target_balances, 0x1::type_name::get<T0>())) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.target_balances, 0x1::type_name::get<T0>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.target_balances, 0x1::type_name::get<T0>(), arg1);
        };
        let v0 = DepositTargetEvent{
            target_type_name : 0x1::type_name::get<T0>(),
            type_            : arg2,
            amount           : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<DepositTargetEvent>(v0);
    }

    public fun new_distribute_entry() : DistributorEntry {
        DistributorEntry{
            total_weight : 0,
            entries      : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        }
    }

    public(friend) fun remove_distribute<T0>(arg0: &mut Distributor) : 0x1::option::Option<DistributorEntry> {
        let v0 = 0x1::type_name::get<T0>();
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, DistributorEntry>(&mut arg0.entries, &v0);
        0x1::option::some<DistributorEntry>(v2)
    }

    public(friend) fun set_default_distribute(arg0: &mut Distributor, arg1: DistributorEntry) : DistributorEntry {
        arg0.default = arg1;
        arg0.default
    }

    public(friend) fun set_distribute<T0>(arg0: &mut Distributor, arg1: DistributorEntry) : 0x1::option::Option<DistributorEntry> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = if (0x2::vec_map::contains<0x1::type_name::TypeName, DistributorEntry>(&arg0.entries, &v0)) {
            let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, DistributorEntry>(&mut arg0.entries, &v0);
            0x1::option::some<DistributorEntry>(v3)
        } else {
            0x1::option::none<DistributorEntry>()
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, DistributorEntry>(&mut arg0.entries, v0, arg1);
        v1
    }

    public fun source_balance_value<T0, T1>(arg0: &Distributor) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.source_balances, v0)) {
            let v2 = 0x2::bag::borrow<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(&arg0.source_balances, v0);
            let v3 = 0x1::type_name::get<T1>();
            if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v2, &v3)) {
                let v4 = 0x1::type_name::get<T1>();
                0x2::balance::value<T0>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v2, &v4))
            } else {
                0
            }
        } else {
            0
        }
    }

    public(friend) fun take_source_for_swap<T0, T1>(arg0: &mut Distributor, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.source_balances, 0x1::type_name::get<T0>()), 13906835080581611523);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(&mut arg0.source_balances, 0x1::type_name::get<T0>()), &v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 13906835097761611781);
        0x2::balance::split<T0>(v1, arg1)
    }

    public fun target_balance_value<T0>(arg0: &Distributor) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.target_balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.target_balances, v0))
        } else {
            0
        }
    }

    public fun total_weight(arg0: &DistributorEntry) : u64 {
        arg0.total_weight
    }

    public(friend) fun withdraw_source<T0>(arg0: &mut Distributor, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.source_balances, 0x1::type_name::get<T0>()), 13906835205135663107);
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(&mut arg0.source_balances, 0x1::type_name::get<T0>());
        let v1 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0);
        let v2 = 0x2::balance::zero<T0>();
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let (v6, v7) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0, 0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v3));
            let v8 = v7;
            if (0x2::balance::value<T0>(&v8) > 0) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v5, v6, 0x2::balance::value<T0>(&v8));
                v4 = v4 + 0x2::balance::value<T0>(&v8);
            };
            0x2::balance::join<T0>(&mut v2, v8);
            v3 = v3 + 1;
        };
        let v9 = 0;
        while (v9 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v5)) {
            let (v10, v11) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v5, v9);
            let v12 = 0;
            if (v11 == &v12) {
                continue
            };
            merge_to_source_balances<T0>(arg0, *v10, 0x2::balance::split<T0>(&mut v2, 0x1::u64::min(0x2::balance::value<T0>(&v2), 0x1754d89aa97a1a58ba79f90291ce1955828f3b5342e54b80eaa4b2aa4a855992::full_math_u64::mul_div_ceil(0x2::balance::value<T0>(&v2), *v11, v4))));
            v9 = v9 + 1;
        };
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::split<T0>(&mut v2, 0x1::u64::min(0x2::balance::value<T0>(&v2), arg1))
    }

    public(friend) fun withdraw_target<T0>(arg0: &mut Distributor, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.target_balances, 0x1::type_name::get<T0>()), 13906835136416186371);
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.target_balances, 0x1::type_name::get<T0>());
        let v1 = if (arg1 > 0x2::balance::value<T0>(v0)) {
            0x2::balance::value<T0>(v0)
        } else {
            arg1
        };
        0x2::balance::split<T0>(v0, v1)
    }

    // decompiled from Move bytecode v6
}

