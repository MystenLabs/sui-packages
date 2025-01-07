module 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::fetcher {
    struct PendingReward has copy, drop {
        position: 0x2::object::ID,
        amount: u64,
    }

    public entry fun fetch_pending_reward(arg0: &0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position_registry::borrow_position(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_position_registry(arg0), arg1, arg2);
        let v1 = PendingReward{
            position : 0x2::object::id<0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::Position>(v0),
            amount   : 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::pending_reward(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::borrow_pool(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_pool_registry(arg0), arg1), v0, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::total_alloc_point(arg0), 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::reward_per_sec(arg0), arg3),
        };
        0x2::event::emit<PendingReward>(v1);
    }

    // decompiled from Move bytecode v6
}

