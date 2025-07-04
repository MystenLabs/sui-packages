module 0xf16f79b13fbe2c509cf9e0078bbdcd824b4739da14dcedcc3b6386ab70b5d7de::fetcher_script {
    struct FetchTicksResultEvent has copy, drop, store {
        ticks: vector<0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::tick::Tick>,
    }

    struct CalculatedSwapResultEvent has copy, drop, store {
        data: 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::CalculatedSwapResult,
    }

    struct FetchPositionsEvent has copy, drop, store {
        positions: vector<0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::position::PositionInfo>,
    }

    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::factory::PoolSimpleInfo>,
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

    public entry fun fetch_pools(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::factory::Pools, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPoolsEvent{pools: 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::factory::fetch_pools(arg0, arg1, arg2)};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    public entry fun calculate_swap_result<T0, T1>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64) {
        let v0 = CalculatedSwapResultEvent{data: 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3, arg4)};
        0x2::event::emit<CalculatedSwapResultEvent>(v0);
    }

    public entry fun fetch_positions<T0, T1>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPositionsEvent{positions: 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::fetch_positions<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchPositionsEvent>(v0);
    }

    public entry fun fetch_ticks<T0, T1>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u32>, arg2: u64) {
        let v0 = FetchTicksResultEvent{ticks: 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchTicksResultEvent>(v0);
    }

    public entry fun fetch_position_fees<T0, T1>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg2: 0x2::object::ID) {
        let (v0, v1) = 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::calculate_and_update_fee<T0, T1>(arg0, arg1, arg2);
        let v2 = FetchPositionFeesEvent{
            position_id : arg2,
            fee_owned_a : v0,
            fee_owned_b : v1,
        };
        0x2::event::emit<FetchPositionFeesEvent>(v2);
    }

    public entry fun fetch_position_fullsail_distribution<T0, T1>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg2: 0x2::object::ID) {
        let v0 = FetchPositionFullsailDistributionEvent{
            position_id  : arg2,
            distribution : 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::calculate_and_update_fullsail_distribution<T0, T1>(arg0, arg1, arg2),
        };
        0x2::event::emit<FetchPositionFullsailDistributionEvent>(v0);
    }

    public entry fun fetch_position_points<T0, T1>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::rewarder::RewarderGlobalVault, arg2: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let v0 = FetchPositionPointsEvent{
            position_id  : arg3,
            points_owned : 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::calculate_and_update_points<T0, T1>(arg0, arg1, arg2, arg3, arg4),
        };
        0x2::event::emit<FetchPositionPointsEvent>(v0);
    }

    public entry fun fetch_position_rewards<T0, T1>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::rewarder::RewarderGlobalVault, arg2: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let v0 = FetchPositionRewardsEvent{
            data        : 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::calculate_and_update_rewards<T0, T1>(arg0, arg1, arg2, arg3, arg4),
            position_id : arg3,
        };
        0x2::event::emit<FetchPositionRewardsEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

