module 0x42e0675459b802079685308925a93adbba309fbc78629164f3c572294b306515::txrace {
    struct Round has key {
        id: 0x2::object::UID,
        number: u64,
        addr: address,
    }

    struct RoundEvent has copy, drop {
        number: u64,
        addr: address,
    }

    public entry fun compete(arg0: &mut Round, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RoundEvent{
            number : arg0.number,
            addr   : arg0.addr,
        };
        0x2::event::emit<RoundEvent>(v0);
        arg0.number = arg1;
        arg0.addr = 0x2::tx_context::sender(arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Round{
            id     : 0x2::object::new(arg0),
            number : 0,
            addr   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Round>(v0);
    }

    // decompiled from Move bytecode v6
}

