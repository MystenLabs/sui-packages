module 0x45946b403701a0220aeeba744dd14a215699bea5af2dc5c3bb0958799b03f1ca::state {
    struct CurrentVersion has copy, drop, store {
        dummy_field: bool,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        admin: address,
        current_package: address,
        core_bridge_state: address,
        token_bridge_state: address,
    }

    public(friend) fun new(arg0: address, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : State {
        let v0 = State{
            id                 : 0x2::object::new(arg4),
            admin              : arg0,
            current_package    : arg1,
            core_bridge_state  : arg2,
            token_bridge_state : arg3,
        };
        let v1 = CurrentVersion{dummy_field: false};
        0x2::dynamic_field::add<CurrentVersion, 0x45946b403701a0220aeeba744dd14a215699bea5af2dc5c3bb0958799b03f1ca::version_control::V__1_0_0>(&mut v0.id, v1, 0x45946b403701a0220aeeba744dd14a215699bea5af2dc5c3bb0958799b03f1ca::version_control::current_version());
        v0
    }

    public fun core_bridge_state(arg0: &State) : address {
        arg0.core_bridge_state
    }

    public fun current_package(arg0: &State) : address {
        arg0.current_package
    }

    public(friend) fun migrate__v__1_0_0(arg0: &mut State) {
    }

    public(friend) fun migrate_version(arg0: &mut State) {
    }

    public fun token_bridge_state(arg0: &State) : address {
        arg0.token_bridge_state
    }

    public fun update_package(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.current_package = arg1;
    }

    // decompiled from Move bytecode v6
}

