module 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::agent {
    struct AgentAllowance<phantom T0> has key {
        id: 0x2::object::UID,
        avatar: 0x2::object::ID,
        owner: address,
        agent: address,
        funds: 0x2::balance::Balance<T0>,
        daily_limit: u64,
        day: u64,
        spent: u64,
        revoked: bool,
    }

    struct AgentCap has key {
        id: 0x2::object::UID,
        allowance: 0x2::object::ID,
    }

    struct OwnAgents has key {
        id: 0x2::object::UID,
        avatars: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct AgentEvent has copy, drop {
        avatar: 0x2::object::ID,
        allowance: 0x2::object::ID,
        kind: u8,
        amount: u64,
    }

    public fun add_own(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut OwnAgents, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.avatars, arg2);
    }

    public fun create_own_agents(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<0x2::object::ID>();
        0x1::vector::reverse<0x2::object::ID>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut v0, 0x1::vector::pop_back<0x2::object::ID>(&mut arg1));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg1);
        let v2 = OwnAgents{
            id      : 0x2::object::new(arg2),
            avatars : v0,
        };
        0x2::transfer::share_object<OwnAgents>(v2);
    }

    public fun is_own(arg0: &OwnAgents, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.avatars, &arg1)
    }

    public fun open<T0>(arg0: &mut 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Avatar<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::owner<T0>(arg0), 404);
        assert!(arg2 <= 10000000000 && arg3 <= 1000000000, 405);
        let v0 = AgentAllowance<T0>{
            id          : 0x2::object::new(arg4),
            avatar      : 0x2::object::id<0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Avatar<T0>>(arg0),
            owner       : 0x2::tx_context::sender(arg4),
            agent       : arg1,
            funds       : 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::split_glow<T0>(arg0, arg2),
            daily_limit : arg3,
            day         : 0,
            spent       : 0,
            revoked     : false,
        };
        let v1 = AgentEvent{
            avatar    : 0x2::object::id<0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Avatar<T0>>(arg0),
            allowance : 0x2::object::id<AgentAllowance<T0>>(&v0),
            kind      : 0,
            amount    : arg2,
        };
        0x2::event::emit<AgentEvent>(v1);
        let v2 = AgentCap{
            id        : 0x2::object::new(arg4),
            allowance : 0x2::object::id<AgentAllowance<T0>>(&v0),
        };
        0x2::transfer::transfer<AgentCap>(v2, arg1);
        0x2::transfer::share_object<AgentAllowance<T0>>(v0);
    }

    public fun remaining<T0>(arg0: &AgentAllowance<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun remove_own(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut OwnAgents, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.avatars, &arg2);
    }

    public fun revoke<T0>(arg0: &mut AgentAllowance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 404);
        arg0.revoked = true;
        let v0 = AgentEvent{
            avatar    : arg0.avatar,
            allowance : 0x2::object::id<AgentAllowance<T0>>(arg0),
            kind      : 2,
            amount    : 0x2::balance::value<T0>(&arg0.funds),
        };
        0x2::event::emit<AgentEvent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.funds), arg1)
    }

    public fun spend<T0>(arg0: &AgentCap, arg1: &mut AgentAllowance<T0>, arg2: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Junction, arg3: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::JunctionHalt, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::assert_live(arg2, arg3);
        assert!(arg0.allowance == 0x2::object::id<AgentAllowance<T0>>(arg1) && 0x2::tx_context::sender(arg6) == arg1.agent, 403);
        assert!(!arg1.revoked, 400);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 86400000;
        if (v0 != arg1.day) {
            arg1.day = v0;
            arg1.spent = 0;
        };
        assert!(arg1.spent + arg4 <= arg1.daily_limit, 402);
        arg1.spent = arg1.spent + arg4;
        let v1 = AgentEvent{
            avatar    : arg1.avatar,
            allowance : 0x2::object::id<AgentAllowance<T0>>(arg1),
            kind      : 1,
            amount    : arg4,
        };
        0x2::event::emit<AgentEvent>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.funds, arg4), arg6)
    }

    // decompiled from Move bytecode v7
}

