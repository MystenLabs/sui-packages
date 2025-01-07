module 0xd2fa4a0959abfe4a798761eb62886911505c02592be85f43943299a47c3684f9::gameconnector {
    struct AccessControl has key {
        id: 0x2::object::UID,
        owner: address,
        paused: bool,
    }

    struct UserJoinedGame has copy, drop {
        game_id: u64,
        user: address,
        token_cost: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessControl{
            id     : 0x2::object::new(arg0),
            owner  : 0x2::tx_context::sender(arg0),
            paused : false,
        };
        0x2::transfer::share_object<AccessControl>(v0);
    }

    public entry fun joinGame(arg0: &AccessControl, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = UserJoinedGame{
            game_id    : arg1,
            user       : 0x2::tx_context::sender(arg3),
            token_cost : arg2,
        };
        0x2::event::emit<UserJoinedGame>(v0);
    }

    public entry fun pause(arg0: &mut AccessControl, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        arg0.paused = true;
    }

    public entry fun unpause(arg0: &mut AccessControl, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        arg0.paused = false;
    }

    // decompiled from Move bytecode v6
}

