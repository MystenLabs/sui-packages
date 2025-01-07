module 0x453940ee31f09d3a4def2928c692a5c51717127aafea6b5df4b48211d30208a2::fetcher_script {
    struct FetchTicksResultEvent has copy, drop, store {
        ticks: vector<0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::tick::Tick>,
    }

    struct CalculatedSwapResultEvent has copy, drop, store {
        data: 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::pool::CalculatedSwapResult,
    }

    struct FetchPositionsEvent has copy, drop, store {
        positions: vector<0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::position::PositionInfo>,
    }

    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::factory::PoolSimpleInfo>,
    }

    public entry fun calculate_swap_result<T0, T1>(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) {
        let v0 = CalculatedSwapResultEvent{data: 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3)};
        0x2::event::emit<CalculatedSwapResultEvent>(v0);
    }

    public entry fun fetch_pools(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::factory::Pools, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPoolsEvent{pools: 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::factory::fetch_pools(arg0, arg1, arg2)};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    public entry fun fetch_positions<T0, T1>(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::pool::Pool<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = FetchPositionsEvent{positions: 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::pool::fetch_positions<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchPositionsEvent>(v0);
    }

    public entry fun fetch_ticks<T0, T1>(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) {
        let v0 = FetchTicksResultEvent{ticks: 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<FetchTicksResultEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

