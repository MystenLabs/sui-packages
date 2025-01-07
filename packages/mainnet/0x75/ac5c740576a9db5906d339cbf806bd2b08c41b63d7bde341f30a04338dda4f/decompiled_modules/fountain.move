module 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain {
    struct SupplyEvent<phantom T0, phantom T1> has copy, drop {
        fountain_id: 0x2::object::ID,
        amount: u64,
    }

    struct LiquidateEvent<phantom T0, phantom T1> has copy, drop {
        fountain_id: 0x2::object::ID,
        strap_address: address,
        debt_amount: u64,
    }

    struct StakeEvent<phantom T0, phantom T1> has copy, drop {
        fountain_id: 0x2::object::ID,
        strap_address: address,
        debt_amount: u64,
    }

    struct UnstakeEvent<phantom T0, phantom T1> has copy, drop {
        fountain_id: 0x2::object::ID,
        strap_address: address,
        debt_amount: u64,
    }

    struct ClaimEvent<phantom T0, phantom T1> has copy, drop {
        fountain_id: 0x2::object::ID,
        strap_address: address,
        reward_amount: u64,
    }

    struct UpdateFlowRateEvent<phantom T0, phantom T1> has copy, drop {
        fountain_id: 0x2::object::ID,
        flow_amount: u64,
        flow_interval: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        fountain_id: 0x2::object::ID,
    }

    struct Fountain<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        source: 0x2::balance::Balance<T1>,
        flow_amount: u64,
        flow_interval: u64,
        pool: 0x2::balance::Balance<T1>,
        total_debt_amount: u64,
        strap_table: 0x2::table::Table<address, StrapData<T0>>,
        surplus_table: 0x2::table::Table<0x2::object::ID, SurplusData<T0, T1>>,
        cumulative_unit: u128,
        latest_release_time: u64,
    }

    struct StrapData<phantom T0> has store {
        strap: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>,
        start_unit: u128,
        proof_id: 0x2::object::ID,
        debt_amount: u64,
    }

    struct SurplusData<phantom T0, phantom T1> has store {
        strap: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>,
        surplus: 0x2::balance::Balance<T1>,
    }

    struct StakeProof<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        fountain_id: 0x2::object::ID,
        strap_address: address,
    }

    fun assert_valid_admin_cap<T0, T1>(arg0: &Fountain<T0, T1>, arg1: &AdminCap) {
        assert!(0x2::object::id<Fountain<T0, T1>>(arg0) == arg1.fountain_id, 2);
    }

    fun assert_valid_proof<T0, T1>(arg0: &Fountain<T0, T1>, arg1: &StakeProof<T0, T1>) {
        assert!(0x2::object::id<Fountain<T0, T1>>(arg0) == fountain_id<T0, T1>(arg1), 1);
    }

    fun assert_valid_strap_to_stake<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>) {
        assert!(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::bottle_exists<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::get_address<T0>(arg1)), 3);
    }

    fun borrow_strap_data_mut<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: address) : &mut StrapData<T0> {
        0x2::table::borrow_mut<address, StrapData<T0>>(&mut arg0.strap_table, arg1)
    }

    public fun bottle_exists<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: address) : bool {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::bottle_exists<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0), arg1)
    }

    public fun claim<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut StakeProof<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_proof<T0, T1>(arg0, arg2);
        source_to_pool<T0, T1>(arg0, arg1);
        let v0 = strap_address<T0, T1>(arg2);
        if (strap_data_exists<T0, T1>(arg0, v0)) {
            claim_internal<T0, T1>(arg0, arg1, v0, arg3)
        } else {
            let v2 = 0x2::balance::withdraw_all<T1>(&mut 0x2::table::borrow_mut<0x2::object::ID, SurplusData<T0, T1>>(&mut arg0.surplus_table, 0x2::object::id<StakeProof<T0, T1>>(arg2)).surplus);
            let v3 = ClaimEvent<T0, T1>{
                fountain_id   : 0x2::object::id<Fountain<T0, T1>>(arg0),
                strap_address : v0,
                reward_amount : 0x2::balance::value<T1>(&v2),
            };
            0x2::event::emit<ClaimEvent<T0, T1>>(v3);
            0x2::coin::from_balance<T1>(v2, arg3)
        }
    }

    fun claim_internal<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = get_reward_amount<T0, T1>(arg0, arg2, 0x2::clock::timestamp_ms(arg1));
        let v1 = cumulative_unit<T0, T1>(arg0);
        let v2 = borrow_strap_data_mut<T0, T1>(arg0, arg2);
        v2.start_unit = v1;
        let v3 = ClaimEvent<T0, T1>{
            fountain_id   : 0x2::object::id<Fountain<T0, T1>>(arg0),
            strap_address : arg2,
            reward_amount : v0,
        };
        0x2::event::emit<ClaimEvent<T0, T1>>(v3);
        0x2::coin::take<T1>(&mut arg0.pool, v0, arg3)
    }

    fun collect_resource<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg1);
        if (v0 > 0) {
            0x2::balance::join<T1>(&mut arg0.pool, arg1);
            arg0.cumulative_unit = cumulative_unit<T0, T1>(arg0) + distribution_precision() * (v0 as u128) / (total_debt_amount<T0, T1>(arg0) as u128);
        } else {
            0x2::balance::destroy_zero<T1>(arg1);
        };
    }

    public fun create<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Fountain<T0, T1>{
            id                  : 0x2::object::new(arg3),
            source              : 0x2::balance::zero<T1>(),
            flow_amount         : arg0,
            flow_interval       : arg1,
            pool                : 0x2::balance::zero<T1>(),
            total_debt_amount   : 0,
            strap_table         : 0x2::table::new<address, StrapData<T0>>(arg3),
            surplus_table       : 0x2::table::new<0x2::object::ID, SurplusData<T0, T1>>(arg3),
            cumulative_unit     : 0,
            latest_release_time : arg2,
        };
        0x2::transfer::share_object<Fountain<T0, T1>>(v0);
        AdminCap{
            id          : 0x2::object::new(arg3),
            fountain_id : 0x2::object::id<Fountain<T0, T1>>(&v0),
        }
    }

    entry fun create_<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun cumulative_unit<T0, T1>(arg0: &Fountain<T0, T1>) : u128 {
        arg0.cumulative_unit
    }

    public fun distribution_precision() : u128 {
        18446744073709551616
    }

    public fun flow_rate<T0, T1>(arg0: &Fountain<T0, T1>) : (u64, u64) {
        (arg0.flow_amount, arg0.flow_interval)
    }

    public fun fountain_id<T0, T1>(arg0: &StakeProof<T0, T1>) : 0x2::object::ID {
        arg0.fountain_id
    }

    public fun get_raw_debt<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: address) : u64 {
        let (_, v1) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_raw_info_by_debator(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::borrow_bottle_table<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0)), arg1);
        v1
    }

    public fun get_reward_amount<T0, T1>(arg0: &Fountain<T0, T1>, arg1: address, arg2: u64) : u64 {
        let v0 = 0x2::table::borrow<address, StrapData<T0>>(&arg0.strap_table, arg1);
        mul_and_div_u128(v0.debt_amount, cumulative_unit<T0, T1>(arg0) + (get_virtual_released_amount<T0, T1>(arg0, arg2) as u128) * distribution_precision() / (total_debt_amount<T0, T1>(arg0) as u128) - start_unit<T0>(v0), distribution_precision())
    }

    public fun get_virtual_released_amount<T0, T1>(arg0: &Fountain<T0, T1>, arg1: u64) : u64 {
        let v0 = latest_release_time<T0, T1>(arg0);
        if (arg1 > v0) {
            let (v2, v3) = flow_rate<T0, T1>(arg0);
            let v4 = mul_and_div(v2, arg1 - v0, v3);
            let v5 = v4;
            let v6 = source_balance<T0, T1>(arg0);
            if (v4 > v6) {
                v5 = v6;
            };
            v5
        } else {
            0
        }
    }

    public fun latest_release_time<T0, T1>(arg0: &Fountain<T0, T1>) : u64 {
        arg0.latest_release_time
    }

    public fun liquidate<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (bottle_exists<T0>(arg1, arg3)) {
            return
        };
        let v0 = claim_internal<T0, T1>(arg0, arg2, arg3, arg4);
        let StrapData {
            strap       : v1,
            start_unit  : _,
            proof_id    : v3,
            debt_amount : v4,
        } = 0x2::table::remove<address, StrapData<T0>>(&mut arg0.strap_table, arg3);
        arg0.total_debt_amount = total_debt_amount<T0, T1>(arg0) - v4;
        let v5 = SurplusData<T0, T1>{
            strap   : v1,
            surplus : 0x2::coin::into_balance<T1>(v0),
        };
        0x2::table::add<0x2::object::ID, SurplusData<T0, T1>>(&mut arg0.surplus_table, v3, v5);
        let v6 = LiquidateEvent<T0, T1>{
            fountain_id   : 0x2::object::id<Fountain<T0, T1>>(arg0),
            strap_address : arg3,
            debt_amount   : v4,
        };
        0x2::event::emit<LiquidateEvent<T0, T1>>(v6);
    }

    fun mul_and_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun mul_and_div_u128(arg0: u64, arg1: u128, arg2: u128) : u64 {
        assert!(arg2 > 0, 0);
        (((arg0 as u128) * arg1 / arg2) as u64)
    }

    public fun pool_balance<T0, T1>(arg0: &Fountain<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.pool)
    }

    fun release_resource<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = latest_release_time<T0, T1>(arg0);
        if (v0 > v1) {
            let (v3, v4) = flow_rate<T0, T1>(arg0);
            let v5 = mul_and_div(v3, v0 - v1, v4);
            let v6 = v5;
            let v7 = source_balance<T0, T1>(arg0);
            if (v5 > v7) {
                v6 = v7;
            };
            arg0.latest_release_time = v0;
            0x2::balance::split<T1>(&mut arg0.source, v6)
        } else {
            0x2::balance::zero<T1>()
        }
    }

    public fun source_balance<T0, T1>(arg0: &Fountain<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.source)
    }

    fun source_to_pool<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: &0x2::clock::Clock) {
        if (source_balance<T0, T1>(arg0) > 0) {
            let v0 = release_resource<T0, T1>(arg0, arg1);
            collect_resource<T0, T1>(arg0, v0);
        } else {
            let v1 = 0x2::clock::timestamp_ms(arg1);
            if (v1 > latest_release_time<T0, T1>(arg0)) {
                arg0.latest_release_time = v1;
            };
        };
    }

    public fun stake<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0x2::clock::Clock, arg3: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>, arg4: &mut 0x2::tx_context::TxContext) : StakeProof<T0, T1> {
        assert_valid_strap_to_stake<T0>(arg1, &arg3);
        source_to_pool<T0, T1>(arg0, arg2);
        let v0 = get_raw_debt<T0>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::get_address<T0>(&arg3));
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::get_address<T0>(&arg3);
        let v2 = StakeProof<T0, T1>{
            id            : 0x2::object::new(arg4),
            fountain_id   : 0x2::object::id<Fountain<T0, T1>>(arg0),
            strap_address : v1,
        };
        let v3 = StakeEvent<T0, T1>{
            fountain_id   : 0x2::object::id<Fountain<T0, T1>>(arg0),
            strap_address : v1,
            debt_amount   : v0,
        };
        0x2::event::emit<StakeEvent<T0, T1>>(v3);
        let v4 = StrapData<T0>{
            strap       : arg3,
            start_unit  : cumulative_unit<T0, T1>(arg0),
            proof_id    : 0x2::object::id<StakeProof<T0, T1>>(&v2),
            debt_amount : v0,
        };
        0x2::table::add<address, StrapData<T0>>(&mut arg0.strap_table, v1, v4);
        arg0.total_debt_amount = total_debt_amount<T0, T1>(arg0) + v0;
        v2
    }

    public fun start_unit<T0>(arg0: &StrapData<T0>) : u128 {
        arg0.start_unit
    }

    public fun strap_address<T0, T1>(arg0: &StakeProof<T0, T1>) : address {
        arg0.strap_address
    }

    public fun strap_data_exists<T0, T1>(arg0: &Fountain<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, StrapData<T0>>(&arg0.strap_table, arg1)
    }

    public fun supply<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>) {
        source_to_pool<T0, T1>(arg0, arg1);
        0x2::coin::put<T1>(&mut arg0.source, arg2);
        let v0 = SupplyEvent<T0, T1>{
            fountain_id : 0x2::object::id<Fountain<T0, T1>>(arg0),
            amount      : 0x2::coin::value<T1>(&arg2),
        };
        0x2::event::emit<SupplyEvent<T0, T1>>(v0);
    }

    public fun total_debt_amount<T0, T1>(arg0: &Fountain<T0, T1>) : u64 {
        arg0.total_debt_amount
    }

    public fun unstake<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: &0x2::clock::Clock, arg2: StakeProof<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>, 0x2::coin::Coin<T1>) {
        assert_valid_proof<T0, T1>(arg0, &arg2);
        source_to_pool<T0, T1>(arg0, arg1);
        let StakeProof {
            id            : v0,
            fountain_id   : _,
            strap_address : v2,
        } = arg2;
        let v3 = v0;
        0x2::object::delete(v3);
        if (strap_data_exists<T0, T1>(arg0, v2)) {
            let v6 = claim_internal<T0, T1>(arg0, arg1, v2, arg3);
            let StrapData {
                strap       : v7,
                start_unit  : _,
                proof_id    : _,
                debt_amount : v10,
            } = 0x2::table::remove<address, StrapData<T0>>(&mut arg0.strap_table, v2);
            arg0.total_debt_amount = total_debt_amount<T0, T1>(arg0) - v10;
            let v11 = UnstakeEvent<T0, T1>{
                fountain_id   : 0x2::object::id<Fountain<T0, T1>>(arg0),
                strap_address : v2,
                debt_amount   : v10,
            };
            0x2::event::emit<UnstakeEvent<T0, T1>>(v11);
            (v7, v6)
        } else {
            let SurplusData {
                strap   : v12,
                surplus : v13,
            } = 0x2::table::remove<0x2::object::ID, SurplusData<T0, T1>>(&mut arg0.surplus_table, 0x2::object::uid_to_inner(&v3));
            (v12, 0x2::coin::from_balance<T1>(v13, arg3))
        }
    }

    public fun update_flow_rate<T0, T1>(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut Fountain<T0, T1>, arg3: u64, arg4: u64) {
        assert_valid_admin_cap<T0, T1>(arg2, arg0);
        source_to_pool<T0, T1>(arg2, arg1);
        arg2.flow_amount = arg3;
        arg2.flow_interval = arg4;
        let v0 = UpdateFlowRateEvent<T0, T1>{
            fountain_id   : 0x2::object::id<Fountain<T0, T1>>(arg2),
            flow_amount   : arg3,
            flow_interval : arg4,
        };
        0x2::event::emit<UpdateFlowRateEvent<T0, T1>>(v0);
    }

    public fun withdraw_from_source_to<T0, T1>(arg0: &AdminCap, arg1: &mut Fountain<T0, T1>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_admin_cap<T0, T1>(arg1, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.source, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

