module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state {
    struct State has store, key {
        id: 0x2::object::UID,
        paused: bool,
        version: u64,
    }

    public(friend) fun assert_not_paused(arg0: &State) {
        if (arg0.paused) {
            abort 0
        };
    }

    public(friend) fun assert_paused(arg0: &State) {
        if (!arg0.paused) {
            abort 1
        };
    }

    public(friend) fun assert_version(arg0: &State) {
        if (arg0.version != 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::version()) {
            abort 2
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id      : 0x2::object::new(arg0),
            paused  : false,
            version : 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::version(),
        };
        0x2::transfer::share_object<State>(v0);
    }

    public entry fun pause(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut State, arg2: &0x2::tx_context::TxContext) {
        assert_not_paused(arg1);
        arg1.paused = true;
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter::emit_paused_event(0x2::tx_context::sender(arg2));
    }

    public entry fun upause(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut State, arg2: &0x2::tx_context::TxContext) {
        assert_paused(arg1);
        arg1.paused = false;
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter::emit_unpaused_event(0x2::tx_context::sender(arg2));
    }

    public entry fun upgrade(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut State, arg2: &0x2::tx_context::TxContext) {
        if (arg1.version >= 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::version()) {
            abort 3
        };
        arg1.version = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::version();
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter::emit_upgraded_event(0x2::tx_context::sender(arg2), arg1.version, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::version());
    }

    // decompiled from Move bytecode v6
}

