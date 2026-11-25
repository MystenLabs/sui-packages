module 0x8f761cfd99fcc7ef8587736aaa2facb761f4a586edc748e8946a4adde1f9db74::royalty_advance {
    struct RoyaltyAdvanceOffer<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        payment: 0x2::balance::Balance<T1>,
        provider: address,
        owner: address,
        shares: u64,
        terms: 0xfd90faa64ce1ab82027cafff185139adf818a03ae058651b10d9c0a491bda5d::royalty_grant::RoyaltyGrantTerms,
        expires_at_ms: u64,
    }

    struct RoyaltyAdvanceOfferProviderCap has store, key {
        id: 0x2::object::UID,
        offer_id: 0x2::object::ID,
    }

    struct RoyaltyAdvanceOfferProviderCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RoyaltyAdvanceOfferCreatedEvent<phantom T0, phantom T1> has copy, drop {
        offer_id: 0x2::object::ID,
        provider: address,
        owner: address,
        value: u64,
        shares: u64,
        recipient_share_bps: u16,
        repayment_value: 0x1::option::Option<u64>,
        duration_ms: 0x1::option::Option<u64>,
        expires_at_ms: u64,
    }

    struct RoyaltyAdvanceOfferAcceptedEvent has copy, drop {
        offer_id: 0x2::object::ID,
        grant_id: 0x2::object::ID,
        provider: address,
        owner: address,
        value: u64,
    }

    struct RoyaltyAdvanceOfferCancelledEvent has copy, drop {
        offer_id: 0x2::object::ID,
        provider: address,
        value: u64,
    }

    public fun new<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: address, arg2: address, arg3: u64, arg4: 0xfd90faa64ce1ab82027cafff185139adf818a03ae058651b10d9c0a491bda5d::royalty_grant::RoyaltyGrantTerms, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (RoyaltyAdvanceOffer<T0, T1>, RoyaltyAdvanceOfferProviderCap) {
        let v0 = 0x2::balance::value<T1>(&arg0);
        assert!(v0 > 0, 0);
        assert!(arg3 > 0, 1);
        assert!(arg5 > 0x2::clock::timestamp_ms(0x2::clock::borrow()), 2);
        let v1 = 0x2::object::new(arg6);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = RoyaltyAdvanceOfferProviderCapKey{dummy_field: false};
        let v4 = RoyaltyAdvanceOfferProviderCap{
            id       : 0x2::derived_object::claim<RoyaltyAdvanceOfferProviderCapKey>(&mut v1, v3),
            offer_id : v2,
        };
        let v5 = RoyaltyAdvanceOfferCreatedEvent<T0, T1>{
            offer_id            : v2,
            provider            : arg1,
            owner               : arg2,
            value               : v0,
            shares              : arg3,
            recipient_share_bps : 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::value(0xfd90faa64ce1ab82027cafff185139adf818a03ae058651b10d9c0a491bda5d::royalty_grant::royalty_grant_terms_recipient_share(&arg4)),
            repayment_value     : 0xfd90faa64ce1ab82027cafff185139adf818a03ae058651b10d9c0a491bda5d::royalty_grant::royalty_grant_terms_repayment_value(&arg4),
            duration_ms         : 0xfd90faa64ce1ab82027cafff185139adf818a03ae058651b10d9c0a491bda5d::royalty_grant::royalty_grant_terms_duration_ms(&arg4),
            expires_at_ms       : arg5,
        };
        0x2::event::emit<RoyaltyAdvanceOfferCreatedEvent<T0, T1>>(v5);
        let v6 = RoyaltyAdvanceOffer<T0, T1>{
            id            : v1,
            payment       : arg0,
            provider      : arg1,
            owner         : arg2,
            shares        : arg3,
            terms         : arg4,
            expires_at_ms : arg5,
        };
        (v6, v4)
    }

    public fun accept<T0, T1>(arg0: RoyaltyAdvanceOffer<T0, T1>, arg1: &mut 0x9fdbcfb4c33b619b9d8cd85b9707ed09f58acfb39cca4e5c0cb1fa0ed99b7904::royalty_pool::RoyaltyPool<T0, T1>, arg2: 0x9fdbcfb4c33b619b9d8cd85b9707ed09f58acfb39cca4e5c0cb1fa0ed99b7904::royalty_pool_stake::RoyaltyPoolStake<T0>, arg3: &0x2::accumulator::AccumulatorRoot, arg4: &mut 0x2::tx_context::TxContext) : (0xfd90faa64ce1ab82027cafff185139adf818a03ae058651b10d9c0a491bda5d::royalty_grant::RoyaltyGrant<T0, T1>, 0xfd90faa64ce1ab82027cafff185139adf818a03ae058651b10d9c0a491bda5d::royalty_grant::RoyaltyGrantOwnerCap) {
        let RoyaltyAdvanceOffer {
            id            : v0,
            payment       : v1,
            provider      : v2,
            owner         : v3,
            shares        : v4,
            terms         : v5,
            expires_at_ms : v6,
        } = arg0;
        let v7 = v1;
        let v8 = v0;
        assert!(0x2::clock::timestamp_ms(0x2::clock::borrow()) < v6, 2);
        assert!(0x9fdbcfb4c33b619b9d8cd85b9707ed09f58acfb39cca4e5c0cb1fa0ed99b7904::royalty_pool_stake::value<T0>(&arg2) == v4, 3);
        0x2::balance::send_funds<T1>(v7, v3);
        let (v9, v10, v11) = 0xfd90faa64ce1ab82027cafff185139adf818a03ae058651b10d9c0a491bda5d::royalty_grant::new_active<T0, T1>(arg1, arg2, v3, v2, v5, arg3, arg4);
        let v12 = v9;
        0x2::transfer::public_transfer<0xfd90faa64ce1ab82027cafff185139adf818a03ae058651b10d9c0a491bda5d::royalty_grant::RoyaltyGrantRecipientCap>(v11, v2);
        let v13 = RoyaltyAdvanceOfferAcceptedEvent{
            offer_id : 0x2::object::uid_to_inner(&v8),
            grant_id : 0x2::object::id<0xfd90faa64ce1ab82027cafff185139adf818a03ae058651b10d9c0a491bda5d::royalty_grant::RoyaltyGrant<T0, T1>>(&v12),
            provider : v2,
            owner    : v3,
            value    : 0x2::balance::value<T1>(&v7),
        };
        0x2::event::emit<RoyaltyAdvanceOfferAcceptedEvent>(v13);
        0x2::object::delete(v8);
        (v12, v10)
    }

    public fun cancel<T0, T1>(arg0: RoyaltyAdvanceOffer<T0, T1>, arg1: RoyaltyAdvanceOfferProviderCap) {
        assert!(arg1.offer_id == 0x2::object::uid_to_inner(&arg0.id), 5);
        let RoyaltyAdvanceOffer {
            id            : v0,
            payment       : v1,
            provider      : v2,
            owner         : _,
            shares        : _,
            terms         : _,
            expires_at_ms : _,
        } = arg0;
        let v7 = v0;
        let RoyaltyAdvanceOfferProviderCap {
            id       : v8,
            offer_id : _,
        } = arg1;
        0x2::derived_object::release(&mut v7, v8);
        refund_and_delete<T1>(v7, v1, v2);
    }

    public fun cancel_expired<T0, T1>(arg0: RoyaltyAdvanceOffer<T0, T1>) {
        assert!(0x2::clock::timestamp_ms(0x2::clock::borrow()) >= arg0.expires_at_ms, 4);
        let RoyaltyAdvanceOffer {
            id            : v0,
            payment       : v1,
            provider      : v2,
            owner         : _,
            shares        : _,
            terms         : _,
            expires_at_ms : _,
        } = arg0;
        refund_and_delete<T1>(v0, v1, v2);
    }

    public fun derive_provider_cap_address<T0, T1>(arg0: &RoyaltyAdvanceOffer<T0, T1>) : address {
        let v0 = RoyaltyAdvanceOfferProviderCapKey{dummy_field: false};
        0x2::derived_object::derive_address<RoyaltyAdvanceOfferProviderCapKey>(0x2::object::id<RoyaltyAdvanceOffer<T0, T1>>(arg0), v0)
    }

    public fun destroy_provider_cap(arg0: RoyaltyAdvanceOfferProviderCap) {
        let RoyaltyAdvanceOfferProviderCap {
            id       : v0,
            offer_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun expires_at_ms<T0, T1>(arg0: &RoyaltyAdvanceOffer<T0, T1>) : u64 {
        arg0.expires_at_ms
    }

    public fun owner<T0, T1>(arg0: &RoyaltyAdvanceOffer<T0, T1>) : address {
        arg0.owner
    }

    public fun payment_value<T0, T1>(arg0: &RoyaltyAdvanceOffer<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.payment)
    }

    public fun provider<T0, T1>(arg0: &RoyaltyAdvanceOffer<T0, T1>) : address {
        arg0.provider
    }

    fun refund_and_delete<T0>(arg0: 0x2::object::UID, arg1: 0x2::balance::Balance<T0>, arg2: address) {
        0x2::balance::send_funds<T0>(arg1, arg2);
        let v0 = RoyaltyAdvanceOfferCancelledEvent{
            offer_id : 0x2::object::uid_to_inner(&arg0),
            provider : arg2,
            value    : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<RoyaltyAdvanceOfferCancelledEvent>(v0);
        0x2::object::delete(arg0);
    }

    public fun royalty_advance_offer_provider_cap_offer_id(arg0: &RoyaltyAdvanceOfferProviderCap) : 0x2::object::ID {
        arg0.offer_id
    }

    public fun share<T0, T1>(arg0: RoyaltyAdvanceOffer<T0, T1>) {
        0x2::transfer::share_object<RoyaltyAdvanceOffer<T0, T1>>(arg0);
    }

    public fun shares<T0, T1>(arg0: &RoyaltyAdvanceOffer<T0, T1>) : u64 {
        arg0.shares
    }

    public fun terms<T0, T1>(arg0: &RoyaltyAdvanceOffer<T0, T1>) : 0xfd90faa64ce1ab82027cafff185139adf818a03ae058651b10d9c0a491bda5d::royalty_grant::RoyaltyGrantTerms {
        arg0.terms
    }

    // decompiled from Move bytecode v7
}

