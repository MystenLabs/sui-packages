module 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house {
    struct StakedHouseCoin<phantom T0> has drop {
        dummy_field: bool,
    }

    struct PoolDebt<phantom T0> has drop {
        dummy_field: bool,
    }

    struct HouseDebt<phantom T0> has drop {
        dummy_field: bool,
    }

    struct House<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<StakedHouseCoin<T0>>,
        pool: 0x2::balance::Balance<T0>,
        pipe_debt: 0x2::balance::Supply<PoolDebt<T0>>,
        house_pool: 0x2::balance::Balance<T0>,
        house_pipe_debt: 0x2::balance::Supply<HouseDebt<T0>>,
        voucher_pool: 0x2::balance::Balance<T0>,
        max_supply: u64,
    }

    struct StakeEvent<phantom T0> has copy, drop {
        user: address,
        amount: u64,
        s_coin_amount: u64,
    }

    struct WithdrawStakeEvent<phantom T0> has copy, drop {
        user: address,
        amount: u64,
        s_coin_amount: u64,
    }

    struct JoinHouseEvent<phantom T0> has copy, drop {
        amount: u64,
        fee_taken: 0x1::option::Option<u64>,
    }

    struct SplitHouseEvent<phantom T0> has copy, drop {
        amount: u64,
        fee_reimbursed_amount: 0x1::option::Option<u64>,
    }

    public(friend) fun join<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = JoinHouseEvent<T0>{
            amount    : 0x2::balance::value<T0>(&arg1),
            fee_taken : 0x1::option::none<u64>(),
        };
        0x2::event::emit<JoinHouseEvent<T0>>(v0);
        0x2::balance::join<T0>(&mut arg0.pool, arg1);
    }

    public(friend) fun split<T0>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 <= max_risk<T0>(arg0), 0);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.pool), 1);
        let v0 = SplitHouseEvent<T0>{
            amount                : arg1,
            fee_reimbursed_amount : 0x1::option::none<u64>(),
        };
        0x2::event::emit<SplitHouseEvent<T0>>(v0);
        0x2::balance::split<T0>(&mut arg0.pool, arg1)
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : House<T0> {
        let v0 = StakedHouseCoin<T0>{dummy_field: false};
        let v1 = PoolDebt<T0>{dummy_field: false};
        let v2 = HouseDebt<T0>{dummy_field: false};
        House<T0>{
            id              : 0x2::object::new(arg0),
            supply          : 0x2::balance::create_supply<StakedHouseCoin<T0>>(v0),
            pool            : 0x2::balance::zero<T0>(),
            pipe_debt       : 0x2::balance::create_supply<PoolDebt<T0>>(v1),
            house_pool      : 0x2::balance::zero<T0>(),
            house_pipe_debt : 0x2::balance::create_supply<HouseDebt<T0>>(v2),
            voucher_pool    : 0x2::balance::zero<T0>(),
            max_supply      : 500000000000000,
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<StakedHouseCoin<T0>> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = total_pool_balance<T0>(arg0);
        assert!(v0 + v1 <= arg0.max_supply, 4);
        let v2 = 0x2::balance::supply_value<StakedHouseCoin<T0>>(&arg0.supply);
        0x2::balance::join<T0>(&mut arg0.pool, arg1);
        if (v2 == 0 && v1 == 0) {
            let v3 = StakeEvent<T0>{
                user          : 0x2::tx_context::sender(arg2),
                amount        : v0,
                s_coin_amount : v0,
            };
            0x2::event::emit<StakeEvent<T0>>(v3);
            return 0x2::coin::from_balance<StakedHouseCoin<T0>>(0x2::balance::increase_supply<StakedHouseCoin<T0>>(&mut arg0.supply, v0), arg2)
        };
        assert!(v1 != 0, 2);
        let v4 = (((v0 as u128) * (v2 as u128) / (v1 as u128)) as u64);
        assert!(v4 > 0, 5);
        let v5 = StakeEvent<T0>{
            user          : 0x2::tx_context::sender(arg2),
            amount        : v0,
            s_coin_amount : v4,
        };
        0x2::event::emit<StakeEvent<T0>>(v5);
        0x2::coin::from_balance<StakedHouseCoin<T0>>(0x2::balance::increase_supply<StakedHouseCoin<T0>>(&mut arg0.supply, v4), arg2)
    }

    public(friend) fun deposit_house_pool<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.house_pool, arg1);
    }

    public fun fee_rate() : u64 {
        300000
    }

    public fun house_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.house_pool)
    }

    public fun house_metadata<T0>(arg0: &House<T0>) : (u64, u64, u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.pool), 0x2::balance::value<T0>(&arg0.voucher_pool), 0x2::balance::supply_value<StakedHouseCoin<T0>>(&arg0.supply), 0x2::balance::value<T0>(&arg0.house_pool), 0x2::balance::supply_value<PoolDebt<T0>>(&arg0.pipe_debt), 0x2::balance::supply_value<HouseDebt<T0>>(&arg0.house_pipe_debt))
    }

    public(friend) fun inject_pool<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.pool, arg1);
    }

    public(friend) fun join_from_pipe<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<PoolDebt<T0>>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<HouseDebt<T0>>) {
        0x2::balance::join<T0>(&mut arg0.pool, arg1);
        0x2::balance::decrease_supply<PoolDebt<T0>>(&mut arg0.pipe_debt, arg2);
        0x2::balance::join<T0>(&mut arg0.house_pool, arg3);
        0x2::balance::decrease_supply<HouseDebt<T0>>(&mut arg0.house_pipe_debt, arg4);
    }

    public(friend) fun join_with_fee<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_rate(0x2::balance::value<T0>(&arg1), 300000);
        let v1 = JoinHouseEvent<T0>{
            amount    : 0x2::balance::value<T0>(&arg1),
            fee_taken : 0x1::option::some<u64>(v0),
        };
        0x2::event::emit<JoinHouseEvent<T0>>(v1);
        0x2::balance::join<T0>(&mut arg0.house_pool, 0x2::balance::split<T0>(&mut arg1, v0));
        0x2::balance::join<T0>(&mut arg0.pool, arg1);
    }

    public fun max_risk<T0>(arg0: &House<T0>) : u64 {
        total_pool_balance<T0>(arg0) / 10
    }

    public fun pool_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    public fun pool_changes(arg0: u64) : (u64, u64) {
        let v0 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_rate(arg0, 300000);
        (arg0 - v0, v0)
    }

    public(friend) fun redeem<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<StakedHouseCoin<T0>>, arg2: address) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<StakedHouseCoin<T0>>(&arg1);
        0x2::balance::decrease_supply<StakedHouseCoin<T0>>(&mut arg0.supply, arg1);
        let v1 = (((v0 as u128) * (total_pool_balance<T0>(arg0) as u128) * 100 / (0x2::balance::supply_value<StakedHouseCoin<T0>>(&arg0.supply) as u128)) as u64) / 100;
        let v2 = WithdrawStakeEvent<T0>{
            user          : arg2,
            amount        : v1,
            s_coin_amount : v0,
        };
        0x2::event::emit<WithdrawStakeEvent<T0>>(v2);
        0x2::balance::split<T0>(&mut arg0.pool, v1)
    }

    public(friend) fun set_max_supply<T0>(arg0: &mut House<T0>, arg1: u64) {
        arg0.max_supply = arg1;
    }

    public(friend) fun split_for_pipe<T0>(arg0: &mut House<T0>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<PoolDebt<T0>>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<HouseDebt<T0>>) {
        assert!(0x2::balance::value<T0>(&arg0.pool) >= arg1, 1);
        assert!(0x2::balance::value<T0>(&arg0.house_pool) >= arg2, 3);
        (0x2::balance::split<T0>(&mut arg0.pool, arg1), 0x2::balance::increase_supply<PoolDebt<T0>>(&mut arg0.pipe_debt, arg1), 0x2::balance::split<T0>(&mut arg0.house_pool, arg2), 0x2::balance::increase_supply<HouseDebt<T0>>(&mut arg0.house_pipe_debt, arg2))
    }

    public(friend) fun split_for_voucher<T0>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.voucher_pool, arg1)
    }

    public(friend) fun split_with_reimbursement<T0>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 <= max_risk<T0>(arg0), 0);
        let v0 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_rate(arg1, 300000);
        assert!(v0 <= 0x2::balance::value<T0>(&arg0.house_pool), 3);
        0x2::balance::join<T0>(&mut arg0.pool, 0x2::balance::split<T0>(&mut arg0.house_pool, v0));
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.pool), 1);
        let v1 = SplitHouseEvent<T0>{
            amount                : arg1,
            fee_reimbursed_amount : 0x1::option::some<u64>(v0),
        };
        0x2::event::emit<SplitHouseEvent<T0>>(v1);
        0x2::balance::split<T0>(&mut arg0.pool, arg1)
    }

    public fun total_house_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.house_pool) + 0x2::balance::supply_value<HouseDebt<T0>>(&arg0.house_pipe_debt)
    }

    public fun total_pool_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool) + 0x2::balance::supply_value<PoolDebt<T0>>(&arg0.pipe_debt)
    }

    public(friend) fun voucher_deposit<T0>(arg0: &mut House<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.voucher_pool, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun withdraw_house_pool<T0>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.house_pool, arg1)
    }

    // decompiled from Move bytecode v6
}

