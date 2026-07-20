module 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::subscription {
    struct SubscriptionCreated has copy, drop {
        subscription_id: 0x2::object::ID,
        publication_id: 0x2::object::ID,
        expires_at: u64,
        creator_revenue: u64,
        fee: u64,
    }

    struct SubscriptionRenewed has copy, drop {
        subscription_id: 0x2::object::ID,
        new_expiry: u64,
        creator_revenue: u64,
        fee: u64,
    }

    struct SubscriptionTransferred has copy, drop {
        subscription_id: 0x2::object::ID,
        recipient: address,
    }

    struct SubscriptionReceived has copy, drop {
        subscription_id: 0x2::object::ID,
        parent_id: 0x2::object::ID,
    }

    struct SubscriptionNFT has key {
        id: 0x2::object::UID,
        publication_id: 0x2::object::ID,
        subscribed_at: u64,
        expires_at: u64,
    }

    struct GiftedSubscription has key {
        id: 0x2::object::UID,
        publication_id: 0x2::object::ID,
        subscribed_at: u64,
        expires_at: u64,
    }

    public fun id(arg0: &SubscriptionNFT) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun transfer(arg0: SubscriptionNFT, arg1: address) {
        let v0 = SubscriptionTransferred{
            subscription_id : 0x2::object::id<SubscriptionNFT>(&arg0),
            recipient       : arg1,
        };
        0x2::event::emit<SubscriptionTransferred>(v0);
        0x2::transfer::transfer<SubscriptionNFT>(arg0, arg1);
    }

    public fun receive(arg0: &mut 0x2::object::UID, arg1: 0x2::transfer::Receiving<SubscriptionNFT>) : SubscriptionNFT {
        let v0 = 0x2::transfer::receive<SubscriptionNFT>(arg0, arg1);
        let v1 = SubscriptionReceived{
            subscription_id : 0x2::object::id<SubscriptionNFT>(&v0),
            parent_id       : 0x2::object::uid_to_inner(arg0),
        };
        0x2::event::emit<SubscriptionReceived>(v1);
        v0
    }

    fun compute_required_payment_for_publication(arg0: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg1: u64) : u64 {
        let v0 = 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::monthly_price(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 1);
        let v1 = 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::price_for_months(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v1), 4);
        assert!(*0x1::option::borrow<u64>(&v1) > 0, 6);
        *0x1::option::borrow<u64>(&v1)
    }

    public fun expires_at(arg0: &SubscriptionNFT) : u64 {
        arg0.expires_at
    }

    public fun gift(arg0: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg1: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Member, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::verify_member_permissions(arg0, arg1, 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::member_permission::new_gift_subscription_permission());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = GiftedSubscription{
            id             : 0x2::object::new(arg5),
            publication_id : 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::id(arg0),
            subscribed_at  : v0,
            expires_at     : v0 + arg2,
        };
        0x2::transfer::transfer<GiftedSubscription>(v1, arg3);
    }

    public fun gifted_expires_at(arg0: &GiftedSubscription) : u64 {
        arg0.expires_at
    }

    public fun gifted_id(arg0: &GiftedSubscription) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun gifted_publication_id(arg0: &GiftedSubscription) : 0x2::object::ID {
        arg0.publication_id
    }

    public fun gifted_subscribed_at(arg0: &GiftedSubscription) : u64 {
        arg0.subscribed_at
    }

    public fun has_gifted_paid_access(arg0: &GiftedSubscription, arg1: &0x2::clock::Clock) : bool {
        if (!is_gifted_valid(arg0, arg1)) {
            return false
        };
        true
    }

    public fun has_paid_access(arg0: &SubscriptionNFT, arg1: &0x2::clock::Clock) : bool {
        if (!is_valid(arg0, arg1)) {
            return false
        };
        true
    }

    public fun is_gifted_valid(arg0: &GiftedSubscription, arg1: &0x2::clock::Clock) : bool {
        arg0.expires_at > 0x2::clock::timestamp_ms(arg1) / 1000
    }

    public fun is_valid(arg0: &SubscriptionNFT, arg1: &0x2::clock::Clock) : bool {
        arg0.expires_at > 0x2::clock::timestamp_ms(arg1) / 1000
    }

    public fun publication_id(arg0: &SubscriptionNFT) : 0x2::object::ID {
        arg0.publication_id
    }

    public fun renew(arg0: &mut SubscriptionNFT, arg1: &mut 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg2: &mut 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::treasury::Treasury, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::id(arg1);
        assert!(arg0.publication_id == v0, 3);
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        assert!(v1 == compute_required_payment_for_publication(arg1, arg4), 2);
        let v2 = 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::treasury::collect_subscription_fee(arg2, &mut arg3, v0, 0x2::tx_context::sender(arg6), arg6);
        0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::increase_revenues(arg1, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3), arg6);
        let v3 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v4 = 2592000 * arg4;
        if (arg0.expires_at > v3) {
            assert!(arg0.expires_at - v3 <= v4, 5);
            arg0.expires_at = arg0.expires_at + v4;
        } else {
            arg0.expires_at = v3 + v4;
        };
        let v5 = SubscriptionRenewed{
            subscription_id : 0x2::object::id<SubscriptionNFT>(arg0),
            new_expiry      : arg0.expires_at,
            creator_revenue : v2,
            fee             : v1 - v2,
        };
        0x2::event::emit<SubscriptionRenewed>(v5);
    }

    public fun subscribe(arg0: &mut 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg1: &mut 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::treasury::Treasury, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : SubscriptionNFT {
        let v0 = 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::id(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v2 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2);
        assert!(v2 == compute_required_payment_for_publication(arg0, arg3), 2);
        let v3 = 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::treasury::collect_subscription_fee(arg1, &mut arg2, v0, 0x2::tx_context::sender(arg5), arg5);
        0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::increase_revenues(arg0, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2), arg5);
        let v4 = v1 + 2592000 * arg3;
        let v5 = SubscriptionNFT{
            id             : 0x2::object::new(arg5),
            publication_id : v0,
            subscribed_at  : v1,
            expires_at     : v4,
        };
        let v6 = SubscriptionCreated{
            subscription_id : 0x2::object::id<SubscriptionNFT>(&v5),
            publication_id  : v0,
            expires_at      : v4,
            creator_revenue : v3,
            fee             : v2 - v3,
        };
        0x2::event::emit<SubscriptionCreated>(v6);
        v5
    }

    public fun subscribed_at(arg0: &SubscriptionNFT) : u64 {
        arg0.subscribed_at
    }

    // decompiled from Move bytecode v7
}

