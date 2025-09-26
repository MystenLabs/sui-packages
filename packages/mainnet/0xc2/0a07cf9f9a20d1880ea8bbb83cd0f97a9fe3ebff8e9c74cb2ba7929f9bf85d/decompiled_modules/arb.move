module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::arb {
    struct NewArbEvent has copy, drop {
        object: address,
        arbitration: address,
        order: address,
    }

    struct Voted has copy, drop, store {
        agrees: vector<u8>,
        weight: u64,
        time: u64,
    }

    public fun ARB_ORDER_NOT_MATCH(arg0: bool) {
        assert!(arg0, 1002);
    }

    public fun NewArbEvent_emit(arg0: &address, arg1: &address, arg2: &address) {
        let v0 = NewArbEvent{
            object      : *arg0,
            arbitration : *arg1,
            order       : *arg2,
        };
        0x2::event::emit<NewArbEvent>(v0);
    }

    public fun PENDING(arg0: bool) {
        assert!(arg0, 1001);
    }

    public fun PROPOSITION_COUNT(arg0: u64) {
        assert!(arg0 <= 16, 1000);
    }

    public fun Voted_agrees(arg0: &Voted) : &vector<u8> {
        &arg0.agrees
    }

    public fun Voted_new(arg0: &vector<u8>, arg1: u64, arg2: u64) : Voted {
        Voted{
            agrees : *arg0,
            weight : arg1,
            time   : arg2,
        }
    }

    public fun Voted_time(arg0: &Voted) : u64 {
        arg0.time
    }

    public fun Voted_update(arg0: &mut Voted, arg1: &vector<u8>, arg2: u64, arg3: u64) {
        arg0.agrees = *arg1;
        arg0.weight = arg2;
        arg0.time = arg3;
    }

    public fun Voted_weight(arg0: &Voted) : u64 {
        arg0.weight
    }

    // decompiled from Move bytecode v6
}

