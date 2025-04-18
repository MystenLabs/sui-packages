module 0x397bef56ab0db2dd61d871ed50da7645151ccc2dd4fd11bd385484fd52260d6::fetcher_script {
    struct FetchTicksResultEvent has copy, drop, store {
        ticks: vector<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::tick::Tick>,
    }

    struct CalculatedSwapResultEvent has copy, drop, store {
        data: 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::CalculatedSwapResult,
    }

    struct FetchPositionsEvent has copy, drop, store {
        positions: vector<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::position::PositionInfo>,
    }

    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::factory::PoolSimpleInfo>,
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

    struct FetchPositionMagmaDistributionEvent has copy, drop, store {
        position_id: 0x2::object::ID,
        distribution: u64,
    }

    public entry fun calculate_swap_result<T0, T1>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64) {
        let v0 = CalculatedSwapResultEvent{data: 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3, arg4)};
        0x2::event::emit<CalculatedSwapResultEvent>(v0);
    }

    public entry fun fetch_pools(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::factory::Pools, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPoolsEvent{pools: 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::factory::fetch_pools(arg0, arg1, arg2)};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    public entry fun fetch_position_fees<T0, T1>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg2: 0x2::object::ID) {
        let (v0, v1) = 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::calculate_and_update_fee<T0, T1>(arg0, arg1, arg2);
        let v2 = FetchPositionFeesEvent{
            position_id : arg2,
            fee_owned_a : v0,
            fee_owned_b : v1,
        };
        0x2::event::emit<FetchPositionFeesEvent>(v2);
    }

    public entry fun fetch_position_magma_distribution<T0, T1>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = FetchPositionMagmaDistributionEvent{
            position_id  : arg2,
            distribution : 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::calculate_and_update_magma_distribution<T0, T1>(arg0, arg1, arg2),
        };
        0x2::event::emit<FetchPositionMagmaDistributionEvent>(v0);
    }

    public entry fun fetch_position_points<T0, T1>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = FetchPositionPointsEvent{
            position_id  : arg2,
            points_owned : 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::calculate_and_update_points<T0, T1>(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<FetchPositionPointsEvent>(v0);
    }

    public entry fun fetch_position_rewards<T0, T1>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = FetchPositionRewardsEvent{
            data        : 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::calculate_and_update_rewards<T0, T1>(arg0, arg1, arg2, arg3),
            position_id : arg2,
        };
        0x2::event::emit<FetchPositionRewardsEvent>(v0);
    }

    public entry fun fetch_positions<T0, T1>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPositionsEvent{positions: 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::fetch_positions<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchPositionsEvent>(v0);
    }

    public entry fun fetch_ticks<T0, T1>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) {
        let v0 = FetchTicksResultEvent{ticks: 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchTicksResultEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

