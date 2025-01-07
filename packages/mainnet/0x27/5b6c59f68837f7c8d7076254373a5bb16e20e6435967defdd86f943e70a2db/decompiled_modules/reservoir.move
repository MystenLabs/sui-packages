module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::reservoir {
    struct Reservoir<phantom T0> has store, key {
        id: 0x2::object::UID,
        conversion_rate: u64,
        charge_fee_rate: u64,
        discharge_fee_rate: u64,
        pool: 0x2::balance::Balance<T0>,
        buck_minted_amount: u64,
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

    public fun conversion_rate<T0>(arg0: &Reservoir<T0>) : u64 {
        arg0.conversion_rate
    }

    public fun discharge_fee_rate<T0>(arg0: &Reservoir<T0>) : u64 {
        arg0.discharge_fee_rate
    }

    public(friend) fun handle_charge<T0>(arg0: &mut Reservoir<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(v0, arg0.conversion_rate, 1000000000);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::reservoir_events::emit_charge_reservoir<T0>(v0, v1);
        0x2::balance::join<T0>(&mut arg0.pool, arg1);
        arg0.buck_minted_amount = arg0.buck_minted_amount + v1;
        v1
    }

    public(friend) fun handle_discharge<T0>(arg0: &mut Reservoir<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg1, 1000000000, arg0.conversion_rate);
        assert!(v0 <= pool_balance<T0>(arg0), 0);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::reservoir_events::emit_discharge_reservoir<T0>(v0, arg1);
        arg0.buck_minted_amount = arg0.buck_minted_amount - arg1;
        0x2::balance::split<T0>(&mut arg0.pool, v0)
    }

    public fun pool_balance<T0>(arg0: &Reservoir<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    public(friend) fun update_fee_rate<T0>(arg0: &mut Reservoir<T0>, arg1: u64, arg2: u64) {
        arg0.charge_fee_rate = arg1;
        arg0.discharge_fee_rate = arg2;
    }

    // decompiled from Move bytecode v6
}

