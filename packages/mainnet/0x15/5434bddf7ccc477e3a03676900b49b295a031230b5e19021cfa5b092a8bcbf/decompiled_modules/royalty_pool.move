module 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool {
    struct RoyaltyPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T1>,
        staked_shares: u64,
        cumulative_royalty_per_share: u256,
        remainder: u128,
        last_settled_at_ms: u64,
    }

    struct RoyaltyPoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RoyaltyPoolCreatedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        work_id: 0x2::object::ID,
    }

    struct RoyaltyPoolStakeRegisteredEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        shares: u64,
        staked_shares: u64,
    }

    struct RoyaltyDepositedEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        value: u64,
        balance: u64,
        cumulative_royalty_per_share: u256,
    }

    struct RoyaltyClaimedEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        value: u64,
        balance: u64,
    }

    struct RoyaltyPoolStakeUnregisteredEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        shares: u64,
        value: u64,
        balance: u64,
        staked_shares: u64,
    }

    public fun balance_value<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance)
    }

    public fun claim_royalties<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: &mut 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::has_registration<T0>(arg1, v0), 2);
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, u256>(0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::registrations_mut<T0>(arg1), &v0);
        let v2 = royalty(0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::value<T0>(arg1), *v1, arg0.cumulative_royalty_per_share);
        if (v2 == 0) {
            return 0x2::balance::zero<T1>()
        };
        *v1 = *v1 + (v2 as u256) * (1000000000000000000 as u256);
        let v3 = RoyaltyClaimedEvent<T1>{
            pool_id  : v0,
            stake_id : 0x2::object::id<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(arg1),
            value    : v2,
            balance  : 0x2::balance::value<T1>(&arg0.balance),
        };
        0x2::event::emit<RoyaltyClaimedEvent<T1>>(v3);
        0x2::balance::split<T1>(&mut arg0.balance, v2)
    }

    public fun cumulative_royalty_per_share<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : u256 {
        arg0.cumulative_royalty_per_share
    }

    public fun deposit<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T1>(&arg1) == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            return
        };
        assert!(arg0.staked_shares > 0, 0);
        fold<T0, T1>(arg0, arg1);
    }

    public fun derive_composition_pool_address<T0, T1>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>) : address {
        let v0 = RoyaltyPoolKey<T1>{dummy_field: false};
        0x2::derived_object::derive_address<RoyaltyPoolKey<T1>>(0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>>(arg0), v0)
    }

    public fun derive_recording_pool_address<T0, T1>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>) : address {
        let v0 = RoyaltyPoolKey<T1>{dummy_field: false};
        0x2::derived_object::derive_address<RoyaltyPoolKey<T1>>(0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0), v0)
    }

    public fun derive_release_recording_pool_addresses<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release) : vector<address> {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::recording_ids(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v0)) {
            let v3 = RoyaltyPoolKey<T0>{dummy_field: false};
            0x1::vector::push_back<address>(&mut v1, 0x2::derived_object::derive_address<RoyaltyPoolKey<T0>>(*0x1::vector::borrow<0x2::object::ID>(v0, v2), v3));
            v2 = v2 + 1;
        };
        v1
    }

    fun fold<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg1);
        let v1 = (arg0.staked_shares as u128);
        let v2 = (v0 as u128) * 1000000000000000000 + arg0.remainder;
        arg0.cumulative_royalty_per_share = arg0.cumulative_royalty_per_share + ((v2 / v1) as u256);
        arg0.remainder = v2 % v1;
        0x2::balance::join<T1>(&mut arg0.balance, arg1);
        let v3 = RoyaltyDepositedEvent<T1>{
            pool_id                      : 0x2::object::uid_to_inner(&arg0.id),
            value                        : v0,
            balance                      : 0x2::balance::value<T1>(&arg0.balance),
            cumulative_royalty_per_share : arg0.cumulative_royalty_per_share,
        };
        0x2::event::emit<RoyaltyDepositedEvent<T1>>(v3);
    }

    public fun last_settled_at_ms<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : u64 {
        arg0.last_settled_at_ms
    }

    fun new<T0, T1>(arg0: &mut 0x2::object::UID) : RoyaltyPool<T0, T1> {
        let v0 = RoyaltyPoolKey<T1>{dummy_field: false};
        let v1 = RoyaltyPool<T0, T1>{
            id                           : 0x2::derived_object::claim<RoyaltyPoolKey<T1>>(arg0, v0),
            balance                      : 0x2::balance::zero<T1>(),
            staked_shares                : 0,
            cumulative_royalty_per_share : 0,
            remainder                    : 0,
            last_settled_at_ms           : 0,
        };
        let v2 = RoyaltyPoolCreatedEvent<T0, T1>{
            pool_id : 0x2::object::id<RoyaltyPool<T0, T1>>(&v1),
            work_id : 0x2::object::uid_to_inner(arg0),
        };
        0x2::event::emit<RoyaltyPoolCreatedEvent<T0, T1>>(v2);
        v1
    }

    public fun new_for_composition<T0, T1>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::CompositionAdminCap<T0>) : RoyaltyPool<T0, T1> {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid_mut<T0>(arg0, arg1);
        new<T0, T1>(v0)
    }

    public fun new_for_recording<T0, T1>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>) : RoyaltyPool<T0, T1> {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        new<T0, T1>(v0)
    }

    public fun pending_royalties<T0, T1>(arg0: &RoyaltyPool<T0, T1>, arg1: &0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>) : u64 {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        if (!0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::has_registration<T0>(arg1, v0)) {
            return 0
        };
        royalty(0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::value<T0>(arg1), *0x2::vec_map::get<0x2::object::ID, u256>(0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::registrations<T0>(arg1), &v0), arg0.cumulative_royalty_per_share)
    }

    public fun receive_coins<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T1>>>) : u64 {
        0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::receive_coins_and_send_funds<T1>(&mut arg0.id, arg1, 0x2::object::uid_to_address(&arg0.id))
    }

    public fun register_stake<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: &mut 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>, arg2: &0x2::accumulator::AccumulatorRoot, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(!0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::has_registration<T0>(arg1, v0), 1);
        settle<T0, T1>(arg0, arg2, arg3);
        let v1 = 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::value<T0>(arg1);
        0x2::vec_map::insert<0x2::object::ID, u256>(0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::registrations_mut<T0>(arg1), v0, (v1 as u256) * arg0.cumulative_royalty_per_share);
        arg0.staked_shares = arg0.staked_shares + v1;
        let v2 = RoyaltyPoolStakeRegisteredEvent<T1>{
            pool_id       : v0,
            stake_id      : 0x2::object::id<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(arg1),
            shares        : v1,
            staked_shares : arg0.staked_shares,
        };
        0x2::event::emit<RoyaltyPoolStakeRegisteredEvent<T1>>(v2);
    }

    fun royalty(arg0: u64, arg1: u256, arg2: u256) : u64 {
        ((((arg0 as u256) * arg2 - arg1) / (1000000000000000000 as u256)) as u64)
    }

    public fun settle<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: &0x2::accumulator::AccumulatorRoot, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 == arg0.last_settled_at_ms) {
            return 0
        };
        arg0.last_settled_at_ms = v0;
        if (arg0.staked_shares == 0) {
            return 0
        };
        let v1 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::redeem_settled_balance<T1>(&mut arg0.id, arg1);
        let v2 = 0x2::balance::value<T1>(&v1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T1>(v1);
            return 0
        };
        fold<T0, T1>(arg0, v1);
        v2
    }

    public fun share<T0, T1>(arg0: RoyaltyPool<T0, T1>) {
        0x2::transfer::share_object<RoyaltyPool<T0, T1>>(arg0);
    }

    public fun staked_shares<T0, T1>(arg0: &RoyaltyPool<T0, T1>) : u64 {
        arg0.staked_shares
    }

    public fun unregister_stake<T0, T1>(arg0: &mut RoyaltyPool<T0, T1>, arg1: &mut 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>, arg2: &0x2::accumulator::AccumulatorRoot, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::has_registration<T0>(arg1, v0), 2);
        settle<T0, T1>(arg0, arg2, arg3);
        let (_, v2) = 0x2::vec_map::remove<0x2::object::ID, u256>(0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::registrations_mut<T0>(arg1), &v0);
        let v3 = 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::value<T0>(arg1);
        let v4 = (v3 as u256) * arg0.cumulative_royalty_per_share - v2;
        let v5 = ((v4 / (1000000000000000000 as u256)) as u64);
        arg0.remainder = arg0.remainder + ((v4 % (1000000000000000000 as u256)) as u128);
        arg0.staked_shares = arg0.staked_shares - v3;
        let v6 = RoyaltyPoolStakeUnregisteredEvent<T1>{
            pool_id       : v0,
            stake_id      : 0x2::object::id<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(arg1),
            shares        : v3,
            value         : v5,
            balance       : 0x2::balance::value<T1>(&arg0.balance),
            staked_shares : arg0.staked_shares,
        };
        0x2::event::emit<RoyaltyPoolStakeUnregisteredEvent<T1>>(v6);
        0x2::balance::split<T1>(&mut arg0.balance, v5)
    }

    // decompiled from Move bytecode v7
}

