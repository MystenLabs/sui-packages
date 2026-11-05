module 0x7209708976e58d654ec45aad7b25de9cc649735a1e67d73d71e41d345a431566::recording_revenue_share {
    struct RecordingRevenueShare<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        recording_id: 0x2::object::ID,
        composition_id: 0x2::object::ID,
        stake: 0x1::option::Option<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>,
    }

    struct RecordingRevenueShareTerms<phantom T0> has key {
        id: 0x2::object::UID,
        composition_id: 0x2::object::ID,
        rate: 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::BPS,
    }

    struct RecordingRevenueShareKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordingRevenueShareTermsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RevenueShareRecordingKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct RecordingRevenueShareCreatedEvent has copy, drop {
        revenue_share_id: 0x2::object::ID,
        recording_id: 0x2::object::ID,
        composition_id: 0x2::object::ID,
        rate_bps: u16,
        shares: u64,
        stake_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct RecordingRevenueShareSweptEvent<phantom T0> has copy, drop {
        recording_id: 0x2::object::ID,
        composition_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        value: u64,
    }

    struct RecordingRevenueShareStakeWithdrawnEvent has copy, drop {
        recording_id: 0x2::object::ID,
        composition_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
    }

    struct RecordingRevenueShareTermsCreatedEvent has copy, drop {
        terms_id: 0x2::object::ID,
        composition_id: 0x2::object::ID,
        rate_bps: u16,
    }

    struct RecordingRevenueShareTermsRateSetEvent has copy, drop {
        terms_id: 0x2::object::ID,
        composition_id: 0x2::object::ID,
        rate_bps: u16,
    }

    public fun derive_address<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>) : address {
        let v0 = RecordingRevenueShareKey{dummy_field: false};
        0x2::derived_object::derive_address<RecordingRevenueShareKey>(0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0), v0)
    }

    public fun composition_id<T0, T1>(arg0: &RecordingRevenueShare<T0, T1>) : 0x2::object::ID {
        arg0.composition_id
    }

    public fun new<T0, T1>(arg0: &mut RecordingRevenueShareTerms<T1>, arg1: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg2: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg3: &0x2::coin_registry::Currency<T0>, arg4: 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::BPS, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : RecordingRevenueShare<T0, T1> {
        let v0 = RecordingRevenueShareKey{dummy_field: false};
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::composition_id<T0>(arg1);
        assert!(arg0.composition_id == v1, 0);
        assert!(arg0.rate == arg4, 5);
        let v2 = 0x2::coin_registry::total_supply<T0>(arg3);
        if (0x1::option::is_some<u64>(&v2)) {
            assert!(0x2::balance::value<T0>(&arg5) == 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::apply(arg0.rate, 0x1::option::destroy_some<u64>(v2)), 1);
            let v3 = 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg1);
            let v4 = 0x2::balance::value<T0>(&arg5);
            let v5 = if (v4 > 0) {
                0x1::option::some<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::new<T0>(arg5, arg6))
            } else {
                0x2::balance::destroy_zero<T0>(arg5);
                0x1::option::none<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>()
            };
            let v6 = RecordingRevenueShare<T0, T1>{
                id             : 0x2::derived_object::claim<RecordingRevenueShareKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg1, arg2), v0),
                recording_id   : v3,
                composition_id : v1,
                stake          : v5,
            };
            let v7 = RevenueShareRecordingKey{pos0: v3};
            0x2::dynamic_field::add<RevenueShareRecordingKey, bool>(&mut arg0.id, v7, true);
            let v8 = &v6.stake;
            let v9 = if (0x1::option::is_some<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(v8)) {
                0x1::option::some<0x2::object::ID>(0x2::object::id<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(0x1::option::borrow<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(v8)))
            } else {
                0x1::option::none<0x2::object::ID>()
            };
            let v10 = RecordingRevenueShareCreatedEvent{
                revenue_share_id : 0x2::object::id<RecordingRevenueShare<T0, T1>>(&v6),
                recording_id     : v3,
                composition_id   : v1,
                rate_bps         : 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::value(arg0.rate),
                shares           : v4,
                stake_id         : v9,
            };
            0x2::event::emit<RecordingRevenueShareCreatedEvent>(v10);
            return v6
        } else {
            0x1::option::destroy_none<u64>(v2);
            abort 3
        };
    }

    public fun derive_terms_address<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>) : address {
        let v0 = RecordingRevenueShareTermsKey{dummy_field: false};
        0x2::derived_object::derive_address<RecordingRevenueShareTermsKey>(0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>>(arg0), v0)
    }

    public fun has_revenue_share<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>) : bool {
        let v0 = RecordingRevenueShareKey{dummy_field: false};
        0x2::derived_object::exists<RecordingRevenueShareKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    public fun has_terms<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>) : bool {
        let v0 = RecordingRevenueShareTermsKey{dummy_field: false};
        0x2::derived_object::exists<RecordingRevenueShareTermsKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid<T0>(arg0), v0)
    }

    public fun new_terms<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::CompositionAdminCap<T0>, arg2: 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::BPS) : RecordingRevenueShareTerms<T0> {
        let v0 = 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>>(arg0);
        let v1 = RecordingRevenueShareTermsKey{dummy_field: false};
        let v2 = RecordingRevenueShareTerms<T0>{
            id             : 0x2::derived_object::claim<RecordingRevenueShareTermsKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid_mut<T0>(arg0, arg1), v1),
            composition_id : v0,
            rate           : arg2,
        };
        let v3 = RecordingRevenueShareTermsCreatedEvent{
            terms_id       : 0x2::object::id<RecordingRevenueShareTerms<T0>>(&v2),
            composition_id : v0,
            rate_bps       : 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::value(arg2),
        };
        0x2::event::emit<RecordingRevenueShareTermsCreatedEvent>(v3);
        v2
    }

    public fun recording_id<T0, T1>(arg0: &RecordingRevenueShare<T0, T1>) : 0x2::object::ID {
        arg0.recording_id
    }

    public fun recording_revenue_share_terms_composition_id<T0>(arg0: &RecordingRevenueShareTerms<T0>) : 0x2::object::ID {
        arg0.composition_id
    }

    public fun recording_revenue_share_terms_has_recording<T0>(arg0: &RecordingRevenueShareTerms<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = RevenueShareRecordingKey{pos0: arg1};
        0x2::dynamic_field::exists<RevenueShareRecordingKey>(&arg0.id, v0)
    }

    public fun recording_revenue_share_terms_rate<T0>(arg0: &RecordingRevenueShareTerms<T0>) : 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::BPS {
        arg0.rate
    }

    public fun register<T0, T1, T2>(arg0: &mut RecordingRevenueShare<T0, T1>, arg1: &mut 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::RoyaltyPool<T0, T2>, arg2: &0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::RoyaltyPool<T1, T2>, arg3: &0x2::accumulator::AccumulatorRoot, arg4: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(&arg0.stake), 2);
        0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::register_stake<T0, T2>(arg1, 0x1::option::borrow_mut<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(&mut arg0.stake), arg3, arg4);
    }

    public fun set_rate<T0>(arg0: &mut RecordingRevenueShareTerms<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::CompositionAdminCap<T0>, arg2: 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::BPS) {
        if (arg0.rate == arg2) {
            return
        };
        arg0.rate = arg2;
        let v0 = RecordingRevenueShareTermsRateSetEvent{
            terms_id       : 0x2::object::id<RecordingRevenueShareTerms<T0>>(arg0),
            composition_id : arg0.composition_id,
            rate_bps       : 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::value(arg2),
        };
        0x2::event::emit<RecordingRevenueShareTermsRateSetEvent>(v0);
    }

    public fun share<T0, T1>(arg0: RecordingRevenueShare<T0, T1>) {
        0x2::transfer::share_object<RecordingRevenueShare<T0, T1>>(arg0);
    }

    public fun share_terms<T0>(arg0: RecordingRevenueShareTerms<T0>) {
        0x2::transfer::share_object<RecordingRevenueShareTerms<T0>>(arg0);
    }

    public fun stake<T0, T1>(arg0: &RecordingRevenueShare<T0, T1>) : &0x1::option::Option<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>> {
        &arg0.stake
    }

    public fun sweep<T0, T1, T2>(arg0: &mut RecordingRevenueShare<T0, T1>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T1>, arg2: &mut 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::RoyaltyPool<T0, T2>, arg3: &0x2::accumulator::AccumulatorRoot, arg4: &0x2::clock::Clock) : u64 {
        assert!(0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T1>>(arg1) == arg0.composition_id, 4);
        if (0x1::option::is_none<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(&arg0.stake)) {
            return 0
        };
        let v0 = 0x1::option::borrow_mut<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(&mut arg0.stake);
        if (!0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::has_registration<T0>(v0, 0x2::object::id<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::RoyaltyPool<T0, T2>>(arg2))) {
            return 0
        };
        0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::settle<T0, T2>(arg2, arg3, arg4);
        let v1 = 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::claim_royalties<T0, T2>(arg2, v0);
        let v2 = 0x2::balance::value<T2>(&v1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T2>(v1);
            return 0
        };
        0x2::balance::send_funds<T2>(v1, 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool::derive_composition_pool_address<T1, T2>(arg1));
        let v3 = RecordingRevenueShareSweptEvent<T2>{
            recording_id   : arg0.recording_id,
            composition_id : arg0.composition_id,
            stake_id       : 0x2::object::id<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(v0),
            value          : v2,
        };
        0x2::event::emit<RecordingRevenueShareSweptEvent<T2>>(v3);
        v2
    }

    public fun withdraw<T0, T1>(arg0: &mut RecordingRevenueShare<T0, T1>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::CompositionAdminCap<T1>) : 0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0> {
        assert!(0x1::option::is_some<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(&arg0.stake), 2);
        let v0 = 0x1::option::extract<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(&mut arg0.stake);
        let v1 = RecordingRevenueShareStakeWithdrawnEvent{
            recording_id   : arg0.recording_id,
            composition_id : arg0.composition_id,
            stake_id       : 0x2::object::id<0x155434bddf7ccc477e3a03676900b49b295a031230b5e19021cfa5b092a8bcbf::royalty_pool_stake::RoyaltyPoolStake<T0>>(&v0),
        };
        0x2::event::emit<RecordingRevenueShareStakeWithdrawnEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

