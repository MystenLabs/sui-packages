module 0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::box {
    struct BoxKey<phantom T0> has copy, drop, store {
        user_address: address,
    }

    struct Box<phantom T0> has store, key {
        id: 0x2::object::UID,
        slots: vector<u64>,
        claimed: bool,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : Box<T0> {
        Box<T0>{
            id      : 0x2::object::new(arg0),
            slots   : 0x1::vector::empty<u64>(),
            claimed : false,
        }
    }

    public(friend) fun add_slots<T0>(arg0: &mut Box<T0>, arg1: vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x1::vector::push_back<u64>(&mut arg0.slots, *0x1::vector::borrow<u64>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun get_slots<T0>(arg0: &Box<T0>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.slots, arg1)
    }

    public fun get_total_slot<T0>(arg0: &Box<T0>) : u64 {
        0x1::vector::length<u64>(&arg0.slots)
    }

    public fun is_claimed<T0>(arg0: &0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::state::State, arg1: address) : bool {
        let v0 = new_box_key<T0>(arg1);
        assert!(0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::state::contain<BoxKey<T0>, Box<T0>>(arg0, v0), 1);
        0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::state::borrow<BoxKey<T0>, Box<T0>>(arg0, v0).claimed
    }

    public(friend) fun new_box_key<T0>(arg0: address) : BoxKey<T0> {
        BoxKey<T0>{user_address: arg0}
    }

    public fun update_claim<T0>(arg0: &mut 0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::state::State, arg1: address) {
        let v0 = new_box_key<T0>(arg1);
        assert!(0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::state::contain<BoxKey<T0>, Box<T0>>(arg0, v0), 1);
        0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::state::borrow_mut<BoxKey<T0>, Box<T0>>(arg0, v0).claimed = true;
    }

    // decompiled from Move bytecode v6
}

