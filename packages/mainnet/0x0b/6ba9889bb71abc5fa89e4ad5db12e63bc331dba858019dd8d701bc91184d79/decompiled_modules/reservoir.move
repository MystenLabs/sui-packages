module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::reservoir {
    struct Reservoir<phantom T0> has store, key {
        id: 0x2::object::UID,
        conversion_rate: u64,
        charge_fee_rate: u64,
        discharge_fee_rate: u64,
        pool: 0x2::balance::Balance<T0>,
        buck_minted_amount: u64,
    }

    struct FeeConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeConfig has copy, drop, store {
        charge_fee_rate: u64,
        discharge_fee_rate: u64,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Reservoir<T0> {
        Reservoir<T0>{
            id                 : 0x2::object::new(arg3),
            conversion_rate    : arg0,
            charge_fee_rate    : arg1,
            discharge_fee_rate : arg2,
            pool               : 0x2::balance::zero<T0>(),
            buck_minted_amount : 0,
        }
    }

    public fun charge_fee_rate<T0>(arg0: &Reservoir<T0>) : u64 {
        arg0.charge_fee_rate
    }

    public fun charge_fee_rate_for_partner<T0, T1: drop>(arg0: &Reservoir<T0>) : u64 {
        if (is_partner<T0, T1>(arg0)) {
            let v1 = FeeConfigKey{dummy_field: false};
            let v2 = 0x1::type_name::get<T1>();
            0x2::vec_map::get<0x1::type_name::TypeName, FeeConfig>(0x2::dynamic_field::borrow<FeeConfigKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FeeConfig>>(&arg0.id, v1), &v2).charge_fee_rate
        } else {
            charge_fee_rate<T0>(arg0)
        }
    }

    public fun conversion_rate<T0>(arg0: &Reservoir<T0>) : u64 {
        arg0.conversion_rate
    }

    public fun discharge_fee_rate<T0>(arg0: &Reservoir<T0>) : u64 {
        arg0.discharge_fee_rate
    }

    public fun discharge_fee_rate_for_partner<T0, T1: drop>(arg0: &Reservoir<T0>) : u64 {
        if (is_partner<T0, T1>(arg0)) {
            let v1 = FeeConfigKey{dummy_field: false};
            let v2 = 0x1::type_name::get<T1>();
            0x2::vec_map::get<0x1::type_name::TypeName, FeeConfig>(0x2::dynamic_field::borrow<FeeConfigKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FeeConfig>>(&arg0.id, v1), &v2).discharge_fee_rate
        } else {
            discharge_fee_rate<T0>(arg0)
        }
    }

    public(friend) fun handle_charge<T0>(arg0: &mut Reservoir<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::math::mul_div(v0, arg0.conversion_rate, 1000000000);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::reservoir_events::emit_charge_reservoir<T0>(v0, v1);
        0x2::balance::join<T0>(&mut arg0.pool, arg1);
        arg0.buck_minted_amount = arg0.buck_minted_amount + v1;
        v1
    }

    public(friend) fun handle_discharge<T0>(arg0: &mut Reservoir<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::math::mul_div(arg1, 1000000000, arg0.conversion_rate);
        assert!(v0 <= pool_balance<T0>(arg0), 0);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::reservoir_events::emit_discharge_reservoir<T0>(v0, arg1);
        arg0.buck_minted_amount = arg0.buck_minted_amount - arg1;
        0x2::balance::split<T0>(&mut arg0.pool, v0)
    }

    public fun is_partner<T0, T1: drop>(arg0: &Reservoir<T0>) : bool {
        let v0 = FeeConfigKey{dummy_field: false};
        let v1 = 0x1::type_name::get<T1>();
        0x2::dynamic_field::exists_with_type<FeeConfigKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FeeConfig>>(&arg0.id, v0) && 0x2::vec_map::contains<0x1::type_name::TypeName, FeeConfig>(0x2::dynamic_field::borrow<FeeConfigKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FeeConfig>>(&arg0.id, v0), &v1)
    }

    public fun pool_balance<T0>(arg0: &Reservoir<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    public(friend) fun set_fee_config<T0, T1: drop>(arg0: &mut Reservoir<T0>, arg1: u64, arg2: u64) {
        let v0 = FeeConfigKey{dummy_field: false};
        let v1 = 0x1::type_name::get<T1>();
        if (0x2::dynamic_field::exists_with_type<FeeConfigKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FeeConfig>>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<FeeConfigKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FeeConfig>>(&mut arg0.id, v0);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, FeeConfig>(v2, &v1)) {
                let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, FeeConfig>(v2, &v1);
                v3.charge_fee_rate = arg1;
                v3.discharge_fee_rate = arg2;
            } else {
                let v4 = FeeConfig{
                    charge_fee_rate    : arg1,
                    discharge_fee_rate : arg2,
                };
                0x2::vec_map::insert<0x1::type_name::TypeName, FeeConfig>(v2, v1, v4);
            };
        } else {
            let v5 = 0x2::vec_map::empty<0x1::type_name::TypeName, FeeConfig>();
            let v6 = FeeConfig{
                charge_fee_rate    : arg1,
                discharge_fee_rate : arg2,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, FeeConfig>(&mut v5, v1, v6);
            0x2::dynamic_field::add<FeeConfigKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FeeConfig>>(&mut arg0.id, v0, v5);
        };
    }

    public(friend) fun update_fee_rate<T0>(arg0: &mut Reservoir<T0>, arg1: u64, arg2: u64) {
        arg0.charge_fee_rate = arg1;
        arg0.discharge_fee_rate = arg2;
    }

    // decompiled from Move bytecode v6
}

