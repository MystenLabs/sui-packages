module 0xe94269354ceb0d88dc01e0705865f7ec0b6593c46877c5200d7c452f1bbfa10c::halt {
    struct HaltFlag has key {
        id: 0x2::object::UID,
        halted: bool,
        seq: u64,
        last_setter: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Set has copy, drop {
        halted: bool,
        seq: u64,
        by: address,
    }

    public fun assert_live(arg0: &HaltFlag) {
        assert!(!arg0.halted, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HaltFlag{
            id          : 0x2::object::new(arg0),
            halted      : true,
            seq         : 0,
            last_setter : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<HaltFlag>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_halted(arg0: &HaltFlag) : bool {
        arg0.halted
    }

    public fun last_setter(arg0: &HaltFlag) : address {
        arg0.last_setter
    }

    public fun seq(arg0: &HaltFlag) : u64 {
        arg0.seq
    }

    public fun set(arg0: &AdminCap, arg1: &mut HaltFlag, arg2: bool, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg3 == arg1.seq + 1, 2);
        arg1.halted = arg2;
        arg1.seq = arg3;
        arg1.last_setter = 0x2::tx_context::sender(arg4);
        let v0 = Set{
            halted : arg2,
            seq    : arg3,
            by     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Set>(v0);
    }

    // decompiled from Move bytecode v7
}

