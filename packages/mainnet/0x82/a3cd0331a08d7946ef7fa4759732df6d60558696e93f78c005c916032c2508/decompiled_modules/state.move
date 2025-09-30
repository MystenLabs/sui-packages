module 0x82a3cd0331a08d7946ef7fa4759732df6d60558696e93f78c005c916032c2508::state {
    struct CurrentVersion has copy, drop, store {
        dummy_field: bool,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        admin: address,
        core_bridge_state: address,
        token_bridge_state: address,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    public(friend) fun new(arg0: 0x2::package::UpgradeCap, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : State {
        let v0 = State{
            id                 : 0x2::object::new(arg4),
            admin              : arg1,
            core_bridge_state  : arg2,
            token_bridge_state : arg3,
            upgrade_cap        : arg0,
        };
        let v1 = CurrentVersion{dummy_field: false};
        0x2::dynamic_field::add<CurrentVersion, 0x82a3cd0331a08d7946ef7fa4759732df6d60558696e93f78c005c916032c2508::version_control::V__1_0_0>(&mut v0.id, v1, 0x82a3cd0331a08d7946ef7fa4759732df6d60558696e93f78c005c916032c2508::version_control::current_version());
        v0
    }

    public fun authorize_upgrade(arg0: &mut State, arg1: u8, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        0x2::package::authorize_upgrade(&mut arg0.upgrade_cap, arg1, arg2)
    }

    public fun commit_upgrade(arg0: &mut State, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x2::package::commit_upgrade(&mut arg0.upgrade_cap, arg1);
    }

    public fun core_bridge_state(arg0: &State) : address {
        arg0.core_bridge_state
    }

    public(friend) fun migrate__v__1_0_0(arg0: &mut State) {
    }

    public(friend) fun migrate_version(arg0: &mut State) {
    }

    public fun token_bridge_state(arg0: &State) : address {
        arg0.token_bridge_state
    }

    // decompiled from Move bytecode v6
}

