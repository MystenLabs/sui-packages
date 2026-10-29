module 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::control {
    struct Control has store {
        controller: 0x2::object::ID,
        name: 0x1::ascii::String,
        owner: address,
        agent: address,
        agent_expires_ms: u64,
        policies: 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::policies::Policies,
        positions: 0x2::bag::Bag,
    }

    struct AgentSet has copy, drop {
        controller: 0x2::object::ID,
        agent: address,
        expires_ms: u64,
    }

    struct AgentRevoked has copy, drop {
        controller: 0x2::object::ID,
        agent: address,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Control {
        check_term(arg3, arg4);
        let v0 = AgentSet{
            controller : arg0,
            agent      : arg2,
            expires_ms : arg3,
        };
        0x2::event::emit<AgentSet>(v0);
        Control{
            controller       : arg0,
            name             : arg1,
            owner            : 0x2::tx_context::sender(arg5),
            agent            : arg2,
            agent_expires_ms : arg3,
            policies         : 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::policies::new(arg5),
            positions        : 0x2::bag::new(arg5),
        }
    }

    public(friend) fun add_policy<T0: store>(arg0: &mut Control, arg1: T0, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::policies::add<T0>(&mut arg0.policies, arg1);
    }

    public fun agent(arg0: &Control) : address {
        arg0.agent
    }

    public fun agent_expires_ms(arg0: &Control) : u64 {
        arg0.agent_expires_ms
    }

    public fun agent_live(arg0: &Control, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.agent_expires_ms
    }

    public(friend) fun assert_agent(arg0: &Control, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.agent == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.agent_expires_ms, 2);
    }

    public(friend) fun assert_owner(arg0: &Control, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
    }

    fun check_term(arg0: u64, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0 > v0 && arg0 <= v0 + 31536000000, 3);
    }

    public fun controller(arg0: &Control) : 0x2::object::ID {
        arg0.controller
    }

    public(friend) fun destroy(arg0: Control) {
        let Control {
            controller       : _,
            name             : _,
            owner            : _,
            agent            : _,
            agent_expires_ms : _,
            policies         : v5,
            positions        : v6,
        } = arg0;
        0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::policies::destroy_empty(v5);
        0x2::bag::destroy_empty(v6);
    }

    public(friend) fun edit_positions(arg0: &mut Control, arg1: &0x2::tx_context::TxContext) : &mut 0x2::bag::Bag {
        assert_owner(arg0, arg1);
        &mut arg0.positions
    }

    public fun name(arg0: &Control) : 0x1::ascii::String {
        arg0.name
    }

    public fun owner(arg0: &Control) : address {
        arg0.owner
    }

    public fun policies(arg0: &Control) : &0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::policies::Policies {
        &arg0.policies
    }

    public(friend) fun policies_mut(arg0: &mut Control) : &mut 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::policies::Policies {
        &mut arg0.policies
    }

    public fun positions(arg0: &Control) : &0x2::bag::Bag {
        &arg0.positions
    }

    public(friend) fun positions_mut(arg0: &mut Control) : &mut 0x2::bag::Bag {
        &mut arg0.positions
    }

    public(friend) fun remove_policy<T0: store>(arg0: &mut Control, arg1: &0x2::tx_context::TxContext) : T0 {
        assert_owner(arg0, arg1);
        0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::policies::remove<T0>(&mut arg0.policies)
    }

    public(friend) fun revoke_agent(arg0: &mut Control, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.agent_expires_ms = 0;
        let v0 = AgentRevoked{
            controller : arg0.controller,
            agent      : arg0.agent,
        };
        0x2::event::emit<AgentRevoked>(v0);
    }

    public(friend) fun set_term(arg0: &mut Control, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        check_term(arg1, arg2);
        arg0.agent_expires_ms = arg1;
        let v0 = AgentSet{
            controller : arg0.controller,
            agent      : arg0.agent,
            expires_ms : arg1,
        };
        0x2::event::emit<AgentSet>(v0);
    }

    // decompiled from Move bytecode v7
}

