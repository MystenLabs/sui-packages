module 0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::debt_info {
    struct DebtInfoEntry has copy, drop, store {
        supply_x64: u128,
        liability_value_x64: u128,
    }

    struct DebtInfo has copy, drop {
        facil_id: 0x2::object::ID,
        map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, DebtInfoEntry>,
    }

    struct ValidatedDebtInfo has copy, drop {
        map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, DebtInfoEntry>,
    }

    public fun empty(arg0: 0x2::object::ID) : DebtInfo {
        DebtInfo{
            facil_id : arg0,
            map      : 0x2::vec_map::empty<0x1::type_name::TypeName, DebtInfoEntry>(),
        }
    }

    public fun add<T0>(arg0: &mut DebtInfo, arg1: &0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::debt::DebtRegistry<T0>) {
        let v0 = DebtInfoEntry{
            supply_x64          : 0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::debt::supply_x64<T0>(arg1),
            liability_value_x64 : 0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::debt::liability_value_x64<T0>(arg1),
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, DebtInfoEntry>(&mut arg0.map, 0x1::type_name::get<T0>(), v0);
    }

    public fun add_from_supply_pool<T0, T1>(arg0: &mut DebtInfo, arg1: &mut 0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::supply_pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        let v0 = arg0.facil_id;
        add<T1>(arg0, 0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::supply_pool::borrow_debt_registry<T0, T1>(arg1, &v0, arg2));
    }

    public fun calc_repay_by_amount(arg0: &ValidatedDebtInfo, arg1: 0x1::type_name::TypeName, arg2: u64) : u128 {
        calc_repay_for_amount(arg0, arg1, arg2)
    }

    public fun calc_repay_by_shares(arg0: &ValidatedDebtInfo, arg1: 0x1::type_name::TypeName, arg2: u128) : u64 {
        calc_repay_lossy(arg0, arg1, arg2)
    }

    fun calc_repay_for_amount(arg0: &ValidatedDebtInfo, arg1: 0x1::type_name::TypeName, arg2: u64) : u128 {
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, DebtInfoEntry>(&arg0.map, &arg1);
        0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::util::muldiv_u128((arg2 as u128) * 18446744073709551616, v0.supply_x64, v0.liability_value_x64)
    }

    fun calc_repay_lossy(arg0: &ValidatedDebtInfo, arg1: 0x1::type_name::TypeName, arg2: u128) : u64 {
        (0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::util::divide_and_round_up_u128(calc_repay_x64(arg0, arg1, arg2), 18446744073709551616) as u64)
    }

    fun calc_repay_x64(arg0: &ValidatedDebtInfo, arg1: 0x1::type_name::TypeName, arg2: u128) : u128 {
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, DebtInfoEntry>(&arg0.map, &arg1);
        0xdbd1fb063a90d855b7aee77faa3272c569c82a92283518bbfc4866bad5e24633::util::muldiv_round_up_u128(v0.liability_value_x64, arg2, v0.supply_x64)
    }

    public fun facil_id(arg0: &DebtInfo) : 0x2::object::ID {
        arg0.facil_id
    }

    public fun validate(arg0: &DebtInfo, arg1: 0x2::object::ID) : ValidatedDebtInfo {
        assert!(arg0.facil_id == arg1, 0);
        ValidatedDebtInfo{map: arg0.map}
    }

    // decompiled from Move bytecode v6
}

