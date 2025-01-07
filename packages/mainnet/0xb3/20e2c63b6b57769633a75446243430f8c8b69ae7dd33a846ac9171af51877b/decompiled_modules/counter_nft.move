module 0xb320e2c63b6b57769633a75446243430f8c8b69ae7dd33a846ac9171af51877b::counter_nft {
    struct Counter has key {
        id: 0x2::object::UID,
        count: u64,
    }

    entry fun burn(arg0: Counter) {
        let Counter {
            id    : v0,
            count : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun count(arg0: &Counter) : u64 {
        arg0.count
    }

    public fun get_vrf_input_and_increment(arg0: &mut Counter) : vector<u8> {
        let v0 = 0x2::object::id_bytes<Counter>(arg0);
        let v1 = count(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        increment(arg0);
        v0
    }

    fun increment(arg0: &mut Counter) {
        arg0.count = arg0.count + 1;
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id    : 0x2::object::new(arg0),
            count : 0,
        }
    }

    public fun transfer_to_sender(arg0: Counter, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Counter>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

