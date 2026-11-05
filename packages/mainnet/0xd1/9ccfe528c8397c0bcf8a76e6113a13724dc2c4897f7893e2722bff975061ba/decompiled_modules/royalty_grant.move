module 0xd19ccfe528c8397c0bcf8a76e6113a13724dc2c4897f7893e2722bff975061ba::royalty_grant {
    struct RoyaltyGrant<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        stake: 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>,
        owner: address,
        recipient: address,
        recipient_share: 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::BPS,
        repayment_value: 0x1::option::Option<u64>,
        repaid_value: u64,
        remainder: u64,
        duration_ms: 0x1::option::Option<u64>,
        activated_at_ms: 0x1::option::Option<u64>,
        ends_at_ms: 0x1::option::Option<u64>,
    }

    struct RoyaltyGrantOwnerCap has store, key {
        id: 0x2::object::UID,
        grant_id: 0x2::object::ID,
    }

    struct RoyaltyGrantRecipientCap has store, key {
        id: 0x2::object::UID,
        grant_id: 0x2::object::ID,
    }

    struct RoyaltyGrantTerms has copy, drop, store {
        recipient_share: 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::BPS,
        repayment_value: 0x1::option::Option<u64>,
        duration_ms: 0x1::option::Option<u64>,
    }

    struct RoyaltyGrantOwnerCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RoyaltyGrantRecipientCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RoyaltyGrantCreatedEvent<phantom T0, phantom T1> has copy, drop {
        grant_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        shares: u64,
        owner: address,
        recipient: address,
        recipient_share_bps: u16,
        repayment_value: 0x1::option::Option<u64>,
        duration_ms: 0x1::option::Option<u64>,
    }

    struct RoyaltyGrantActivatedEvent has copy, drop {
        grant_id: 0x2::object::ID,
        recipient: address,
        activated_at_ms: u64,
        ends_at_ms: 0x1::option::Option<u64>,
    }

    struct RoyaltyGrantSweptEvent<phantom T0> has copy, drop {
        grant_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        recipient: address,
        recipient_value: u64,
        owner: address,
        owner_value: u64,
        repaid_value: u64,
    }

    struct RoyaltyGrantBoughtOutEvent has copy, drop {
        grant_id: 0x2::object::ID,
        recipient: address,
        value: u64,
    }

    struct RoyaltyGrantCancelledEvent has copy, drop {
        grant_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
    }

    struct RoyaltyGrantReclaimedEvent has copy, drop {
        grant_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
    }

    struct RoyaltyGrantWaivedEvent has copy, drop {
        grant_id: 0x2::object::ID,
        ends_at_ms: u64,
    }

    struct RoyaltyGrantOwnerSetEvent has copy, drop {
        grant_id: 0x2::object::ID,
        owner: address,
    }

    struct RoyaltyGrantRecipientSetEvent has copy, drop {
        grant_id: 0x2::object::ID,
        recipient: address,
    }

    public fun new<T0, T1>(arg0: &mut 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::RoyaltyPool<T0, T1>, arg1: 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>, arg2: address, arg3: address, arg4: RoyaltyGrantTerms, arg5: &0x2::accumulator::AccumulatorRoot, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (RoyaltyGrant<T0, T1>, RoyaltyGrantOwnerCap) {
        let v0 = 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::pool_ids<T0>(&arg1);
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v0), 4);
        0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::register_stake<T0, T1>(arg0, &mut arg1, arg5, arg6);
        let RoyaltyGrantTerms {
            recipient_share : v1,
            repayment_value : v2,
            duration_ms     : v3,
        } = arg4;
        let v4 = 0x2::object::new(arg7);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let v6 = RoyaltyGrantOwnerCapKey{dummy_field: false};
        let v7 = RoyaltyGrantOwnerCap{
            id       : 0x2::derived_object::claim<RoyaltyGrantOwnerCapKey>(&mut v4, v6),
            grant_id : v5,
        };
        let v8 = RoyaltyGrantCreatedEvent<T0, T1>{
            grant_id            : v5,
            stake_id            : 0x2::object::id<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(&arg1),
            pool_id             : 0x2::object::id<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::RoyaltyPool<T0, T1>>(arg0),
            shares              : 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::value<T0>(&arg1),
            owner               : arg2,
            recipient           : arg3,
            recipient_share_bps : 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::value(v1),
            repayment_value     : v2,
            duration_ms         : v3,
        };
        0x2::event::emit<RoyaltyGrantCreatedEvent<T0, T1>>(v8);
        let v9 = RoyaltyGrant<T0, T1>{
            id              : v4,
            stake           : arg1,
            owner           : arg2,
            recipient       : arg3,
            recipient_share : v1,
            repayment_value : v2,
            repaid_value    : 0,
            remainder       : 0,
            duration_ms     : v3,
            activated_at_ms : 0x1::option::none<u64>(),
            ends_at_ms      : 0x1::option::none<u64>(),
        };
        (v9, v7)
    }

    fun accrue<T0, T1>(arg0: &mut RoyaltyGrant<T0, T1>, arg1: u64) : u64 {
        let v0 = (0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::value(0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::max()) as u128);
        let v1 = (arg1 as u128) * (0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::value(arg0.recipient_share) as u128) + (arg0.remainder as u128);
        arg0.remainder = ((v1 % v0) as u64);
        ((v1 / v0) as u64)
    }

    public fun activate<T0, T1>(arg0: &mut RoyaltyGrant<T0, T1>, arg1: &mut 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::RoyaltyPool<T0, T1>, arg2: &0x2::accumulator::AccumulatorRoot, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : RoyaltyGrantRecipientCap {
        assert!(0x1::option::is_none<u64>(&arg0.activated_at_ms), 10);
        assert!(0x2::tx_context::sender(arg4) == arg0.recipient, 12);
        0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::settle<T0, T1>(arg1, arg2, arg3);
        assert!(0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::pending_royalties<T0, T1>(arg1, &arg0.stake) == 0, 13);
        start<T0, T1>(arg0, arg3)
    }

    public fun activated_at_ms<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : 0x1::option::Option<u64> {
        arg0.activated_at_ms
    }

    public fun buyout<T0, T1>(arg0: &mut RoyaltyGrant<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<u64>(&arg0.activated_at_ms), 11);
        assert!(!is_reclaimable<T0, T1>(arg0, arg2), 9);
        let v0 = 0x2::balance::value<T1>(&arg1);
        let v1 = remaining_value<T0, T1>(arg0);
        if (0x1::option::is_some<u64>(&v1)) {
            assert!(v0 == 0x1::option::destroy_some<u64>(v1), 8);
            0x2::balance::send_funds<T1>(arg1, arg0.recipient);
            arg0.repaid_value = *0x1::option::borrow<u64>(&arg0.repayment_value);
            let v2 = RoyaltyGrantBoughtOutEvent{
                grant_id  : 0x2::object::id<RoyaltyGrant<T0, T1>>(arg0),
                recipient : arg0.recipient,
                value     : v0,
            };
            0x2::event::emit<RoyaltyGrantBoughtOutEvent>(v2);
            return
        } else {
            0x1::option::destroy_none<u64>(v1);
            abort 7
        };
    }

    public fun cancel<T0, T1>(arg0: RoyaltyGrant<T0, T1>, arg1: RoyaltyGrantOwnerCap) : 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0> {
        let v0 = 0x2::object::id<RoyaltyGrant<T0, T1>>(&arg0);
        assert!(arg1.grant_id == v0, 5);
        assert!(0x1::option::is_none<u64>(&arg0.activated_at_ms), 10);
        let RoyaltyGrant {
            id              : v1,
            stake           : v2,
            owner           : _,
            recipient       : _,
            recipient_share : _,
            repayment_value : _,
            repaid_value    : _,
            remainder       : _,
            duration_ms     : _,
            activated_at_ms : _,
            ends_at_ms      : _,
        } = arg0;
        let v12 = v2;
        let RoyaltyGrantOwnerCap {
            id       : v13,
            grant_id : _,
        } = arg1;
        let v15 = RoyaltyGrantCancelledEvent{
            grant_id : v0,
            stake_id : 0x2::object::id<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(&v12),
        };
        0x2::event::emit<RoyaltyGrantCancelledEvent>(v15);
        0x2::object::delete(v13);
        0x2::object::delete(v1);
        v12
    }

    public fun derive_owner_cap_address<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : address {
        let v0 = RoyaltyGrantOwnerCapKey{dummy_field: false};
        0x2::derived_object::derive_address<RoyaltyGrantOwnerCapKey>(0x2::object::id<RoyaltyGrant<T0, T1>>(arg0), v0)
    }

    public fun derive_recipient_cap_address<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : address {
        let v0 = RoyaltyGrantRecipientCapKey{dummy_field: false};
        0x2::derived_object::derive_address<RoyaltyGrantRecipientCapKey>(0x2::object::id<RoyaltyGrant<T0, T1>>(arg0), v0)
    }

    public fun destroy_recipient_cap(arg0: RoyaltyGrantRecipientCap) {
        let RoyaltyGrantRecipientCap {
            id       : v0,
            grant_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun duration_ms<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : 0x1::option::Option<u64> {
        arg0.duration_ms
    }

    public fun ends_at_ms<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : 0x1::option::Option<u64> {
        arg0.ends_at_ms
    }

    public fun is_active<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : bool {
        0x1::option::is_some<u64>(&arg0.activated_at_ms)
    }

    public fun is_reclaimable<T0, T1>(arg0: &RoyaltyGrant<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        let v0 = &arg0.repayment_value;
        if (0x1::option::is_some<u64>(v0) && arg0.repaid_value == *0x1::option::borrow<u64>(v0)) {
            true
        } else {
            let v2 = &arg0.ends_at_ms;
            0x1::option::is_some<u64>(v2) && 0x2::clock::timestamp_ms(arg1) >= *0x1::option::borrow<u64>(v2)
        }
    }

    public fun new_active<T0, T1>(arg0: &mut 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::RoyaltyPool<T0, T1>, arg1: 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>, arg2: address, arg3: address, arg4: RoyaltyGrantTerms, arg5: &0x2::accumulator::AccumulatorRoot, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (RoyaltyGrant<T0, T1>, RoyaltyGrantOwnerCap, RoyaltyGrantRecipientCap) {
        let (v0, v1) = new<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = v0;
        let v3 = &mut v2;
        (v2, v1, start<T0, T1>(v3, arg6))
    }

    public fun new_terms(arg0: 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::BPS, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>) : RoyaltyGrantTerms {
        assert!(!0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::is_zero(arg0), 0);
        let v0 = &arg1;
        assert!(0x1::option::is_none<u64>(v0) || *0x1::option::borrow<u64>(v0) > 0, 1);
        let v1 = &arg2;
        assert!(0x1::option::is_none<u64>(v1) || *0x1::option::borrow<u64>(v1) > 0, 2);
        assert!(0x1::option::is_some<u64>(&arg1) || 0x1::option::is_some<u64>(&arg2), 3);
        RoyaltyGrantTerms{
            recipient_share : arg0,
            repayment_value : arg1,
            duration_ms     : arg2,
        }
    }

    public fun owner<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : address {
        arg0.owner
    }

    public fun recipient<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : address {
        arg0.recipient
    }

    public fun recipient_share<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::BPS {
        arg0.recipient_share
    }

    public fun reclaim<T0, T1>(arg0: RoyaltyGrant<T0, T1>, arg1: RoyaltyGrantOwnerCap, arg2: &0x2::clock::Clock) : 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0> {
        let v0 = 0x2::object::id<RoyaltyGrant<T0, T1>>(&arg0);
        assert!(arg1.grant_id == v0, 5);
        assert!(is_reclaimable<T0, T1>(&arg0, arg2), 6);
        let RoyaltyGrant {
            id              : v1,
            stake           : v2,
            owner           : _,
            recipient       : _,
            recipient_share : _,
            repayment_value : _,
            repaid_value    : _,
            remainder       : _,
            duration_ms     : _,
            activated_at_ms : _,
            ends_at_ms      : _,
        } = arg0;
        let v12 = v2;
        let RoyaltyGrantOwnerCap {
            id       : v13,
            grant_id : _,
        } = arg1;
        let v15 = RoyaltyGrantReclaimedEvent{
            grant_id : v0,
            stake_id : 0x2::object::id<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(&v12),
        };
        0x2::event::emit<RoyaltyGrantReclaimedEvent>(v15);
        0x2::object::delete(v13);
        0x2::object::delete(v1);
        v12
    }

    public fun remaining_value<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : 0x1::option::Option<u64> {
        let v0 = &arg0.repayment_value;
        if (0x1::option::is_some<u64>(v0)) {
            0x1::option::some<u64>(*0x1::option::borrow<u64>(v0) - arg0.repaid_value)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun repaid_value<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : u64 {
        arg0.repaid_value
    }

    public fun repayment_value<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : 0x1::option::Option<u64> {
        arg0.repayment_value
    }

    public fun royalty_grant_owner_cap_grant_id(arg0: &RoyaltyGrantOwnerCap) : 0x2::object::ID {
        arg0.grant_id
    }

    public fun royalty_grant_recipient_cap_grant_id(arg0: &RoyaltyGrantRecipientCap) : 0x2::object::ID {
        arg0.grant_id
    }

    public fun royalty_grant_terms_duration_ms(arg0: &RoyaltyGrantTerms) : 0x1::option::Option<u64> {
        arg0.duration_ms
    }

    public fun royalty_grant_terms_recipient_share(arg0: &RoyaltyGrantTerms) : 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::BPS {
        arg0.recipient_share
    }

    public fun royalty_grant_terms_repayment_value(arg0: &RoyaltyGrantTerms) : 0x1::option::Option<u64> {
        arg0.repayment_value
    }

    public fun set_owner<T0, T1>(arg0: &mut RoyaltyGrant<T0, T1>, arg1: &RoyaltyGrantOwnerCap, arg2: address) {
        let v0 = 0x2::object::id<RoyaltyGrant<T0, T1>>(arg0);
        assert!(arg1.grant_id == v0, 5);
        if (arg0.owner == arg2) {
            return
        };
        arg0.owner = arg2;
        let v1 = RoyaltyGrantOwnerSetEvent{
            grant_id : v0,
            owner    : arg2,
        };
        0x2::event::emit<RoyaltyGrantOwnerSetEvent>(v1);
    }

    public fun set_recipient<T0, T1>(arg0: &mut RoyaltyGrant<T0, T1>, arg1: &RoyaltyGrantRecipientCap, arg2: address) {
        let v0 = 0x2::object::id<RoyaltyGrant<T0, T1>>(arg0);
        assert!(arg1.grant_id == v0, 5);
        if (arg0.recipient == arg2) {
            return
        };
        arg0.recipient = arg2;
        let v1 = RoyaltyGrantRecipientSetEvent{
            grant_id  : v0,
            recipient : arg2,
        };
        0x2::event::emit<RoyaltyGrantRecipientSetEvent>(v1);
    }

    public fun share<T0, T1>(arg0: RoyaltyGrant<T0, T1>) {
        0x2::transfer::share_object<RoyaltyGrant<T0, T1>>(arg0);
    }

    public fun stake<T0, T1>(arg0: &RoyaltyGrant<T0, T1>) : &0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0> {
        &arg0.stake
    }

    fun start<T0, T1>(arg0: &mut RoyaltyGrant<T0, T1>, arg1: &0x2::clock::Clock) : RoyaltyGrantRecipientCap {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.duration_ms;
        let v2 = if (0x1::option::is_some<u64>(&v1)) {
            0x1::option::some<u64>(0x1::u64::saturating_add(v0, 0x1::option::destroy_some<u64>(v1)))
        } else {
            0x1::option::destroy_none<u64>(v1);
            0x1::option::none<u64>()
        };
        arg0.activated_at_ms = 0x1::option::some<u64>(v0);
        arg0.ends_at_ms = v2;
        let v3 = 0x2::object::id<RoyaltyGrant<T0, T1>>(arg0);
        let v4 = RoyaltyGrantActivatedEvent{
            grant_id        : v3,
            recipient       : arg0.recipient,
            activated_at_ms : v0,
            ends_at_ms      : v2,
        };
        0x2::event::emit<RoyaltyGrantActivatedEvent>(v4);
        let v5 = RoyaltyGrantRecipientCapKey{dummy_field: false};
        RoyaltyGrantRecipientCap{
            id       : 0x2::derived_object::claim<RoyaltyGrantRecipientCapKey>(&mut arg0.id, v5),
            grant_id : v3,
        }
    }

    public fun sweep<T0, T1>(arg0: &mut RoyaltyGrant<T0, T1>, arg1: &mut 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::RoyaltyPool<T0, T1>, arg2: &0x2::accumulator::AccumulatorRoot, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::object::id<RoyaltyGrant<T0, T1>>(arg0);
        0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::settle<T0, T1>(arg1, arg2, arg3);
        let v1 = 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::claim_royalties<T0, T1>(arg1, &mut arg0.stake);
        let v2 = 0x2::balance::value<T1>(&v1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T1>(v1);
            return 0
        };
        let v3 = if (0x1::option::is_none<u64>(&arg0.activated_at_ms)) {
            true
        } else {
            let v4 = &arg0.ends_at_ms;
            0x1::option::is_some<u64>(v4) && 0x2::clock::timestamp_ms(arg3) >= *0x1::option::borrow<u64>(v4)
        };
        let v5 = if (v3) {
            0
        } else {
            let v6 = accrue<T0, T1>(arg0, v2);
            let v7 = remaining_value<T0, T1>(arg0);
            let v8 = if (0x1::option::is_some<u64>(&v7)) {
                0x1::option::destroy_some<u64>(v7)
            } else {
                0x1::option::destroy_none<u64>(v7);
                v2
            };
            0x1::u64::min(v6, v8)
        };
        if (0x1::option::is_some<u64>(&arg0.repayment_value)) {
            arg0.repaid_value = arg0.repaid_value + v5;
        };
        let v9 = v2 - v5;
        if (v5 > 0) {
            0x2::balance::send_funds<T1>(0x2::balance::split<T1>(&mut v1, v5), arg0.recipient);
        };
        if (v9 > 0) {
            0x2::balance::send_funds<T1>(v1, arg0.owner);
        } else {
            0x2::balance::destroy_zero<T1>(v1);
        };
        let v10 = RoyaltyGrantSweptEvent<T1>{
            grant_id        : v0,
            pool_id         : 0x2::object::id<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::RoyaltyPool<T0, T1>>(arg1),
            recipient       : arg0.recipient,
            recipient_value : v5,
            owner           : arg0.owner,
            owner_value     : v9,
            repaid_value    : arg0.repaid_value,
        };
        0x2::event::emit<RoyaltyGrantSweptEvent<T1>>(v10);
        v2
    }

    public fun waive<T0, T1>(arg0: &mut RoyaltyGrant<T0, T1>, arg1: &RoyaltyGrantRecipientCap, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<RoyaltyGrant<T0, T1>>(arg0);
        assert!(arg1.grant_id == v0, 5);
        assert!(!is_reclaimable<T0, T1>(arg0, arg2), 9);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        arg0.ends_at_ms = 0x1::option::some<u64>(v1);
        let v2 = RoyaltyGrantWaivedEvent{
            grant_id   : v0,
            ends_at_ms : v1,
        };
        0x2::event::emit<RoyaltyGrantWaivedEvent>(v2);
    }

    // decompiled from Move bytecode v7
}

