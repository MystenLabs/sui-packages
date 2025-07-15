module 0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::fetcher_script {
    struct FetchTicksResultEvent has copy, drop, store {
        ticks: vector<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::Tick>,
    }

    struct CalculatedSwapResultEvent has copy, drop, store {
        data: 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::CalculatedSwapResult,
    }

    struct FetchPositionsEvent has copy, drop, store {
        positions: vector<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::PositionInfo>,
    }

    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::factory::PoolSimpleInfo>,
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

    public fun calculate_swap_result<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) {
        let v0 = CalculatedSwapResultEvent{data: 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3)};
        0x2::event::emit<CalculatedSwapResultEvent>(v0);
    }

    public fun fetch_pools(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::factory::Pools, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPoolsEvent{pools: 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::factory::fetch_pools(arg0, arg1, arg2)};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    public fun fetch_position_fees<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: 0x2::object::ID) {
        let (v0, v1) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::calculate_and_update_fee<T0, T1>(arg0, arg1, arg2);
        let v2 = FetchPositionFeesEvent{
            position_id : arg2,
            fee_owned_a : v0,
            fee_owned_b : v1,
        };
        0x2::event::emit<FetchPositionFeesEvent>(v2);
    }

    public fun fetch_position_points<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = FetchPositionPointsEvent{
            position_id  : arg2,
            points_owned : 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::calculate_and_update_points<T0, T1>(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<FetchPositionPointsEvent>(v0);
    }

    public fun fetch_position_rewards<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = FetchPositionRewardsEvent{
            data        : 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::calculate_and_update_rewards<T0, T1>(arg0, arg1, arg2, arg3),
            position_id : arg2,
        };
        0x2::event::emit<FetchPositionRewardsEvent>(v0);
    }

    public fun fetch_positions<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPositionsEvent{positions: 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::fetch_positions<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchPositionsEvent>(v0);
    }

    public fun fetch_ticks<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) {
        let v0 = FetchTicksResultEvent{ticks: 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchTicksResultEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

