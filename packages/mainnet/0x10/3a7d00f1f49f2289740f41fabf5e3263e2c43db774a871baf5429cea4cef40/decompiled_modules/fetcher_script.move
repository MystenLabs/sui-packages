module 0x103a7d00f1f49f2289740f41fabf5e3263e2c43db774a871baf5429cea4cef40::fetcher_script {
    struct FetchTicksResultEvent has copy, drop, store {
        ticks: vector<0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::tick::Tick>,
    }

    struct CalculatedSwapResultEvent has copy, drop, store {
        data: 0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::pool::CalculatedSwapResult,
    }

    struct FetchPositionsEvent has copy, drop, store {
        positions: vector<0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::position::PositionInfo>,
    }

    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::factory::PoolSimpleInfo>,
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

    public fun calculate_swap_result<T0, T1>(arg0: &0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) {
        let v0 = CalculatedSwapResultEvent{data: 0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3)};
        0x2::event::emit<CalculatedSwapResultEvent>(v0);
    }

    public fun fetch_pools(arg0: &0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::factory::Pools, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPoolsEvent{pools: 0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::factory::fetch_pools(arg0, arg1, arg2)};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    public fun fetch_position_fees<T0, T1>(arg0: &0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::config::GlobalConfig, arg1: &mut 0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::pool::Pool<T0, T1>, arg2: 0x2::object::ID) {
        let (v0, v1) = 0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::pool::calculate_and_update_fee<T0, T1>(arg0, arg1, arg2);
        let v2 = FetchPositionFeesEvent{
            position_id : arg2,
            fee_owned_a : v0,
            fee_owned_b : v1,
        };
        0x2::event::emit<FetchPositionFeesEvent>(v2);
    }

    public fun fetch_position_rewards<T0, T1>(arg0: &0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::config::GlobalConfig, arg1: &mut 0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = FetchPositionRewardsEvent{
            data        : 0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::pool::calculate_and_update_rewards<T0, T1>(arg0, arg1, arg2, arg3),
            position_id : arg2,
        };
        0x2::event::emit<FetchPositionRewardsEvent>(v0);
    }

    public fun fetch_positions<T0, T1>(arg0: &0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::pool::Pool<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPositionsEvent{positions: 0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::pool::fetch_positions<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchPositionsEvent>(v0);
    }

    public fun fetch_ticks<T0, T1>(arg0: &0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) {
        let v0 = FetchTicksResultEvent{ticks: 0x45a137f238cc1205e220a4997fc0a8312427064cfae441f8c6ca12bf712f6232::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchTicksResultEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

