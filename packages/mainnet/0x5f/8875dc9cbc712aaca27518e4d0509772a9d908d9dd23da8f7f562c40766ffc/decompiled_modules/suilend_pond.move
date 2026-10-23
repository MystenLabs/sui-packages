module 0x5f2b0aef30f44cc063e3f26ea86b432edf945ba84aa6cd7187cb88aec4e5a400::suilend_pond {
    struct SuilendPondType has copy, drop, store {
        dummy_field: bool,
    }

    struct SuilendTestSuiMarket has copy, drop, store {
        dummy_field: bool,
    }

    struct SuilendTestUsdcMarket has copy, drop, store {
        dummy_field: bool,
    }

    struct PoolCtokens<phantom T0, phantom T1> has store {
        pool_id: 0x2::object::ID,
        ctoken_amount: u64,
    }

    struct SuilendPond<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        lending_market_id: 0x2::object::ID,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        reserve_index: u64,
        ctokens_by_pool: vector<PoolCtokens<T0, T1>>,
    }

    struct PondCreatedEvent<phantom T0, phantom T1> has copy, drop {
        pond_id: 0x2::object::ID,
        lending_market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        reserve_index: u64,
    }

    struct DepositFromPoolEvent<phantom T0> has copy, drop {
        pond_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reserve_index: u64,
        amount: u64,
        minted_ctokens: u64,
        pool_ctoken_balance_after: u64,
        pipe_debt_after: u64,
    }

    struct WithdrawToPoolEvent<phantom T0> has copy, drop {
        pond_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reserve_index: u64,
        requested_amount: u64,
        burned_ctokens: u64,
        returned_amount: u64,
        debt_repaid_amount: u64,
        interest_redirected_to_private_pool: u64,
        pool_ctoken_balance_after: u64,
        pipe_debt_after: u64,
    }

    struct InterestClaimedToPrivatePoolEvent<phantom T0> has copy, drop {
        pond_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reserve_index: u64,
        redeemed_ctokens: u64,
        interest_amount: u64,
        reserved_ctokens_for_debt: u64,
        pool_ctoken_balance_after: u64,
        pipe_debt_after: u64,
    }

    struct RewardClaimedToPrivatePoolEvent<phantom T0, phantom T1> has copy, drop {
        pond_id: 0x2::object::ID,
        reward_reserve_index: u64,
        reward_index: u64,
        is_deposit_reward: bool,
        amount: u64,
    }

    public fun id<T0, T1>(arg0: &SuilendPond<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun admin_claim_interest_to_private_pool<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg4: &0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        claim_interest_to_private_pool_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
    }

    public fun admin_claim_reward_to_private_pool<T0, T1, T2>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        claim_reward_to_private_pool_internal<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun admin_claim_sui_interest_to_private_pool<T0>(arg0: &mut SuilendPond<T0, 0x2::sui::SUI>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg4: &0x2::object::ID, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        claim_sui_interest_to_private_pool_internal<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
    }

    public fun admin_claimable_interest_amount<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg4: &0x2::object::ID, arg5: &0x2::clock::Clock) : u64 {
        let (v0, _, _, _, _) = admin_interest_quote<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        v0
    }

    public fun admin_create<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = create_internal<T0, T1>(arg0, arg1, arg2, arg4);
        0x2::transfer::share_object<SuilendPond<T0, T1>>(v0);
        0x2::object::uid_to_inner(&v0.id)
    }

    public fun admin_deposit_from_pool<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg4: &0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        deposit_from_pool_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
    }

    public fun admin_interest_quote<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg4: &0x2::object::ID, arg5: &0x2::clock::Clock) : (u64, u64, u64, u64, u64) {
        interest_quote_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5)
    }

    public fun admin_withdraw_sui_to_pool<T0>(arg0: &mut SuilendPond<T0, 0x2::sui::SUI>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg4: &0x2::object::ID, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        withdraw_sui_to_pool_internal<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8);
    }

    public fun admin_withdraw_to_pool<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg4: &0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        withdraw_to_pool_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
    }

    fun assert_lending_market<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        assert!(0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1) == arg0.lending_market_id, 13838717736786853909);
    }

    fun borrow_ctokens_bucket_mut<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &0x2::object::ID) : &mut PoolCtokens<T0, T1> {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        while (v0 < 0x1::vector::length<PoolCtokens<T0, T1>>(&arg0.ctokens_by_pool)) {
            if (0x1::vector::borrow<PoolCtokens<T0, T1>>(&arg0.ctokens_by_pool, v0).pool_id == *arg1) {
                v1 = true;
                v2 = v0;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 13837592296440987661);
        0x1::vector::borrow_mut<PoolCtokens<T0, T1>>(&mut arg0.ctokens_by_pool, v2)
    }

    fun borrow_or_create_ctokens_bucket_mut<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &0x2::object::ID) : &mut PoolCtokens<T0, T1> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PoolCtokens<T0, T1>>(&arg0.ctokens_by_pool)) {
            let v1 = 0x1::vector::borrow_mut<PoolCtokens<T0, T1>>(&mut arg0.ctokens_by_pool, v0);
            if (v1.pool_id == *arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        let v2 = PoolCtokens<T0, T1>{
            pool_id       : *arg1,
            ctoken_amount : 0,
        };
        0x1::vector::push_back<PoolCtokens<T0, T1>>(&mut arg0.ctokens_by_pool, v2);
        0x1::vector::borrow_mut<PoolCtokens<T0, T1>>(&mut arg0.ctokens_by_pool, 0x1::vector::length<PoolCtokens<T0, T1>>(&arg0.ctokens_by_pool) - 1)
    }

    fun claim_interest_to_private_pool_internal<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = take_claimable_interest_ctokens<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v3 = v0;
        settle_interest_claim<T0, T1>(arg0, arg2, arg3, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v3), v1, v2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg0.reserve_index, arg4, v3, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5));
    }

    fun claim_reward_to_private_pool_internal<T0, T1, T2>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert_lending_market<T0, T1>(arg0, arg1);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T2>(arg1, &arg0.obligation_owner_cap, arg6, arg3, arg4, arg5, arg7);
        let v1 = 0x2::coin::value<T2>(&v0);
        if (v1 > 0) {
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::deposit_private_pool<T2>(arg2, v0);
            let v2 = RewardClaimedToPrivatePoolEvent<T1, T2>{
                pond_id              : 0x2::object::uid_to_inner(&arg0.id),
                reward_reserve_index : arg3,
                reward_index         : arg4,
                is_deposit_reward    : arg5,
                amount               : v1,
            };
            0x2::event::emit<RewardClaimedToPrivatePoolEvent<T1, T2>>(v2);
        } else {
            0x2::coin::destroy_zero<T2>(v0);
        };
        v1
    }

    fun claim_sui_interest_to_private_pool_internal<T0>(arg0: &mut SuilendPond<T0, 0x2::sui::SUI>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0x2::object::ID, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = take_claimable_interest_ctokens<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg5, arg6);
        let v3 = v0;
        settle_interest_claim<T0, 0x2::sui::SUI>(arg0, arg2, arg3, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>(&v3), v1, v2, redeem_sui_ctokens<T0>(arg1, arg0.reserve_index, v3, arg4, arg5, arg6));
    }

    fun create_internal<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : SuilendPond<T0, T1> {
        let v0 = 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg0);
        assert!(arg1 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v1), 13836465984216760325);
        let v2 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v1, arg1);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::coin_type<T0>(v2) == 0x1::type_name::with_defining_ids<T1>(), 13835340101489524737);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(v2, arg2)) > 0, 13837310439212056587);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg3);
        let v4 = SuilendPond<T0, T1>{
            id                   : 0x2::object::new(arg3),
            lending_market_id    : v0,
            obligation_owner_cap : v3,
            reserve_index        : arg1,
            ctokens_by_pool      : 0x1::vector::empty<PoolCtokens<T0, T1>>(),
        };
        let v5 = PondCreatedEvent<T0, T1>{
            pond_id           : 0x2::object::uid_to_inner(&v4.id),
            lending_market_id : v0,
            obligation_id     : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v3),
            reserve_index     : arg1,
        };
        0x2::event::emit<PondCreatedEvent<T0, T1>>(v5);
        v4
    }

    public fun ctoken_balance<T0, T1>(arg0: &SuilendPond<T0, T1>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<PoolCtokens<T0, T1>>(&arg0.ctokens_by_pool)) {
            v1 = v1 + 0x1::vector::borrow<PoolCtokens<T0, T1>>(&arg0.ctokens_by_pool, v0).ctoken_amount;
            v0 = v0 + 1;
        };
        v1
    }

    public fun ctoken_balance_for_pool<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &0x2::object::ID) : u64 {
        ctoken_balance_for_pool_internal<T0, T1>(arg0, arg1)
    }

    fun ctoken_balance_for_pool_internal<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &0x2::object::ID) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PoolCtokens<T0, T1>>(&arg0.ctokens_by_pool)) {
            let v1 = 0x1::vector::borrow<PoolCtokens<T0, T1>>(&arg0.ctokens_by_pool, v0);
            if (v1.pool_id == *arg1) {
                return v1.ctoken_amount
            };
            v0 = v0 + 1;
        };
        0
    }

    fun deposit_from_pool_internal<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 13836747996064514055);
        assert_lending_market<T0, T1>(arg0, arg1);
        let v0 = pond_marker();
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, arg0.reserve_index, arg5, 0x2::coin::from_balance<T1>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_from_pipe<T1, SuilendPondType>(arg2, &v0, arg3, &v1, arg4), arg6), arg6);
        let v3 = 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v2);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, arg0.reserve_index, &arg0.obligation_owner_cap, arg5, v2, arg6);
        let v4 = borrow_or_create_ctokens_bucket_mut<T0, T1>(arg0, arg3);
        v4.ctoken_amount = v4.ctoken_amount + v3;
        let v5 = DepositFromPoolEvent<T1>{
            pond_id                   : v1,
            pool_id                   : *arg3,
            reserve_index             : arg0.reserve_index,
            amount                    : arg4,
            minted_ctokens            : v3,
            pool_ctoken_balance_after : ctoken_balance_for_pool_internal<T0, T1>(arg0, arg3),
            pipe_debt_after           : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::pipe_debt_value<T1, SuilendPondType>(arg2, arg3, &v1),
        };
        0x2::event::emit<DepositFromPoolEvent<T1>>(v5);
    }

    fun interest_quote_internal<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0x2::object::ID, arg4: &0x2::clock::Clock) : (u64, u64, u64, u64, u64) {
        assert_lending_market<T0, T1>(arg0, arg1);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::pipe_debt_value<T1, SuilendPondType>(arg2, arg3, &v0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), arg0.reserve_index), arg4);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v2) > 0, 13837313956790272011);
        let v3 = if (v1 == 0) {
            0
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v1), v2))
        };
        let v4 = ctoken_balance_for_pool_internal<T0, T1>(arg0, arg3);
        let v5 = if (v4 > v3) {
            v4 - v3
        } else {
            0
        };
        let v6 = if (v5 == 0) {
            0
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v5), v2))
        };
        (v6, v5, v3, v4, v1)
    }

    public fun lending_market_id<T0, T1>(arg0: &SuilendPond<T0, T1>) : 0x2::object::ID {
        arg0.lending_market_id
    }

    public fun manager_claim_interest_to_private_pool<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg4: &0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SuilendPondType>(arg3, 0x2::tx_context::sender(arg6));
        claim_interest_to_private_pool_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
    }

    public fun manager_claim_reward_to_private_pool<T0, T1, T2>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SuilendPondType>(arg3, 0x2::tx_context::sender(arg8));
        claim_reward_to_private_pool_internal<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun manager_claim_sui_interest_to_private_pool<T0>(arg0: &mut SuilendPond<T0, 0x2::sui::SUI>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg4: &0x2::object::ID, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SuilendPondType>(arg3, 0x2::tx_context::sender(arg7));
        claim_sui_interest_to_private_pool_internal<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
    }

    public fun manager_claimable_interest_amount<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg4: &0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : u64 {
        let (v0, _, _, _, _) = manager_interest_quote<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        v0
    }

    public fun manager_create<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SuilendPondType>(arg3, 0x2::tx_context::sender(arg4));
        let v0 = create_internal<T0, T1>(arg0, arg1, arg2, arg4);
        0x2::transfer::share_object<SuilendPond<T0, T1>>(v0);
        0x2::object::uid_to_inner(&v0.id)
    }

    public fun manager_deposit_from_pool<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg4: &0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SuilendPondType>(arg3, 0x2::tx_context::sender(arg7));
        deposit_from_pool_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
    }

    public fun manager_interest_quote<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg4: &0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SuilendPondType>(arg3, 0x2::tx_context::sender(arg6));
        interest_quote_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5)
    }

    public fun manager_withdraw_sui_to_pool<T0>(arg0: &mut SuilendPond<T0, 0x2::sui::SUI>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg4: &0x2::object::ID, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SuilendPondType>(arg3, 0x2::tx_context::sender(arg8));
        withdraw_sui_to_pool_internal<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8);
    }

    public fun manager_withdraw_to_pool<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg4: &0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SuilendPondType>(arg3, 0x2::tx_context::sender(arg7));
        withdraw_to_pool_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
    }

    public fun obligation_id<T0, T1>(arg0: &SuilendPond<T0, T1>) : 0x2::object::ID {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)
    }

    fun pond_marker() : SuilendPondType {
        SuilendPondType{dummy_field: false}
    }

    fun redeem_sui_ctokens<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg1, arg4, arg2, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, arg1, &v0, arg3, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg1, v0, arg5)
    }

    public fun reserve_index<T0, T1>(arg0: &SuilendPond<T0, T1>) : u64 {
        arg0.reserve_index
    }

    fun settle_interest_claim<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg2: &0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg6);
        assert!(v0 > 0, 13838157518432370705);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::deposit_private_pool<T1>(arg1, arg6);
        let v1 = InterestClaimedToPrivatePoolEvent<T1>{
            pond_id                   : 0x2::object::uid_to_inner(&arg0.id),
            pool_id                   : *arg2,
            reserve_index             : arg0.reserve_index,
            redeemed_ctokens          : arg3,
            interest_amount           : v0,
            reserved_ctokens_for_debt : arg4,
            pool_ctoken_balance_after : ctoken_balance_for_pool_internal<T0, T1>(arg0, arg2),
            pipe_debt_after           : arg5,
        };
        0x2::event::emit<InterestClaimedToPrivatePoolEvent<T1>>(v1);
    }

    fun settle_withdraw_to_pool<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg2: &0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = pond_marker();
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0x2::coin::value<T1>(&arg5);
        assert!(v2 >= arg3, 13838437868127780883);
        let v3 = v2 - arg3;
        if (v3 > 0) {
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::deposit_private_pool<T1>(arg1, 0x2::coin::split<T1>(&mut arg5, v3, arg6));
        };
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_put_into_pipe<T1, SuilendPondType>(arg1, &v0, arg2, &v1, 0x2::coin::into_balance<T1>(arg5));
        let v4 = WithdrawToPoolEvent<T1>{
            pond_id                             : v1,
            pool_id                             : *arg2,
            reserve_index                       : arg0.reserve_index,
            requested_amount                    : arg3,
            burned_ctokens                      : arg4,
            returned_amount                     : v2,
            debt_repaid_amount                  : arg3,
            interest_redirected_to_private_pool : v3,
            pool_ctoken_balance_after           : ctoken_balance_for_pool_internal<T0, T1>(arg0, arg2),
            pipe_debt_after                     : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::pipe_debt_value<T1, SuilendPondType>(arg1, arg2, &v1),
        };
        0x2::event::emit<WithdrawToPoolEvent<T1>>(v4);
    }

    fun take_claimable_interest_ctokens<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, u64, u64) {
        assert_lending_market<T0, T1>(arg0, arg1);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::pipe_debt_value<T1, SuilendPondType>(arg2, arg3, &v0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), arg0.reserve_index), arg4);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v2) > 0, 13837312930293088267);
        let v3 = if (v1 == 0) {
            0
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v1), v2))
        };
        let v4 = borrow_ctokens_bucket_mut<T0, T1>(arg0, arg3);
        let v5 = v4.ctoken_amount;
        assert!(v5 > v3, 13838157398173286417);
        v4.ctoken_amount = v3;
        (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg0.reserve_index, &arg0.obligation_owner_cap, arg4, v5 - v3, arg5), v3, v1)
    }

    fun take_pool_ctokens_for_withdraw<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        assert!(arg4 > 0, 13837030299970043913);
        assert_lending_market<T0, T1>(arg0, arg1);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(arg4 <= 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::pipe_debt_value<T1, SuilendPondType>(arg2, arg3, &v0), 13837874759260307471);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), arg0.reserve_index), arg5);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v1) > 0, 13837311830781460491);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg4), v1));
        let v3 = borrow_ctokens_bucket_mut<T0, T1>(arg0, arg3);
        assert!(v3.ctoken_amount >= v2, 13835622998100541443);
        v3.ctoken_amount = v3.ctoken_amount - v2;
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg0.reserve_index, &arg0.obligation_owner_cap, arg5, v2, arg6)
    }

    fun withdraw_sui_to_pool_internal<T0>(arg0: &mut SuilendPond<T0, 0x2::sui::SUI>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0x2::object::ID, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = take_pool_ctokens_for_withdraw<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        let v1 = redeem_sui_ctokens<T0>(arg1, arg0.reserve_index, v0, arg5, arg6, arg7);
        settle_withdraw_to_pool<T0, 0x2::sui::SUI>(arg0, arg2, arg3, arg4, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>(&v0), v1, arg7);
    }

    fun withdraw_to_pool_internal<T0, T1>(arg0: &mut SuilendPond<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg3: &0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = take_pool_ctokens_for_withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg0.reserve_index, arg5, v0, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg6);
        settle_withdraw_to_pool<T0, T1>(arg0, arg2, arg3, arg4, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v0), v1, arg6);
    }

    // decompiled from Move bytecode v7
}

