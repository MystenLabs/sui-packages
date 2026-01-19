module 0x368ad49e1886e899df4909ff0964ce4709b1d6009e481488cbb18a0f6c7435e9::fetcher_script {
    struct FetchTicksResultEvent has copy, drop, store {
        ticks: vector<0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::tick::Tick>,
    }

    struct CalculatedSwapResultEvent has copy, drop, store {
        data: 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::pool::CalculatedSwapResult,
    }

    struct FetchPositionsEvent has copy, drop, store {
        positions: vector<0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::position::PositionInfo>,
    }

    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::factory::PoolSimpleInfo>,
    }

    struct FetchPositionRewardsEvent has copy, drop, store {
        data: vector<u64>,
        position_id: 0x2::object::ID,
    }

    struct FetchPositionFeesEvent has copy, drop, store {
        position_id: 0x2::object::ID,
        fee_owned_a: u64,
        fee_owned_b: u64,
    }

    public fun calculate_swap_result<T0, T1>(arg0: &0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = CalculatedSwapResultEvent{data: 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3, arg4)};
        0x2::event::emit<CalculatedSwapResultEvent>(v0);
    }

    public fun fetch_pools(arg0: &0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::factory::Pools, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPoolsEvent{pools: 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::factory::fetch_pools(arg0, arg1, arg2)};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    public fun fetch_position_fees<T0, T1>(arg0: &0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::config::GlobalConfig, arg1: &mut 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::pool::Pool<T0, T1>, arg2: 0x2::object::ID) {
        let (v0, v1) = 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::pool::calculate_and_update_fee<T0, T1>(arg0, arg1, arg2);
        let v2 = FetchPositionFeesEvent{
            position_id : arg2,
            fee_owned_a : v0,
            fee_owned_b : v1,
        };
        0x2::event::emit<FetchPositionFeesEvent>(v2);
    }

    public fun fetch_position_rewards<T0, T1>(arg0: &0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::config::GlobalConfig, arg1: &mut 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = FetchPositionRewardsEvent{
            data        : 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::pool::calculate_and_update_rewards<T0, T1>(arg0, arg1, arg2, arg3),
            position_id : arg2,
        };
        0x2::event::emit<FetchPositionRewardsEvent>(v0);
    }

    public fun fetch_positions<T0, T1>(arg0: &0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::pool::Pool<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPositionsEvent{positions: 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::pool::fetch_positions<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchPositionsEvent>(v0);
    }

    public fun fetch_ticks<T0, T1>(arg0: &0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) {
        let v0 = FetchTicksResultEvent{ticks: 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchTicksResultEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

