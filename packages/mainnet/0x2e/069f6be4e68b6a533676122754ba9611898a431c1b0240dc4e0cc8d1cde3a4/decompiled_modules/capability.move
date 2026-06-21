module 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        agent: 0x1::option::Option<0x2::object::ID>,
        funds: 0x2::balance::Balance<T0>,
        per_tx_cap: u64,
        period_cap: u64,
        period_ms: u64,
        expiry_ms: u64,
        spent_in_period: u64,
        period_start_ms: u64,
    }

    struct OwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::object::ID,
    }

    struct AgentCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::object::ID,
    }

    struct PositionKey has copy, drop, store {
        pos0: u8,
    }

    struct ReleaseTicket {
        treasury_id: 0x2::object::ID,
        protocol_id: u8,
    }

    struct TreasuryCreated has copy, drop {
        treasury: 0x2::object::ID,
        owner: address,
        agent: 0x2::object::ID,
    }

    struct FundsReleased has copy, drop {
        treasury: 0x2::object::ID,
        amount: u64,
        spent_in_period: u64,
    }

    struct AgentRevoked has copy, drop {
        treasury: 0x2::object::ID,
    }

    struct PrincipalWithdrawn has copy, drop {
        treasury: 0x2::object::ID,
        amount: u64,
    }

    public fun balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (Treasury<T0>, OwnerCap<T0>, AgentCap<T0>) {
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = AgentCap<T0>{
            id       : 0x2::object::new(arg6),
            treasury : v1,
        };
        let v3 = OwnerCap<T0>{
            id       : 0x2::object::new(arg6),
            treasury : v1,
        };
        let v4 = Treasury<T0>{
            id              : v0,
            owner           : 0x2::tx_context::sender(arg6),
            agent           : 0x1::option::some<0x2::object::ID>(0x2::object::id<AgentCap<T0>>(&v2)),
            funds           : 0x2::coin::into_balance<T0>(arg0),
            per_tx_cap      : arg1,
            period_cap      : arg2,
            period_ms       : arg3,
            expiry_ms       : arg4,
            spent_in_period : 0,
            period_start_ms : 0x2::clock::timestamp_ms(arg5),
        };
        let v5 = TreasuryCreated{
            treasury : v1,
            owner    : 0x2::tx_context::sender(arg6),
            agent    : 0x2::object::id<AgentCap<T0>>(&v2),
        };
        0x2::event::emit<TreasuryCreated>(v5);
        (v4, v3, v2)
    }

    public fun borrow_for_ticket<T0, T1: store + key>(arg0: &mut Treasury<T0>, arg1: &ReleaseTicket) : &mut T1 {
        assert!(arg1.treasury_id == 0x2::object::id<Treasury<T0>>(arg0), 13906835200840564737);
        let v0 = PositionKey{pos0: arg1.protocol_id};
        assert!(0x2::dynamic_object_field::exists_<PositionKey>(&arg0.id, v0), 13906835205136318477);
        let v1 = PositionKey{pos0: arg1.protocol_id};
        0x2::dynamic_object_field::borrow_mut<PositionKey, T1>(&mut arg0.id, v1)
    }

    entry fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = new<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        0x2::transfer::share_object<Treasury<T0>>(v0);
        0x2::transfer::public_transfer<OwnerCap<T0>>(v1, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<AgentCap<T0>>(v2, arg5);
    }

    public fun custody_new<T0, T1: store + key>(arg0: &mut Treasury<T0>, arg1: ReleaseTicket, arg2: T1) {
        let ReleaseTicket {
            treasury_id : v0,
            protocol_id : v1,
        } = arg1;
        assert!(v0 == 0x2::object::id<Treasury<T0>>(arg0), 13906835153595924481);
        let v2 = PositionKey{pos0: v1};
        assert!(!0x2::dynamic_object_field::exists_<PositionKey>(&arg0.id, v2), 13906835157891547147);
        let v3 = PositionKey{pos0: v1};
        0x2::dynamic_object_field::add<PositionKey, T1>(&mut arg0.id, v3, arg2);
    }

    public fun deposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun discharge_existing<T0>(arg0: &Treasury<T0>, arg1: ReleaseTicket) {
        let ReleaseTicket {
            treasury_id : v0,
            protocol_id : v1,
        } = arg1;
        assert!(v0 == 0x2::object::id<Treasury<T0>>(arg0), 13906835239495270401);
        let v2 = PositionKey{pos0: v1};
        assert!(0x2::dynamic_object_field::exists_<PositionKey>(&arg0.id, v2), 13906835243791024141);
    }

    public fun has_position<T0>(arg0: &Treasury<T0>, arg1: u8) : bool {
        let v0 = PositionKey{pos0: arg1};
        0x2::dynamic_object_field::exists_<PositionKey>(&arg0.id, v0)
    }

    public fun is_agent_active<T0>(arg0: &Treasury<T0>, arg1: &AgentCap<T0>) : bool {
        arg0.agent == 0x1::option::some<0x2::object::ID>(0x2::object::id<AgentCap<T0>>(arg1))
    }

    public fun owner<T0>(arg0: &Treasury<T0>) : address {
        arg0.owner
    }

    public fun owner_recustody<T0, T1: store + key>(arg0: &mut Treasury<T0>, arg1: &OwnerCap<T0>, arg2: u8, arg3: T1) {
        assert!(arg1.treasury == 0x2::object::id<Treasury<T0>>(arg0), 13906835372639256577);
        let v0 = PositionKey{pos0: arg2};
        assert!(!0x2::dynamic_object_field::exists_<PositionKey>(&arg0.id, v0), 13906835376934879243);
        let v1 = PositionKey{pos0: arg2};
        0x2::dynamic_object_field::add<PositionKey, T1>(&mut arg0.id, v1, arg3);
    }

    public fun owner_take_receipt<T0, T1: store + key>(arg0: &mut Treasury<T0>, arg1: &OwnerCap<T0>, arg2: u8) : T1 {
        assert!(arg1.treasury == 0x2::object::id<Treasury<T0>>(arg0), 13906835316804681729);
        let v0 = PositionKey{pos0: arg2};
        assert!(0x2::dynamic_object_field::exists_<PositionKey>(&arg0.id, v0), 13906835321100435469);
        let v1 = PositionKey{pos0: arg2};
        0x2::dynamic_object_field::remove<PositionKey, T1>(&mut arg0.id, v1)
    }

    public(friend) fun release_with_ticket<T0>(arg0: &mut Treasury<T0>, arg1: &AgentCap<T0>, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, ReleaseTicket) {
        assert!(arg1.treasury == 0x2::object::id<Treasury<T0>>(arg0), 13906834968912330753);
        assert!(arg0.agent == 0x1::option::some<0x2::object::ID>(0x2::object::id<AgentCap<T0>>(arg1)), 13906834973207429123);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < arg0.expiry_ms, 13906834986092462085);
        assert!(arg3 <= arg0.per_tx_cap, 13906834990387560455);
        if (v0 >= arg0.period_start_ms + arg0.period_ms) {
            arg0.period_start_ms = v0;
            arg0.spent_in_period = 0;
        };
        assert!(arg0.spent_in_period + arg3 <= arg0.period_cap, 13906835020452462601);
        arg0.spent_in_period = arg0.spent_in_period + arg3;
        let v1 = FundsReleased{
            treasury        : 0x2::object::id<Treasury<T0>>(arg0),
            amount          : arg3,
            spent_in_period : arg0.spent_in_period,
        };
        0x2::event::emit<FundsReleased>(v1);
        let v2 = ReleaseTicket{
            treasury_id : 0x2::object::id<Treasury<T0>>(arg0),
            protocol_id : arg2,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, arg3), arg5), v2)
    }

    public fun revoke<T0>(arg0: &mut Treasury<T0>, arg1: &OwnerCap<T0>) {
        assert!(arg1.treasury == 0x2::object::id<Treasury<T0>>(arg0), 13906835402704027649);
        arg0.agent = 0x1::option::none<0x2::object::ID>();
        let v0 = AgentRevoked{treasury: 0x2::object::id<Treasury<T0>>(arg0)};
        0x2::event::emit<AgentRevoked>(v0);
    }

    public fun ticket_has_position<T0>(arg0: &Treasury<T0>, arg1: &ReleaseTicket) : bool {
        assert!(arg1.treasury_id == 0x2::object::id<Treasury<T0>>(arg0), 13906835102056316929);
        let v0 = PositionKey{pos0: arg1.protocol_id};
        0x2::dynamic_object_field::exists_<PositionKey>(&arg0.id, v0)
    }

    public fun withdraw_principal<T0>(arg0: &mut Treasury<T0>, arg1: &OwnerCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.treasury == 0x2::object::id<Treasury<T0>>(arg0), 13906835454243635201);
        let v0 = PrincipalWithdrawn{
            treasury : 0x2::object::id<Treasury<T0>>(arg0),
            amount   : arg2,
        };
        0x2::event::emit<PrincipalWithdrawn>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

