module 0xffb4d59fc5c3340d623597f5695d48f44341b6116e5fdbe4b2675716914e436a::sequence_number {
    struct Registry has key {
        id: 0x2::object::UID,
        last_lottery: 0x1::option::Option<address>,
        next_sequence_number: u64,
        ranges: 0x2::table::Table<address, vector<u64>>,
    }

    public(friend) fun new(arg0: &mut Registry) : u64 {
        let v0 = arg0.next_sequence_number;
        arg0.next_sequence_number = v0 + 1;
        v0
    }

    public(friend) fun confirm_participation(arg0: &mut Registry, arg1: address) {
        if (0x1::option::is_none<address>(&arg0.last_lottery)) {
            let v0 = 0x1::vector::empty<u64>();
            let v1 = &mut v0;
            0x1::vector::push_back<u64>(v1, 0);
            0x1::vector::push_back<u64>(v1, arg0.next_sequence_number - 1);
            0x2::table::add<address, vector<u64>>(&mut arg0.ranges, arg1, v0);
        } else {
            let v2 = 0x1::vector::empty<u64>();
            let v3 = &mut v2;
            0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.ranges, *0x1::option::borrow<address>(&arg0.last_lottery)), 1) + 1);
            0x1::vector::push_back<u64>(v3, arg0.next_sequence_number - 1);
            0x2::table::add<address, vector<u64>>(&mut arg0.ranges, arg1, v2);
        };
        arg0.last_lottery = 0x1::option::some<address>(arg1);
    }

    public fun get_lottery_range(arg0: &Registry, arg1: address) : (u64, u64) {
        let v0 = 0x2::table::borrow<address, vector<u64>>(&arg0.ranges, arg1);
        (*0x1::vector::borrow<u64>(v0, 0), *0x1::vector::borrow<u64>(v0, 1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                   : 0x2::object::new(arg0),
            last_lottery         : 0x1::option::none<address>(),
            next_sequence_number : 0,
            ranges               : 0x2::table::new<address, vector<u64>>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    // decompiled from Move bytecode v6
}

