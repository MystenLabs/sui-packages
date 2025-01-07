module 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box {
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
        loop {
            if (v0 >= 0x1::vector::length<u64>(&arg1)) {
                break
            };
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

    public fun is_claimed<T0>(arg0: &Box<T0>) : bool {
        arg0.claimed
    }

    public(friend) fun new_box_key<T0>(arg0: address) : BoxKey<T0> {
        BoxKey<T0>{user_address: arg0}
    }

    public(friend) fun update_claim<T0>(arg0: &mut Box<T0>) {
        arg0.claimed = true;
    }

    // decompiled from Move bytecode v6
}

