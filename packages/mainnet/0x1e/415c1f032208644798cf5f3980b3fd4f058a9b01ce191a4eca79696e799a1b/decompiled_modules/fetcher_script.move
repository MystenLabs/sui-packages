module 0x1e415c1f032208644798cf5f3980b3fd4f058a9b01ce191a4eca79696e799a1b::fetcher_script {
    struct FetchTicksResultEvent has copy, drop, store {
        ticks: vector<0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::tick::Tick>,
    }

    struct CalculatedSwapResultEvent has copy, drop, store {
        data: 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::CalculatedSwapResult,
    }

    struct FetchPositionsEvent has copy, drop, store {
        positions: vector<0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::position::PositionInfo>,
    }

    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::factory::PoolSimpleInfo>,
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

    struct FetchPositionFullsailDistributionEvent has copy, drop, store {
        position_id: 0x2::object::ID,
        distribution: u64,
    }

    public entry fun fetch_pools(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::factory::Pools, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPoolsEvent{pools: 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::factory::fetch_pools(arg0, arg1, arg2)};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    public entry fun calculate_swap_result<T0, T1>(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg1: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64) {
        let v0 = CalculatedSwapResultEvent{data: 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3, arg4)};
        0x2::event::emit<CalculatedSwapResultEvent>(v0);
    }

    public entry fun fetch_positions<T0, T1>(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::Pool<T0, T1>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPositionsEvent{positions: 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::fetch_positions<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchPositionsEvent>(v0);
    }

    public entry fun fetch_ticks<T0, T1>(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u32>, arg2: u64) {
        let v0 = FetchTicksResultEvent{ticks: 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchTicksResultEvent>(v0);
    }

    public entry fun fetch_position_fees<T0, T1>(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg1: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::Pool<T0, T1>, arg2: 0x2::object::ID) {
        let (v0, v1) = 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::calculate_and_update_fee<T0, T1>(arg0, arg1, arg2);
        let v2 = FetchPositionFeesEvent{
            position_id : arg2,
            fee_owned_a : v0,
            fee_owned_b : v1,
        };
        0x2::event::emit<FetchPositionFeesEvent>(v2);
    }

    public entry fun fetch_position_fullsail_distribution<T0, T1>(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg1: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::Pool<T0, T1>, arg2: 0x2::object::ID) {
        let v0 = FetchPositionFullsailDistributionEvent{
            position_id  : arg2,
            distribution : 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::calculate_and_update_fullsail_distribution<T0, T1>(arg0, arg1, arg2),
        };
        0x2::event::emit<FetchPositionFullsailDistributionEvent>(v0);
    }

    public entry fun fetch_position_points<T0, T1>(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg1: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::rewarder::RewarderGlobalVault, arg2: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let v0 = FetchPositionPointsEvent{
            position_id  : arg3,
            points_owned : 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::calculate_and_update_points<T0, T1>(arg0, arg1, arg2, arg3, arg4),
        };
        0x2::event::emit<FetchPositionPointsEvent>(v0);
    }

    public entry fun fetch_position_rewards<T0, T1>(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg1: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::rewarder::RewarderGlobalVault, arg2: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let v0 = FetchPositionRewardsEvent{
            data        : 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::pool::calculate_and_update_rewards<T0, T1>(arg0, arg1, arg2, arg3, arg4),
            position_id : arg3,
        };
        0x2::event::emit<FetchPositionRewardsEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

