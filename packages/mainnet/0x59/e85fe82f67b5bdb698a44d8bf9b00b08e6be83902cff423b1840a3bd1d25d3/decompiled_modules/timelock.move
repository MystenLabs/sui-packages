module 0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::timelock {
    struct Timelock has store, key {
        id: 0x2::object::UID,
        proposal_id: 0x2::object::ID,
        execute_after: u64,
        executed: bool,
    }

    public fun consume(arg0: &mut Timelock, arg1: &0x2::clock::Clock) {
        assert!(!arg0.executed, 0);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.execute_after, 1);
        arg0.executed = true;
    }

    public fun execute_after(arg0: &Timelock) : u64 {
        arg0.execute_after
    }

    public fun is_ready(arg0: &Timelock, arg1: &0x2::clock::Clock) : bool {
        !arg0.executed && 0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.execute_after
    }

    public fun proposal_id(arg0: &Timelock) : 0x2::object::ID {
        arg0.proposal_id
    }

    public fun queue(arg0: 0x2::object::ID, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Timelock{
            id            : 0x2::object::new(arg2),
            proposal_id   : arg0,
            execute_after : 0x2::clock::timestamp_ms(arg1) / 1000 + 86400,
            executed      : false,
        };
        0x2::transfer::public_transfer<Timelock>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

