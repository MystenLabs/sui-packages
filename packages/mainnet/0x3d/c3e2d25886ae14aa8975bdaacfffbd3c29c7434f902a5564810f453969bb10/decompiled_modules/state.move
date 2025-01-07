module 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::state {
    struct State has store, key {
        id: 0x2::object::UID,
        pearl_minter: 0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Member<0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::pearl_minter_role::PEARL_MINTER_ROLE>,
        ostr_minter: 0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Member<0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role::OSTR_MINTER_ROLE>,
        ostr_per_ms: u64,
        total_alloc_point: u64,
        pearl_ratio: u64,
        pool_registry: 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::pool_registry::PoolRegistry,
        position_registry: 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position_registry::PositionRegistry,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : State {
        State{
            id                : 0x2::object::new(arg0),
            pearl_minter      : 0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::create_member<0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::pearl_minter_role::PEARL_MINTER_ROLE>(arg0),
            ostr_minter       : 0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::create_member<0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role::OSTR_MINTER_ROLE>(arg0),
            ostr_per_ms       : 0,
            total_alloc_point : 0,
            pearl_ratio       : 0,
            pool_registry     : 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::pool_registry::new(arg0),
            position_registry : 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position_registry::new(arg0),
        }
    }

    public(friend) fun borrow_mut_pool_registry(arg0: &mut State) : &mut 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::pool_registry::PoolRegistry {
        &mut arg0.pool_registry
    }

    public(friend) fun borrow_mut_pool_registry_and_position_registry_and_minter(arg0: &mut State) : (&mut 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::pool_registry::PoolRegistry, &mut 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position_registry::PositionRegistry, &0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Member<0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role::OSTR_MINTER_ROLE>, &0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Member<0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::pearl_minter_role::PEARL_MINTER_ROLE>) {
        (&mut arg0.pool_registry, &mut arg0.position_registry, &arg0.ostr_minter, &arg0.pearl_minter)
    }

    public(friend) fun borrow_mut_position_registry(arg0: &mut State) : &mut 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position_registry::PositionRegistry {
        &mut arg0.position_registry
    }

    public fun borrow_ostr_minter_id(arg0: &State) : &0x2::object::ID {
        0x2::object::borrow_id<0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Member<0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role::OSTR_MINTER_ROLE>>(&arg0.ostr_minter)
    }

    public fun borrow_pearl_minter_id(arg0: &State) : &0x2::object::ID {
        0x2::object::borrow_id<0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Member<0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::pearl_minter_role::PEARL_MINTER_ROLE>>(&arg0.pearl_minter)
    }

    public fun borrow_pool_registry(arg0: &State) : &0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::pool_registry::PoolRegistry {
        &arg0.pool_registry
    }

    public fun borrow_position_registry(arg0: &State) : &0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::position_registry::PositionRegistry {
        &arg0.position_registry
    }

    public(friend) fun decrease_alloc_point(arg0: &mut State, arg1: u64) {
        arg0.total_alloc_point = arg0.total_alloc_point - arg1;
    }

    public(friend) fun increase_alloc_point(arg0: &mut State, arg1: u64) {
        arg0.total_alloc_point = arg0.total_alloc_point + arg1;
    }

    public fun ostr_per_ms(arg0: &State) : u64 {
        arg0.ostr_per_ms
    }

    public fun pearl_ratio(arg0: &State) : u64 {
        arg0.pearl_ratio
    }

    public(friend) fun set_ostr_per_ms(arg0: &mut State, arg1: u64) {
        arg0.ostr_per_ms = arg1;
    }

    public(friend) fun set_pearl_ratio(arg0: &mut State, arg1: u64) {
        arg0.pearl_ratio = arg1;
    }

    public fun total_alloc_point(arg0: &State) : u64 {
        arg0.total_alloc_point
    }

    // decompiled from Move bytecode v6
}

