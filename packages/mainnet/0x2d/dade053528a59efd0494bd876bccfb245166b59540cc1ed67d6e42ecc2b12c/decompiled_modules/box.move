module 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box {
    struct BoxKey<phantom T0> has copy, drop, store {
        user_address: address,
    }

    struct Box<phantom T0> has store, key {
        id: 0x2::object::UID,
        slots: vector<u64>,
        pandorian_box_ids: vector<0x2::object::ID>,
        claimed: bool,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : Box<T0> {
        Box<T0>{
            id                : 0x2::object::new(arg0),
            slots             : 0x1::vector::empty<u64>(),
            pandorian_box_ids : 0x1::vector::empty<0x2::object::ID>(),
            claimed           : false,
        }
    }

    public(friend) fun add_pandorian_boxs<T0>(arg0: &mut Box<T0>, arg1: vector<0x2::object::ID>) {
        let v0 = 0;
        loop {
            if (v0 >= 0x1::vector::length<0x2::object::ID>(&arg1)) {
                break
            };
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.pandorian_box_ids, *0x1::vector::borrow<0x2::object::ID>(&arg1, v0));
            v0 = v0 + 1;
        };
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

    public fun is_matched_pandorian_box_ids<T0>(arg0: &Box<T0>, arg1: vector<0x2::object::ID>) : bool {
        let v0 = &arg0.pandorian_box_ids;
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg1);
        let v2 = true;
        if (0x1::vector::length<0x2::object::ID>(v0) != v1) {
            return false
        };
        let v3 = 0;
        while (v3 < v1) {
            if (!0x1::vector::contains<0x2::object::ID>(v0, 0x1::vector::borrow<0x2::object::ID>(&arg1, v3))) {
                v2 = false;
                break
            };
            v3 = v3 + 1;
        };
        v2
    }

    public(friend) fun new_box_key<T0>(arg0: address) : BoxKey<T0> {
        BoxKey<T0>{user_address: arg0}
    }

    public(friend) fun update_claim<T0>(arg0: &mut Box<T0>) {
        arg0.claimed = true;
    }

    // decompiled from Move bytecode v6
}

