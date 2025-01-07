module 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::booster {
    struct BoostedCapDfKey has copy, drop, store {
        affected_address: address,
    }

    struct BoostedClaimCap has key {
        id: 0x2::object::UID,
        new_address: address,
    }

    public fun delete(arg0: BoostedClaimCap) {
        let BoostedClaimCap {
            id          : v0,
            new_address : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun allow_boosted_claim(arg0: &0x2::package::Publisher, arg1: &mut 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::RefundPool, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::assert_publisher(arg0);
        0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::assert_claim_phase(arg1);
        0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::assert_address(arg1, arg2);
        let v0 = BoostedCapDfKey{affected_address: arg2};
        assert!(!0x2::dynamic_field::exists_<BoostedCapDfKey>(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::uid_mut(arg1), v0), 0);
        let v1 = BoostedClaimCap{
            id          : 0x2::object::new(arg4),
            new_address : arg3,
        };
        let v2 = BoostedCapDfKey{affected_address: arg2};
        0x2::dynamic_field::add<BoostedCapDfKey, bool>(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::uid_mut(arg1), v2, true);
        0x2::transfer::transfer<BoostedClaimCap>(v1, arg2);
    }

    public entry fun claim_refund_boosted(arg0: BoostedClaimCap, arg1: &mut 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::RefundPool, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::assert_address(arg1, v0);
        let BoostedClaimCap {
            id          : v1,
            new_address : v2,
        } = arg0;
        assert!(arg2 == v2, 2);
        0x2::object::delete(v1);
        let v3 = 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::claim_refund_(arg1, v0, arg3, arg4);
        let v4 = 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::math::div(*0x2::table::borrow<address, u64>(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::unclaimed(arg1), v0), 2);
        let v5 = 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::accounting::total_boosted_mut(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::accounting_mut(arg1));
        *v5 = *v5 + v4;
        let v6 = 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::booster_pool_mut(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::pool::funds(v6)) >= v4, 1);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v3), 0x2::balance::split<0x2::sui::SUI>(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::pool::funds_mut(v6), v4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v2);
    }

    public fun current_liability_boosted(arg0: &0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::RefundPool) : u64 {
        let v0 = 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::accounting::current_liabilities(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::accounting(arg0));
        v0 + 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::math::div(v0, 2)
    }

    public entry fun fund(arg0: &mut 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::RefundPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::assert_funding_phase(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::accounting::total_raised_for_boost_mut(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::accounting_mut(arg0));
        *v1 = *v1 + v0;
        let v2 = 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::booster_pool_mut(arg0);
        0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::table::insert_or_add(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::pool::funders_mut(v2), 0x2::tx_context::sender(arg2), v0);
        0x2::balance::join<0x2::sui::SUI>(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::pool::funds_mut(v2), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun reclaim_funds(arg0: &mut 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::RefundPool, arg1: &mut 0x2::tx_context::TxContext) {
        0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::assert_reclaim_phase(arg0);
        0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::reclaim_funds_(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::booster_pool_mut(arg0), 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::accounting::total_raised_for_boost(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::accounting(arg0)), 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::accounting::total_unclaimed_boosted(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::accounting(arg0)), arg1);
    }

    public fun return_booster_cap(arg0: BoostedClaimCap, arg1: &mut 0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::RefundPool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::assert_claim_phase(arg1);
        0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::assert_address(arg1, v0);
        let BoostedClaimCap {
            id          : v1,
            new_address : _,
        } = arg0;
        0x2::object::delete(v1);
        let v3 = BoostedCapDfKey{affected_address: v0};
        0x2::dynamic_field::remove<BoostedCapDfKey, bool>(0x2843d7add326ac31e71c75954b79a059aa13456946d26422a9fd20f75e06b468::refund::uid_mut(arg1), v3);
    }

    // decompiled from Move bytecode v6
}

