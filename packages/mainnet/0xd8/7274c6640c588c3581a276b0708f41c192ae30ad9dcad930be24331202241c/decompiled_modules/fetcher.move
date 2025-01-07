module 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::fetcher {
    struct PendingReward has copy, drop {
        amount: u64,
    }

    public entry fun fetch_pending_reward<T0, T1>(arg0: &0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State, arg1: &0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position, arg2: &0x2::clock::Clock) {
        let v0 = PendingReward{amount: 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::estimate_pending_reward<T0, T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::borrow_pool<T0, T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::borrow_pool_registry(arg0), 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::pool_idx(arg1)), arg1, arg2)};
        0x2::event::emit<PendingReward>(v0);
    }

    // decompiled from Move bytecode v6
}

