module 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::fetcher {
    struct PendingReward has copy, drop {
        position: 0x2::object::ID,
        amount: u64,
    }

    public entry fun fetch_pending_reward(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position_registry::borrow_position(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_position_registry(arg0), arg1, arg2);
        let v1 = PendingReward{
            position : 0x2::object::id<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position::Position>(v0),
            amount   : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::pending_reward(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::borrow_pool(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_pool_registry(arg0), arg1), v0, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::total_alloc_point(arg0), 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::reward_per_sec(arg0), arg3),
        };
        0x2::event::emit<PendingReward>(v1);
    }

    // decompiled from Move bytecode v6
}

