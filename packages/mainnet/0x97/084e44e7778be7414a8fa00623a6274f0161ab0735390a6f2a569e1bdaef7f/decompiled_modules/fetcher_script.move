module 0x97084e44e7778be7414a8fa00623a6274f0161ab0735390a6f2a569e1bdaef7f::fetcher_script {
    struct FetchTicksResultEvent has copy, drop, store {
        ticks: vector<0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::tick::Tick>,
    }

    struct CalculatedSwapResultEvent has copy, drop, store {
        data: 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::CalculatedSwapResult,
    }

    struct FetchPositionsEvent has copy, drop, store {
        positions: vector<0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::position::PositionInfo>,
    }

    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::factory::PoolSimpleInfo>,
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

    struct FetchPositionPointsEvent has copy, drop, store {
        position_id: 0x2::object::ID,
        points_owned: u128,
    }

    public fun fetch_pools(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::factory::Pools, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPoolsEvent{pools: 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::factory::fetch_pools(arg0, arg1, arg2)};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    public fun calculate_swap_result<T0, T1>(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) {
        let v0 = CalculatedSwapResultEvent{data: 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3)};
        0x2::event::emit<CalculatedSwapResultEvent>(v0);
    }

    public fun fetch_positions<T0, T1>(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::Pool<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPositionsEvent{positions: 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::fetch_positions<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchPositionsEvent>(v0);
    }

    public fun fetch_ticks<T0, T1>(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) {
        let v0 = FetchTicksResultEvent{ticks: 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchTicksResultEvent>(v0);
    }

    public fun fetch_position_fees<T0, T1>(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg1: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::Pool<T0, T1>, arg2: 0x2::object::ID) {
        let (v0, v1) = 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::calculate_and_update_fee<T0, T1>(arg0, arg1, arg2);
        let v2 = FetchPositionFeesEvent{
            position_id : arg2,
            fee_owned_a : v0,
            fee_owned_b : v1,
        };
        0x2::event::emit<FetchPositionFeesEvent>(v2);
    }

    public fun fetch_position_points<T0, T1>(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg1: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = FetchPositionPointsEvent{
            position_id  : arg2,
            points_owned : 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::calculate_and_update_points<T0, T1>(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<FetchPositionPointsEvent>(v0);
    }

    public fun fetch_position_rewards<T0, T1>(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg1: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = FetchPositionRewardsEvent{
            data        : 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::calculate_and_update_rewards<T0, T1>(arg0, arg1, arg2, arg3),
            position_id : arg2,
        };
        0x2::event::emit<FetchPositionRewardsEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

