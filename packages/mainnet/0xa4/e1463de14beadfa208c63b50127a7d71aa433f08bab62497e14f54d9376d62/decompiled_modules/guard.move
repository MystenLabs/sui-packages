module 0xdd017b83eb244567c53538ce49b0855c28e1465412444203a87c4eea480655f8::guard {
    struct Guard has key {
        id: 0x2::object::UID,
        seq: u64,
        owner: address,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Guard{
            id    : 0x2::object::new(arg0),
            seq   : 0,
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Guard>(v0);
    }

    public fun consume(arg0: &mut Guard, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg3, 2);
        assert!(arg2 > arg0.seq, 3);
        arg0.seq = arg2;
    }

    public fun owner(arg0: &Guard) : address {
        arg0.owner
    }

    public fun reset(arg0: &mut Guard, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        arg0.seq = 0;
    }

    public fun seq(arg0: &Guard) : u64 {
        arg0.seq
    }

    // decompiled from Move bytecode v7
}

