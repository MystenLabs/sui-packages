module 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fetcher {
    struct PendingReward has copy, drop {
        position: 0x2::object::ID,
        amount: u64,
    }

    public entry fun fetch_pending_reward(arg0: &0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg1: &0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::Position, arg2: &0x2::clock::Clock) {
        let v0 = PendingReward{
            position : 0x2::object::id<0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::Position>(arg1),
            amount   : 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::pending_reward(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::borrow_pool(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_pool_registry(arg0), 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::pool_idx(arg1)), arg1, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::total_alloc_point(arg0), 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::reward_per_sec(arg0), arg2),
        };
        0x2::event::emit<PendingReward>(v0);
    }

    // decompiled from Move bytecode v6
}

