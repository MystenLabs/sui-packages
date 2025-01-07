module 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state {
    struct State has store, key {
        id: 0x2::object::UID,
        pearl_minter: 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>,
        ostr_minter: 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>,
        ostr_per_ms: u64,
        total_alloc_point: u64,
        pearl_ratio: u64,
        pool_registry: 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::PoolRegistry,
        position_registry: 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position_registry::PositionRegistry,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : State {
        State{
            id                : 0x2::object::new(arg0),
            pearl_minter      : 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::create_member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>(arg0),
            ostr_minter       : 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::create_member<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>(arg0),
            ostr_per_ms       : 0,
            total_alloc_point : 0,
            pearl_ratio       : 0,
            pool_registry     : 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::new(arg0),
            position_registry : 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position_registry::new(arg0),
        }
    }

    public(friend) fun borrow_mut_pool_registry(arg0: &mut State) : &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::PoolRegistry {
        &mut arg0.pool_registry
    }

    public(friend) fun borrow_mut_pool_registry_and_position_registry_and_minter(arg0: &mut State) : (&mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::PoolRegistry, &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position_registry::PositionRegistry, &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>, &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>) {
        (&mut arg0.pool_registry, &mut arg0.position_registry, &arg0.ostr_minter, &arg0.pearl_minter)
    }

    public(friend) fun borrow_mut_position_registry(arg0: &mut State) : &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position_registry::PositionRegistry {
        &mut arg0.position_registry
    }

    public fun borrow_ostr_minter_id(arg0: &State) : &0x2::object::ID {
        0x2::object::borrow_id<0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>>(&arg0.ostr_minter)
    }

    public fun borrow_pearl_minter_id(arg0: &State) : &0x2::object::ID {
        0x2::object::borrow_id<0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>>(&arg0.pearl_minter)
    }

    public fun borrow_pool_registry(arg0: &State) : &0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::PoolRegistry {
        &arg0.pool_registry
    }

    public fun borrow_position_registry(arg0: &State) : &0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position_registry::PositionRegistry {
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

