module 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::booster {
    struct BoostedCapDfKey has copy, drop, store {
        affected_address: address,
    }

    struct BoostedClaimCap has key {
        id: 0x2::object::UID,
        new_address: address,
    }

    public fun allow_boosted_claim(arg0: &0x2::package::Publisher, arg1: &mut 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::RefundPool, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::assert_publisher(arg0);
        0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::assert_claim_phase(arg1);
        0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::assert_address(arg1, arg2);
        let v0 = BoostedCapDfKey{affected_address: arg2};
        assert!(!0x2::dynamic_field::exists_<BoostedCapDfKey>(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::uid_mut(arg1), v0), 0);
        let v1 = BoostedClaimCap{
            id          : 0x2::object::new(arg4),
            new_address : arg3,
        };
        let v2 = BoostedCapDfKey{affected_address: arg2};
        0x2::dynamic_field::add<BoostedCapDfKey, bool>(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::uid_mut(arg1), v2, true);
        0x2::transfer::transfer<BoostedClaimCap>(v1, arg2);
    }

    public entry fun claim_refund_boosted(arg0: BoostedClaimCap, arg1: &mut 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::RefundPool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::assert_address(arg1, v0);
        let BoostedClaimCap {
            id          : v1,
            new_address : v2,
        } = arg0;
        0x2::object::delete(v1);
        let v3 = 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::claim_refund_(arg1, v0, arg2);
        let v4 = 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::math::div(*0x2::table::borrow<address, u64>(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::unclaimed(arg1), v0), 2);
        let v5 = 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::accounting::total_boosted_mut(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::accounting_mut(arg1));
        *v5 = *v5 + v4;
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v3), 0x2::balance::split<0x2::sui::SUI>(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::pool::funds_mut(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::booster_pool_mut(arg1)), v4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v2);
    }

    public fun current_liability_boosted(arg0: &0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::RefundPool) : u64 {
        let v0 = 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::accounting::current_liabilities(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::accounting(arg0));
        v0 + 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::math::div(v0, 2)
    }

    public entry fun fund(arg0: &mut 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::RefundPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::assert_funding_phase(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::accounting::total_raised_for_boost_mut(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::accounting_mut(arg0));
        *v1 = *v1 + v0;
        let v2 = 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::booster_pool_mut(arg0);
        0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::table::insert_or_add(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::pool::funders_mut(v2), 0x2::tx_context::sender(arg2), v0);
        0x2::balance::join<0x2::sui::SUI>(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::pool::funds_mut(v2), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun reclaim_fund(arg0: &mut 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::RefundPool, arg1: &mut 0x2::tx_context::TxContext) {
        0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::assert_reclaim_phase(arg0);
        0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::reclaim_funds_(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::booster_pool_mut(arg0), 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::accounting::total_raised_for_boost(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::accounting(arg0)), arg1);
    }

    public entry fun withdraw_funds(arg0: &mut 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::RefundPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::assert_funding_phase(arg0);
        let v0 = 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::accounting::total_raised_for_boost_mut(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::accounting_mut(arg0));
        *v0 = *v0 - arg1;
        let v1 = 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::refund::booster_pool_mut(arg0);
        0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::table::remove_or_subtract(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::pool::funders_mut(v1), 0x2::tx_context::sender(arg2), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::pool::funds_mut(v1), arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

