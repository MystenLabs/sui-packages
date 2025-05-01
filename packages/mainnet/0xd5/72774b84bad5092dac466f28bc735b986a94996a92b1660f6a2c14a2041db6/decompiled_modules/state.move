module 0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::state {
    struct State has key {
        id: 0x2::object::UID,
        owner: address,
        paused: bool,
    }

    public(friend) fun assert_not_paused(arg0: &State) {
        assert!(!arg0.paused, 14);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id     : 0x2::object::new(arg0),
            owner  : 0x2::tx_context::sender(arg0),
            paused : false,
        };
        0x2::transfer::share_object<State>(v0);
    }

    public(friend) entry fun set_paused(arg0: &mut State, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v6
}

