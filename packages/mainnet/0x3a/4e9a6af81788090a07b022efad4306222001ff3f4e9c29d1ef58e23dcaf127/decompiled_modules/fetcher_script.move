module 0x3a4e9a6af81788090a07b022efad4306222001ff3f4e9c29d1ef58e23dcaf127::fetcher_script {
    struct FetchTicksResultEvent has copy, drop, store {
        ticks: vector<0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::tick::Tick>,
    }

    struct CalculatedSwapResultEvent has copy, drop, store {
        data: 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::CalculatedSwapResult,
    }

    struct FetchPositionsEvent has copy, drop, store {
        positions: vector<0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::position::PositionInfo>,
    }

    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::factory::PoolSimpleInfo>,
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

    public fun calculate_swap_result<T0, T1>(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = CalculatedSwapResultEvent{data: 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3, arg4)};
        0x2::event::emit<CalculatedSwapResultEvent>(v0);
    }

    public fun fetch_pools(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::factory::Pools, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPoolsEvent{pools: 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::factory::fetch_pools(arg0, arg1, arg2)};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    public fun fetch_position_fees<T0, T1>(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::config::GlobalConfig, arg1: &mut 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::Pool<T0, T1>, arg2: 0x2::object::ID) {
        let (v0, v1) = 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::calculate_and_update_fee<T0, T1>(arg0, arg1, arg2);
        let v2 = FetchPositionFeesEvent{
            position_id : arg2,
            fee_owned_a : v0,
            fee_owned_b : v1,
        };
        0x2::event::emit<FetchPositionFeesEvent>(v2);
    }

    public fun fetch_position_rewards<T0, T1>(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::config::GlobalConfig, arg1: &mut 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = FetchPositionRewardsEvent{
            data        : 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::calculate_and_update_rewards<T0, T1>(arg0, arg1, arg2, arg3),
            position_id : arg2,
        };
        0x2::event::emit<FetchPositionRewardsEvent>(v0);
    }

    public fun fetch_positions<T0, T1>(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::Pool<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPositionsEvent{positions: 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::fetch_positions<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchPositionsEvent>(v0);
    }

    public fun fetch_ticks<T0, T1>(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) {
        let v0 = FetchTicksResultEvent{ticks: 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchTicksResultEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

