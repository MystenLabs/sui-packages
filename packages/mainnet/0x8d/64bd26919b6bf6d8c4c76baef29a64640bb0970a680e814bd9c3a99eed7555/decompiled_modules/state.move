module 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state {
    struct State has key {
        id: 0x2::object::UID,
        is_paused: bool,
        version: u64,
        operators: 0x2::vec_set::VecSet<address>,
    }

    public entry fun add_operator(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::admin_cap::AdminCap, arg1: &mut State, arg2: address) {
        assert_version(arg1);
        assert_not_pause(arg1);
        0x2::vec_set::insert<address>(&mut arg1.operators, arg2);
    }

    public fun assert_not_pause(arg0: &State) {
        assert!(!arg0.is_paused, 0);
    }

    public fun assert_operator(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 2);
    }

    public fun assert_pause(arg0: &State) {
        assert!(arg0.is_paused, 1);
    }

    public fun assert_version(arg0: &State) {
        assert!(arg0.version == 1, 999);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id        : 0x2::object::new(arg0),
            is_paused : false,
            version   : 1,
            operators : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<State>(v0);
    }

    public entry fun pause(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::admin_cap::AdminCap, arg1: &mut State) {
        assert_version(arg1);
        assert!(!arg1.is_paused, 0);
        arg1.is_paused = true;
    }

    public entry fun remove_operator(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::admin_cap::AdminCap, arg1: &mut State, arg2: address) {
        assert_version(arg1);
        assert_not_pause(arg1);
        0x2::vec_set::remove<address>(&mut arg1.operators, &arg2);
    }

    public entry fun unpause(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::admin_cap::AdminCap, arg1: &mut State) {
        assert_version(arg1);
        assert!(arg1.is_paused, 1);
        arg1.is_paused = false;
    }

    entry fun upgrade(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::admin_cap::AdminCap, arg1: &mut State) {
        assert!(arg1.version < 1, 1000);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

