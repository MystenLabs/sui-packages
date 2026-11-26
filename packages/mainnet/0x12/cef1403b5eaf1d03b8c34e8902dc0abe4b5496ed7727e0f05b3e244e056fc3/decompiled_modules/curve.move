module 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve {
    struct CreatorCap has store, key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
    }

    struct CurveMigrated has copy, drop {
        curve_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct Payout has copy, drop, store {
        recipient: address,
        bps: u64,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MetadataCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct QuoteCurve<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        quote_reserve: 0x2::balance::Balance<T1>,
        token_reserve: 0x2::balance::Balance<T0>,
        creator: address,
        payouts: vector<Payout>,
        creator_fees: 0x2::balance::Balance<T1>,
        protocol_fees: 0x2::balance::Balance<T1>,
        airdrop_fees: 0x2::balance::Balance<T1>,
        launch_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        graduated: bool,
        paused: bool,
        anti_bot_delay: u8,
        created_at_ms: u64,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        creator_lp_nft_id: 0x1::option::Option<0x2::object::ID>,
        active_creator_cap_id: 0x2::object::ID,
        last_creator_activity_ms: u64,
        buyback: BuybackConfig,
        buyback_fees: 0x2::balance::Balance<T1>,
        last_buyback_ms: u64,
        version: u64,
        protocol_config_id: 0x2::object::ID,
        grad_threshold: u64,
        virtual_quote_reserve: u64,
        quote_decimals: u8,
    }

    struct BuybackConfig has drop, store {
        bps: u64,
        burn: bool,
        min_out_bps: u64,
        deadline_ms: u64,
        threshold: u64,
    }

    struct FeeSplit has copy, drop {
        creator: u64,
        buyback: u64,
        protocol: u64,
        airdrop: u64,
        referral: u64,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        quote: 0x1::type_name::TypeName,
        quote_decimals: u8,
        grad_threshold: u64,
        virtual_quote_reserve: u64,
        anti_bot_delay: u8,
    }

    struct TokensPurchased has copy, drop {
        curve_id: 0x2::object::ID,
        buyer: address,
        quote_in: u64,
        tokens_out: u64,
        creator_fee: u64,
        protocol_fee: u64,
        airdrop_fee: u64,
        lp_fee: u64,
        referral_fee: u64,
        referral: 0x1::option::Option<address>,
        new_quote_reserve: u64,
        new_token_reserve: u64,
        grad_threshold: u64,
        tail_refund: u64,
    }

    struct TokensSold has copy, drop {
        curve_id: 0x2::object::ID,
        seller: address,
        tokens_in: u64,
        quote_out: u64,
        creator_fee: u64,
        protocol_fee: u64,
        airdrop_fee: u64,
        lp_fee: u64,
        referral_fee: u64,
        referral: 0x1::option::Option<address>,
        new_quote_reserve: u64,
        new_token_reserve: u64,
    }

    struct CurveGraduated has copy, drop {
        curve_id: 0x2::object::ID,
        final_quote_reserve: u64,
        final_token_reserve: u64,
        creator_bonus: u64,
        protocol_bonus: u64,
    }

    struct GraduatedToCetus has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        quote: 0x1::type_name::TypeName,
        token_is_coin_a: bool,
        tick_spacing: u32,
        quote_in: u64,
        tokens_in: u64,
        tokens_burned: u64,
        excess_locked: u64,
        joined: bool,
        sqrt_price: u128,
        proof_id: 0x2::object::ID,
    }

    struct PoolCreationCapAttached has copy, drop {
        curve_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        quote: 0x1::type_name::TypeName,
        protected: bool,
    }

    struct LaunchFeeCollected has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    struct CreatorFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    struct CreatorFeesPushed has copy, drop {
        curve_id: 0x2::object::ID,
        caller: address,
        amount: u64,
    }

    struct ProtocolFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    struct AirdropFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    struct LaunchFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    struct PayoutsUpdated has copy, drop {
        curve_id: 0x2::object::ID,
        updated_by: address,
    }

    struct PauseToggled has copy, drop {
        curve_id: 0x2::object::ID,
        paused: bool,
    }

    struct BuybackReady has copy, drop {
        curve_id: 0x2::object::ID,
        buyback_fees: u64,
        threshold: u64,
    }

    struct TokensBurned has copy, drop {
        curve_id: 0x2::object::ID,
        burner: address,
        amount: u64,
        total_supply_after: u64,
    }

    struct SupplySealedBurnOnly has copy, drop {
        curve_id: 0x2::object::ID,
        currency_id: 0x2::object::ID,
        final_supply: u64,
    }

    struct MetadataCapStored has copy, drop {
        curve_id: 0x2::object::ID,
        currency_id: 0x2::object::ID,
        metadata_cap_id: 0x2::object::ID,
    }

    struct ProtocolSurchargeCollected has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    struct BuyQuote has copy, drop {
        graduate_now: bool,
        tokens_out: u64,
        effective_quote_in: u64,
        tail_refund: u64,
        fee: u64,
        swap_amount: u64,
        graduates: bool,
    }

    struct SellQuote has copy, drop {
        gross: u64,
        fee: u64,
        net: u64,
    }

    struct HolderRewardsFloorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HolderRewardsFloor has copy, drop, store {
        vault: address,
        floor_pct: u64,
        current_pct: u64,
    }

    struct HolderRewardsCommitted has copy, drop {
        curve_id: 0x2::object::ID,
        vault: address,
        pct: u64,
        floor_pct: u64,
        first: bool,
    }

    struct RewardsVaultKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardsVaultBound has copy, drop {
        curve_id: 0x2::object::ID,
        vault: address,
    }

    struct CreatorLpProofSentKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CreatorLpProofSent has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        proof_id: 0x2::object::ID,
        recipient: address,
    }

    struct PoolCreationCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GradModeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GradClaimedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GradPriceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GradFlippedAtKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GradPrice has copy, drop, store {
        quote_side: u64,
        token_side: u64,
    }

    struct LpProofKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LockedGradExcessKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GradProtocolRecipientKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GradDustKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GradDust has store {
        pools: vector<0x2::object::ID>,
        tick_spacing: u32,
        tokens: u64,
        quote: u64,
    }

    struct GraduationPoolCreated has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_spacing: u32,
        token_is_coin_a: bool,
        sqrt_price: u128,
        dust_tokens: u64,
        dust_quote: u64,
        dust_liquidity: u128,
        proof_id: 0x2::object::ID,
        recipient: address,
        round: u64,
        quote_returned: u64,
    }

    struct ProtocolLpProofSent has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        proof_id: 0x2::object::ID,
        recipient: address,
    }

    struct LpFeesHarvested has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        quote: 0x1::type_name::TypeName,
        quote_total: u64,
        tokens_total: u64,
    }

    struct LpRewardsHarvested has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct GradTierSkipped has copy, drop {
        curve_id: 0x2::object::ID,
        tick_spacing: u32,
        pool_id: 0x2::object::ID,
        pool_sqrt_price: u128,
        add_liquidity_allowed: bool,
    }

    struct GradWalk<phantom T0, phantom T1> {
        curve_id: 0x2::object::ID,
        tiers: vector<u32>,
        idx: u64,
        price_num: u128,
        price_den: u128,
        t_is_a: bool,
        sqrt_target: u128,
        quote: 0x2::balance::Balance<T1>,
        open: bool,
        repaired: bool,
        lp_sold: u64,
        seed: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        flip_age_ms: u64,
        tier_fees: vector<u64>,
    }

    struct WalkRepaired has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_spacing: u32,
        token_is_coin_a: bool,
        a2b: bool,
        sqrt_before: u128,
        sqrt_after: u128,
        quote_spent: u64,
        tokens_bought: u64,
        tokens_sold: u64,
        quote_received: u64,
        seed_quote: u64,
        seed_tokens: u64,
        seed_liquidity: u128,
        tokens_credited: u64,
    }

    struct CetusDenyReportKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DenyExitKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CetusDenyReported has copy, drop {
        curve_id: 0x2::object::ID,
        reported_at_ms: u64,
    }

    struct CetusDenyReportCleared has copy, drop {
        curve_id: 0x2::object::ID,
        reported_at_ms: u64,
    }

    struct DenyExitOpened has copy, drop {
        curve_id: 0x2::object::ID,
        reported_at_ms: u64,
        opened_at_ms: u64,
        reserve: u64,
        circulating: u64,
    }

    struct StuckExitOpened has copy, drop {
        curve_id: 0x2::object::ID,
        flipped_at_ms: u64,
        opened_at_ms: u64,
        reserve: u64,
        circulating: u64,
    }

    struct RedeemedProRata has copy, drop {
        curve_id: 0x2::object::ID,
        redeemer: address,
        tokens_in: u64,
        quote_out: u64,
        reserve_after: u64,
        circulating_after: u64,
    }

    public fun active_creator_cap_id<T0, T1>(arg0: &QuoteCurve<T0, T1>) : 0x2::object::ID {
        arg0.active_creator_cap_id
    }

    fun add_full_range<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg9);
        let v1 = &mut v0;
        add_to_position<T0, T1>(arg0, arg1, v1, arg4, arg5, arg6, arg7, arg8);
        v0
    }

    fun add_to_position<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(arg3, v1), 0x2::balance::split<T1>(arg4, v2), v0);
    }

    public fun airdrop_fees<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.airdrop_fees)
    }

    public fun anti_bot_delay<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u8 {
        arg0.anti_bot_delay
    }

    public(friend) fun assert_active_creator<T0, T1>(arg0: &CreatorCap, arg1: &QuoteCurve<T0, T1>) {
        assert_curve_version<T0, T1>(arg1);
        assert!(arg0.curve_id == 0x2::object::id<QuoteCurve<T0, T1>>(arg1), 13836748829288300553);
        assert!(0x2::object::id<CreatorCap>(arg0) == arg1.active_creator_cap_id, 13845193082885898269);
    }

    public(friend) fun assert_curve_version<T0, T1>(arg0: &QuoteCurve<T0, T1>) {
        assert!(arg0.version == 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853637263468396583);
    }

    fun assert_graduation_ready<T0, T1>(arg0: &QuoteCurve<T0, T1>) {
        assert_curve_version<T0, T1>(arg0);
        assert!(!arg0.graduated, 13836188211501858821);
        assert!(!arg0.paused, 13842943615239323675);
        assert!(0x2::balance::value<T0>(&arg0.token_reserve) == 0 || 0x2::balance::value<T1>(&arg0.quote_reserve) >= arg0.grad_threshold, 13836469707953537031);
    }

    fun assert_holder_rewards_floor<T0, T1>(arg0: &QuoteCurve<T0, T1>, arg1: &vector<Payout>) {
        let v0 = HolderRewardsFloorKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<HolderRewardsFloorKey>(&arg0.id, v0)) {
            return
        };
        let v1 = HolderRewardsFloorKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<HolderRewardsFloorKey, HolderRewardsFloor>(&arg0.id, v1);
        assert!(payout_bps_of(arg1, v2.vault) >= v2.current_pct * 100, 13874469486945173598);
    }

    fun assert_launch_ready<T0, T1>(arg0: &QuoteCurve<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) {
        let v0 = our_pool_cap_id<T0, T1>(arg0);
        let v1 = if (0x1::option::is_some<0x2::object::ID>(&v0)) {
            let v2 = GradModeKey{dummy_field: false};
            0x2::dynamic_field::exists<GradModeKey>(&arg0.id, v2)
        } else {
            false
        };
        assert!(v1, 13862367888308830319);
        let v3 = GradModeKey{dummy_field: false};
        assert!(pair_mode<T0, T1>(arg1, *0x1::option::borrow<0x2::object::ID>(&v0)) == *0x2::dynamic_field::borrow<GradModeKey, bool>(&arg0.id, v3), 13864056746759422069);
    }

    fun assert_lp_harvestable<T0, T1>(arg0: &QuoteCurve<T0, T1>, arg1: 0x2::object::ID) {
        assert_curve_version<T0, T1>(arg0);
        assert!(!arg0.paused, 13842954082074624027);
        assert!(arg0.graduated, 13836480161903935495);
        let v0 = CreatorLpProofSentKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<CreatorLpProofSentKey>(&arg0.id, v0), 13875605187968303212);
        let v1 = LpProofKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<LpProofKey>(&arg0.id, v1), 13866035043056222333);
        assert!(arg0.pool_id == 0x1::option::some<0x2::object::ID>(arg1), 13865753572374347899);
    }

    fun assert_no_self_referral(arg0: &0x1::option::Option<address>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<address>(arg0)) {
            let v0 = *0x1::option::borrow<address>(arg0);
            assert!(v0 != 0x2::tx_context::sender(arg2), 13842659670656286745);
            assert!(v0 != arg1, 13842659674951254041);
        };
    }

    fun assert_pool_at_tier<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg1: u32, arg2: 0x2::object::ID) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_simple_info(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::new_pool_key<T0, T1>(arg1))) == arg2, 13866591855501639809);
    }

    fun assert_sealable<T0, T1>(arg0: &QuoteCurve<T0, T1>) {
        assert_curve_version<T0, T1>(arg0);
        assert!(arg0.graduated, 13836469759493144583);
        let v0 = GradClaimedKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<GradClaimedKey>(&arg0.id, v0), 13858424811974295601);
        let v1 = TreasuryCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<TreasuryCapKey>(&arg0.id, v1), 13858143341292421167);
    }

    public fun attach_pool_creation_cap<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap) {
        assert_curve_version<T0, T1>(arg0);
        assert!(!arg0.graduated && 0x1::option::is_none<0x2::object::ID>(&arg0.pool_id), 13836190775597334533);
        let v0 = PoolCreationCapKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<PoolCreationCapKey>(&arg0.id, v0), 13863493852640444531);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg2);
        let v2 = pair_mode<T0, T1>(arg1, v1);
        let v3 = PoolCreationCapAttached{
            curve_id  : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            cap_id    : v1,
            quote     : 0x1::type_name::with_defining_ids<T1>(),
            protected : v2,
        };
        0x2::event::emit<PoolCreationCapAttached>(v3);
        let v4 = PoolCreationCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<PoolCreationCapKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&mut arg0.id, v4, arg2);
        let v5 = GradModeKey{dummy_field: false};
        0x2::dynamic_field::add<GradModeKey, bool>(&mut arg0.id, v5, v2);
    }

    fun begin_checks<T0, T1>(arg0: &QuoteCurve<T0, T1>, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::ProtocolConfig) : (bool, u64, u64) {
        assert_curve_version<T0, T1>(arg0);
        assert!(!arg0.paused, 13842947983221063707);
        assert!(0x2::object::id<0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::ProtocolConfig>(arg1) == arg0.protocol_config_id, 13880665634397487165);
        let v0 = DenyExitKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0), 13869969589583478937);
        let v1 = GradClaimedKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<GradClaimedKey>(&arg0.id, v1), 13849421920570703905);
        let v2 = PoolCreationCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<PoolCreationCapKey>(&arg0.id, v2), 13862369773799473263);
        let v3 = !arg0.graduated;
        if (v3) {
            assert_graduation_ready<T0, T1>(arg0);
        };
        let (v4, v5, v6) = if (v3) {
            (effective_quote_reserve<T0, T1>(arg0), effective_token_reserve<T0, T1>(arg0), reserve_after_grad_bonuses(0x2::balance::value<T1>(&arg0.quote_reserve)) + 0x2::balance::value<T1>(&arg0.buyback_fees))
        } else {
            let v7 = GradPriceKey{dummy_field: false};
            let v8 = 0x2::dynamic_field::borrow<GradPriceKey, GradPrice>(&arg0.id, v7);
            (v8.quote_side, v8.token_side, 0x2::balance::value<T1>(&arg0.quote_reserve))
        };
        assert!(v6 >= bps_of(arg0.grad_threshold, 5000), 13849703455677087779);
        (v3, v4, v5)
    }

    public fun begin_graduation<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::ProtocolConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : GradWalk<T0, T1> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg3);
        begin_impl<T0, T1>(arg0, arg1, arg2, arg4, arg5)
    }

    fun begin_impl<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::ProtocolConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : GradWalk<T0, T1> {
        let (v0, v1, v2) = begin_checks<T0, T1>(arg0, arg1);
        let v3 = (v1 as u128);
        let v4 = (v2 as u128);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T0, T1>();
        let v6 = tier_order(arg2);
        assert!(!0x1::vector::is_empty<u32>(&v6), 13867999573983232139);
        let v7 = flip_age_now<T0, T1>(arg0, arg3);
        let v8 = GradModeKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<GradModeKey>(&arg0.id, v8), 13862370091627053167);
        let v9 = GradModeKey{dummy_field: false};
        let v10 = !*0x2::dynamic_field::borrow<GradModeKey, bool>(&arg0.id, v9);
        let v11 = GradDustKey{dummy_field: false};
        let v12 = if (0x2::dynamic_field::exists<GradDustKey>(&arg0.id, v11)) {
            let v13 = GradDustKey{dummy_field: false};
            0x2::dynamic_field::borrow<GradDustKey, GradDust>(&arg0.id, v13).tokens
        } else {
            0
        };
        let v14 = take_graduation_reserve<T0, T1>(arg0, arg1, v0, arg3, arg4);
        GradWalk<T0, T1>{
            curve_id    : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            tiers       : v6,
            idx         : 0,
            price_num   : v3,
            price_den   : v4,
            t_is_a      : v5,
            sqrt_target : walk_target(v3, v4, v5),
            quote       : v14,
            open        : v10,
            repaired    : false,
            lp_sold     : v12,
            seed        : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            flip_age_ms : v7,
            tier_fees   : tier_fee_rates(arg2, &v6),
        }
    }

    public(friend) fun bind_rewards_vault<T0, T1>(arg0: &CreatorCap, arg1: &mut QuoteCurve<T0, T1>, arg2: address, arg3: &0x2::clock::Clock) {
        assert_curve_version<T0, T1>(arg1);
        assert_active_creator<T0, T1>(arg0, arg1);
        let v0 = RewardsVaultKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<RewardsVaultKey>(&arg1.id, v0), 13876721518687617126);
        stamp_creator_activity<T0, T1>(arg1, arg3);
        let v1 = RewardsVaultKey{dummy_field: false};
        0x2::dynamic_field::add<RewardsVaultKey, address>(&mut arg1.id, v1, arg2);
        let v2 = RewardsVaultBound{
            curve_id : 0x2::object::id<QuoteCurve<T0, T1>>(arg1),
            vault    : arg2,
        };
        0x2::event::emit<RewardsVaultBound>(v2);
    }

    fun bps_of(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator() as u128)) as u64)
    }

    fun build_payouts(arg0: vector<address>, arg1: vector<u64>) : vector<Payout> {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 > 0 && v0 <= 10, 13840408399123316757);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 13840408403418284053);
        let v1 = 0;
        let v2 = 0x1::vector::empty<Payout>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<address>(&arg0, v3);
            let v5 = *0x1::vector::borrow<u64>(&arg1, v3);
            let v6 = 0;
            while (v6 < v3) {
                assert!(0x1::vector::borrow<Payout>(&v2, v6).recipient != v4, 13840408442072989717);
                v6 = v6 + 1;
            };
            v1 = v1 + v5;
            let v7 = Payout{
                recipient : v4,
                bps       : v5,
            };
            0x1::vector::push_back<Payout>(&mut v2, v7);
            v3 = v3 + 1;
        };
        assert!(v1 == 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator(), 13840408472137760789);
        v2
    }

    public(friend) fun burn_balance<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0, T1>(arg0);
        0x2::coin::burn<T0>(treasury_mut<T0, T1>(arg0), 0x2::coin::from_balance<T0>(arg1, arg2));
    }

    public fun burn_tokens<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0, T1>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 13857863545647792173);
        let v0 = treasury_mut<T0, T1>(arg0);
        let v1 = TokensBurned{
            curve_id           : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            burner             : 0x2::tx_context::sender(arg2),
            amount             : 0x2::coin::burn<T0>(v0, arg1),
            total_supply_after : 0x2::coin::total_supply<T0>(treasury_ref<T0, T1>(arg0)),
        };
        0x2::event::emit<TokensBurned>(v1);
    }

    public fun buy<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_curve_version<T0, T1>(arg0);
        assert!(!arg0.graduated, 13836187408342974469);
        assert!(!arg0.paused, 13842942812080439323);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 13837031846158401547);
        assert_no_self_referral(&arg3, arg0.creator, arg5);
        if (arg0.anti_bot_delay > 0) {
            if (0x2::clock::timestamp_ms(arg4) < arg0.created_at_ms + (arg0.anti_bot_delay as u64) * 1000) {
                assert!(0x2::tx_context::sender(arg5) == arg0.creator, 13840128092377579539);
            };
        };
        let v1 = arg0.grad_threshold;
        let v2 = quote_buy(v0, 0x2::balance::value<T1>(&arg0.quote_reserve), 0x2::balance::value<T0>(&arg0.token_reserve), v1, arg0.virtual_quote_reserve);
        if (!v2.graduate_now) {
            assert!(v2.tokens_out > 0, 13835624544288636929);
            assert!(v2.tokens_out >= arg2, 13835906023560445955);
        };
        let v3 = if (v2.graduate_now) {
            do_graduate_inline<T0, T1>(arg0, arg4, arg5);
            split_fee(0, 0x1::option::is_some<address>(&arg3), arg0.buyback.bps)
        } else {
            let v4 = split_fee(v2.fee, 0x1::option::is_some<address>(&arg3), arg0.buyback.bps);
            let v5 = &mut arg1;
            take_fees<T0, T1>(arg0, v5, &v4, &arg3, arg5);
            0x2::balance::join<T1>(&mut arg0.quote_reserve, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v2.swap_amount, arg5)));
            v4
        };
        let v6 = v3;
        let v7 = 0x2::balance::split<T0>(&mut arg0.token_reserve, v2.tokens_out);
        if (!arg0.graduated && (0x2::balance::value<T0>(&arg0.token_reserve) == 0 || 0x2::balance::value<T1>(&arg0.quote_reserve) >= v1)) {
            do_graduate_inline<T0, T1>(arg0, arg4, arg5);
        };
        let v8 = TokensPurchased{
            curve_id          : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            buyer             : 0x2::tx_context::sender(arg5),
            quote_in          : v0,
            tokens_out        : v2.tokens_out,
            creator_fee       : v6.creator,
            protocol_fee      : v6.protocol,
            airdrop_fee       : v6.airdrop,
            lp_fee            : 0,
            referral_fee      : v6.referral,
            referral          : arg3,
            new_quote_reserve : 0x2::balance::value<T1>(&arg0.quote_reserve),
            new_token_reserve : 0x2::balance::value<T0>(&arg0.token_reserve),
            grad_threshold    : v1,
            tail_refund       : v2.tail_refund,
        };
        0x2::event::emit<TokensPurchased>(v8);
        (0x2::coin::from_balance<T0>(v7, arg5), arg1)
    }

    public fun buyback_bps<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        arg0.buyback.bps
    }

    public fun buyback_burn<T0, T1>(arg0: &QuoteCurve<T0, T1>) : bool {
        arg0.buyback.burn
    }

    public fun buyback_deadline_ms<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        arg0.buyback.deadline_ms
    }

    public fun buyback_fees_pending<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.buyback_fees)
    }

    public fun buyback_min_out_bps<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        arg0.buyback.min_out_bps
    }

    public(friend) fun buyback_swap<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
        assert_curve_version<T0, T1>(arg0);
        0x2::balance::join<T1>(&mut arg0.quote_reserve, arg1);
        0x2::balance::split<T0>(&mut arg0.token_reserve, quote_buyback<T0, T1>(arg0, 0x2::balance::value<T1>(&arg1)))
    }

    public fun buyback_threshold<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        arg0.buyback.threshold
    }

    fun cetus_denies<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : bool {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::in_denied_list<T0>(arg0) && !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::in_allowed_list<T0>(arg0)
    }

    fun cetus_denies_pair<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : bool {
        cetus_denies<T0>(arg0) || cetus_denies<T1>(arg0)
    }

    public fun cetus_deny_reported_at_ms<T0, T1>(arg0: &QuoteCurve<T0, T1>) : 0x1::option::Option<u64> {
        let v0 = CetusDenyReportKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CetusDenyReportKey>(&arg0.id, v0)) {
            let v2 = CetusDenyReportKey{dummy_field: false};
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<CetusDenyReportKey, u64>(&arg0.id, v2))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun circulating_supply<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        let v0 = GradDustKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists<GradDustKey>(&arg0.id, v0)) {
            let v2 = GradDustKey{dummy_field: false};
            0x2::dynamic_field::borrow<GradDustKey, GradDust>(&arg0.id, v2).tokens
        } else {
            0
        };
        let v3 = (0x2::coin::total_supply<T0>(treasury_ref<T0, T1>(arg0)) as u128);
        let v4 = (0x2::balance::value<T0>(&arg0.token_reserve) as u128) + (v1 as u128);
        if (v3 <= v4) {
            0
        } else {
            ((v3 - v4) as u64)
        }
    }

    public fun claim_airdrop_fees<T0, T1>(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminCap, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminRegistry, arg2: &mut QuoteCurve<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::assert_active_admin(arg0, arg1);
        assert_curve_version<T0, T1>(arg2);
        assert!(0x2::balance::value<T1>(&arg2.airdrop_fees) > 0, 13837315704842092557);
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg2.airdrop_fees), arg3);
        let v1 = AirdropFeesClaimed{
            curve_id : 0x2::object::id<QuoteCurve<T0, T1>>(arg2),
            amount   : 0x2::coin::value<T1>(&v0),
        };
        0x2::event::emit<AirdropFeesClaimed>(v1);
        v0
    }

    public fun claim_creator_fees<T0, T1>(arg0: &CreatorCap, arg1: &mut QuoteCurve<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0, T1>(arg1);
        assert_active_creator<T0, T1>(arg0, arg1);
        assert!(!arg1.paused, 13842944981038923803);
        let v0 = 0x2::balance::value<T1>(&arg1.creator_fees);
        assert!(v0 > 0, 13837315490093727757);
        stamp_creator_activity<T0, T1>(arg1, arg2);
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.creator_fees), arg3);
        pay_out_to_payouts<T1>(&arg1.payouts, v1, arg3);
        let v2 = CreatorFeesClaimed{
            curve_id : 0x2::object::id<QuoteCurve<T0, T1>>(arg1),
            creator  : 0x2::tx_context::sender(arg3),
            amount   : v0,
        };
        0x2::event::emit<CreatorFeesClaimed>(v2);
    }

    public fun claim_launch_fees<T0, T1>(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminCap, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminRegistry, arg2: &mut QuoteCurve<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::assert_active_admin(arg0, arg1);
        assert_curve_version<T0, T1>(arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.launch_fees) > 0, 13837315782151503885);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.launch_fees), arg3);
        let v1 = LaunchFeesClaimed{
            curve_id : 0x2::object::id<QuoteCurve<T0, T1>>(arg2),
            amount   : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<LaunchFeesClaimed>(v1);
        v0
    }

    public fun claim_protocol_fees<T0, T1>(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminCap, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminRegistry, arg2: &mut QuoteCurve<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::assert_active_admin(arg0, arg1);
        assert_curve_version<T0, T1>(arg2);
        assert!(0x2::balance::value<T1>(&arg2.protocol_fees) > 0, 13837315640417583117);
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg2.protocol_fees), arg3);
        let v1 = ProtocolFeesClaimed{
            curve_id : 0x2::object::id<QuoteCurve<T0, T1>>(arg2),
            amount   : 0x2::coin::value<T1>(&v0),
        };
        0x2::event::emit<ProtocolFeesClaimed>(v1);
        v0
    }

    public fun clear_cetus_deny_report<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) {
        assert_curve_version<T0, T1>(arg0);
        let v0 = DenyExitKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0), 13869975284710113433);
        let v1 = CetusDenyReportKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<CetusDenyReportKey>(&arg0.id, v1), 13869130864074555539);
        let v2 = GradClaimedKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<GradClaimedKey>(&arg0.id, v2) || !cetus_denies_pair<T0, T1>(arg1), 13869412343346364565);
        let v3 = CetusDenyReportKey{dummy_field: false};
        let v4 = CetusDenyReportCleared{
            curve_id       : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            reported_at_ms : 0x2::dynamic_field::remove<CetusDenyReportKey, u64>(&mut arg0.id, v3),
        };
        0x2::event::emit<CetusDenyReportCleared>(v4);
    }

    fun clip_to_graduation(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, u64) {
        if (arg1 >= arg5) {
            let v2 = (((arg2 as u128) * (arg5 as u128) / ((arg3 as u128) - (arg5 as u128))) as u64);
            let v3 = if (v2 > arg0) {
                arg0
            } else {
                v2
            };
            (arg5, v3)
        } else if ((arg4 as u128) + (arg0 as u128) >= (arg6 as u128)) {
            let v4 = arg6 - arg4;
            let v5 = if (v4 > arg0) {
                arg0
            } else {
                v4
            };
            let v6 = quote_out(v5, arg2, arg3);
            let v7 = if (v6 > arg5) {
                arg5
            } else {
                v6
            };
            (v7, v5)
        } else {
            (arg1, arg0)
        }
    }

    public fun collect_protocol_surcharge<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_curve_version<T0, T1>(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000000, 13856456127814303785);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.launch_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = ProtocolSurchargeCollected{
            curve_id : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            amount   : v0,
        };
        0x2::event::emit<ProtocolSurchargeCollected>(v1);
    }

    public fun commit_holder_rewards<T0, T1>(arg0: &CreatorCap, arg1: &mut QuoteCurve<T0, T1>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_curve_version<T0, T1>(arg1);
        assert_active_creator<T0, T1>(arg0, arg1);
        assert!(arg3 <= 100, 13874188097867677788);
        let v0 = RewardsVaultKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RewardsVaultKey>(&arg1.id, v0), 13877002851930538088);
        let v1 = RewardsVaultKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<RewardsVaultKey, address>(&arg1.id, v1) == arg2, 13877284331202347114);
        assert!(payout_bps_of(&arg1.payouts, arg2) == arg3 * 100, 13875314010659946596);
        let v2 = HolderRewardsFloorKey{dummy_field: false};
        let v3 = !0x2::dynamic_field::exists<HolderRewardsFloorKey>(&arg1.id, v2);
        let v4 = if (v3) {
            arg3
        } else {
            let v5 = HolderRewardsFloorKey{dummy_field: false};
            let v6 = 0x2::dynamic_field::borrow<HolderRewardsFloorKey, HolderRewardsFloor>(&arg1.id, v5);
            assert!(v6.vault == arg2, 13874751077886132320);
            assert!(arg3 >= v6.current_pct, 13875032557157941346);
            v6.floor_pct
        };
        stamp_creator_activity<T0, T1>(arg1, arg4);
        if (v3) {
            let v7 = HolderRewardsFloorKey{dummy_field: false};
            let v8 = HolderRewardsFloor{
                vault       : arg2,
                floor_pct   : v4,
                current_pct : arg3,
            };
            0x2::dynamic_field::add<HolderRewardsFloorKey, HolderRewardsFloor>(&mut arg1.id, v7, v8);
        } else {
            let v9 = HolderRewardsFloorKey{dummy_field: false};
            0x2::dynamic_field::borrow_mut<HolderRewardsFloorKey, HolderRewardsFloor>(&mut arg1.id, v9).current_pct = arg3;
        };
        let v10 = HolderRewardsCommitted{
            curve_id  : 0x2::object::id<QuoteCurve<T0, T1>>(arg1),
            vault     : arg2,
            pct       : arg3,
            floor_pct : v4,
            first     : v3,
        };
        0x2::event::emit<HolderRewardsCommitted>(v10);
    }

    public fun create_and_return<T0, T1>(arg0: 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::LaunchTicket<T0>, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::LaunchIssuerRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: vector<address>, arg6: vector<u64>, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (QuoteCurve<T0, T1>, CreatorCap) {
        create_impl<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::get_name<T0>(arg4), 0x2::coin::get_symbol<T0>(arg4), arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun create_at_tier<T0, T1, T2, T3>(arg0: &QuoteCurve<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: u32, arg4: bool, arg5: u128, arg6: u32, arg7: u32, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<T3>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        if (arg4 && arg3 == 200) {
            let v3 = PoolCreationCapKey{dummy_field: false};
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T2, T3>(arg1, arg2, 0x2::dynamic_object_field::borrow<PoolCreationCapKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg0.id, v3), arg3, arg5, 0x1::string::utf8(b""), arg6, arg7, arg8, arg9, arg10, arg11, arg12)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T2, T3>(arg1, arg2, arg3, arg5, 0x1::string::utf8(b""), arg6, arg7, arg8, arg9, arg10, arg11, arg12)
        }
    }

    public fun create_graduation_pool<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::ProtocolConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg4);
        let v0 = begin_impl<T0, T1>(arg0, arg1, arg2, arg5, arg6);
        walk_create_pool_impl<T0, T1>(v0, arg0, arg2, arg3, arg4, arg5, arg6);
    }

    fun create_impl<T0, T1>(arg0: 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::LaunchTicket<T0>, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::LaunchIssuerRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::ascii::String, arg6: vector<address>, arg7: vector<u64>, arg8: u64, arg9: u8, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (QuoteCurve<T0, T1>, CreatorCap) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 2000000000, 13837594087442481167);
        let v0 = if (arg9 == 0) {
            true
        } else if (arg9 == 15) {
            true
        } else {
            arg9 == 30
        };
        assert!(v0, 13838157050280935441);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let (v2, v3, v4, v5) = quote_params(&v1);
        assert!(v2, 13863771290344095801);
        assert!(arg8 >= v4 && arg8 <= v5, 13880378318265122875);
        let v6 = virtual_quote_for_threshold(arg8);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 13849979037958799397);
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::consume_launch_ticket<T0>(arg0, arg1, arg10, arg11);
        let v7 = 0x2::tx_context::sender(arg11);
        let v8 = 0x2::clock::timestamp_ms(arg10);
        let v9 = 0x2::object::new(arg11);
        let v10 = 0x2::object::uid_to_inner(&v9);
        let v11 = 0x2::object::new(arg11);
        let v12 = BuybackConfig{
            bps         : 0,
            burn        : false,
            min_out_bps : 9900,
            deadline_ms : 0,
            threshold   : 0,
        };
        let v13 = QuoteCurve<T0, T1>{
            id                       : v9,
            quote_reserve            : 0x2::balance::zero<T1>(),
            token_reserve            : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg2, 800000000000000, arg11)),
            creator                  : v7,
            payouts                  : build_payouts(arg6, arg7),
            creator_fees             : 0x2::balance::zero<T1>(),
            protocol_fees            : 0x2::balance::zero<T1>(),
            airdrop_fees             : 0x2::balance::zero<T1>(),
            launch_fees              : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            graduated                : false,
            paused                   : false,
            anti_bot_delay           : arg9,
            created_at_ms            : v8,
            pool_id                  : 0x1::option::none<0x2::object::ID>(),
            creator_lp_nft_id        : 0x1::option::none<0x2::object::ID>(),
            active_creator_cap_id    : 0x2::object::uid_to_inner(&v11),
            last_creator_activity_ms : v8,
            buyback                  : v12,
            buyback_fees             : 0x2::balance::zero<T1>(),
            last_buyback_ms          : v8,
            version                  : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(),
            protocol_config_id       : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::canonical_protocol_config_id(arg1),
            grad_threshold           : arg8,
            virtual_quote_reserve    : v6,
            quote_decimals           : v3,
        };
        let v14 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut v13.id, v14, arg2);
        let v15 = LaunchFeeCollected{
            curve_id : v10,
            amount   : 2000000000,
        };
        0x2::event::emit<LaunchFeeCollected>(v15);
        let v16 = CurveCreated{
            curve_id              : v10,
            creator               : v7,
            name                  : arg4,
            symbol                : arg5,
            quote                 : v1,
            quote_decimals        : v3,
            grad_threshold        : arg8,
            virtual_quote_reserve : v6,
            anti_bot_delay        : arg9,
        };
        0x2::event::emit<CurveCreated>(v16);
        let v17 = CreatorCap{
            id       : v11,
            curve_id : v10,
        };
        (v13, v17)
    }

    public fun created_at_ms<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        arg0.created_at_ms
    }

    public fun creator<T0, T1>(arg0: &QuoteCurve<T0, T1>) : address {
        arg0.creator
    }

    public fun creator_fees<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.creator_fees)
    }

    public fun creator_lp_nft_id<T0, T1>(arg0: &QuoteCurve<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.creator_lp_nft_id
    }

    public fun creator_lp_proof_recipient<T0, T1>(arg0: &QuoteCurve<T0, T1>) : 0x1::option::Option<address> {
        let v0 = CreatorLpProofSentKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CreatorLpProofSentKey>(&arg0.id, v0)) {
            let v2 = CreatorLpProofSentKey{dummy_field: false};
            0x1::option::some<address>(*0x2::dynamic_field::borrow<CreatorLpProofSentKey, address>(&arg0.id, v2))
        } else {
            0x1::option::none<address>()
        }
    }

    fun credit_bought<T0, T1>(arg0: &mut GradWalk<T0, T1>, arg1: u64) : u64 {
        let v0 = if (arg1 < arg0.lp_sold) {
            arg1
        } else {
            arg0.lp_sold
        };
        arg0.lp_sold = arg0.lp_sold - v0;
        v0
    }

    public fun current_version() : u64 {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current()
    }

    public fun curve_supply() : u64 {
        800000000000000
    }

    public fun default_buyback_min_out_bps() : u64 {
        9900
    }

    public fun deny_exit_delay_ms() : u64 {
        604800000
    }

    public fun deny_exit_open<T0, T1>(arg0: &QuoteCurve<T0, T1>) : bool {
        let v0 = DenyExitKey{dummy_field: false};
        0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0)
    }

    public(friend) fun distribute_to_payouts<T0, T1, T2>(arg0: &QuoteCurve<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x2::tx_context::TxContext) {
        pay_out_to_payouts<T2>(&arg0.payouts, arg1, arg2);
    }

    fun do_graduate_inline<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GradPrice{
            quote_side : effective_quote_reserve<T0, T1>(arg0),
            token_side : effective_token_reserve<T0, T1>(arg0),
        };
        let v1 = GradPriceKey{dummy_field: false};
        0x2::dynamic_field::add<GradPriceKey, GradPrice>(&mut arg0.id, v1, v0);
        let v2 = GradFlippedAtKey{dummy_field: false};
        0x2::dynamic_field::add<GradFlippedAtKey, u64>(&mut arg0.id, v2, 0x2::clock::timestamp_ms(arg1));
        let (v3, v4) = grad_bonuses(0x2::balance::value<T1>(&arg0.quote_reserve));
        let v5 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_reserve, v3), arg2);
        pay_out_to_payouts<T1>(&arg0.payouts, v5, arg2);
        0x2::balance::join<T1>(&mut arg0.protocol_fees, 0x2::balance::split<T1>(&mut arg0.quote_reserve, v4));
        0x2::balance::join<T1>(&mut arg0.quote_reserve, 0x2::balance::withdraw_all<T1>(&mut arg0.buyback_fees));
        let v6 = 0x2::balance::withdraw_all<T0>(&mut arg0.token_reserve);
        let v7 = 0x2::balance::value<T0>(&v6);
        if (v7 > 0) {
            let v8 = treasury_mut<T0, T1>(arg0);
            0x2::coin::burn<T0>(v8, 0x2::coin::from_balance<T0>(v6, arg2));
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        arg0.graduated = true;
        let v9 = CurveGraduated{
            curve_id            : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            final_quote_reserve : 0x2::balance::value<T1>(&arg0.quote_reserve),
            final_token_reserve : v7,
            creator_bonus       : v3,
            protocol_bonus      : v4,
        };
        0x2::event::emit<CurveGraduated>(v9);
    }

    fun dust_plan(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: bool) : (u64, bool) {
        let v0 = bps_of(arg5, 1);
        let v1 = bps_of(arg6, 1);
        assert!(v0 > 0 && v1 > 0, 13865469185409679481);
        let (v2, v3) = if (arg7) {
            (v1, v0)
        } else {
            (v0, v1)
        };
        let v4 = min_u256(seed_liq_from_a(arg4, arg3, v2), seed_liq_from_b(arg4, arg2, v3));
        assert!(v4 > 0 && v4 <= 340282366920938463463374607431768211455, 13865469198294581369);
        let v5 = seed_a_of(v4, arg4, arg3);
        let v6 = seed_b_of(v4, arg4, arg2);
        let v7 = v5 >= v6;
        let v8 = if (v7) {
            v5
        } else {
            v6
        };
        assert!(v8 > 0 && v8 <= 18446744073709551615, 13865469219769417849);
        assert!(!v7 || (arg4 as u256) * (arg3 as u256) <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v8, 13865469224064385145);
        assert!(v7 || v4 * ((arg3 - arg4) as u256) < 6277101735386680763835789423207666416102355444464034512896, 13865469228359352441);
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(arg0, arg1, arg0, arg4, (v8 as u64), v7);
        let v12 = if (v9 > 0) {
            if (v10 > 0) {
                v11 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v12, 13865469236949287033);
        ((v8 as u64), v7)
    }

    public(friend) fun effective_quote_reserve<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_reserve) + arg0.virtual_quote_reserve
    }

    fun effective_token_reserve<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        1073000000000000 - 800000000000000 - 0x2::balance::value<T0>(&arg0.token_reserve)
    }

    fun emit_buyback_ready_if_crossed<T0, T1>(arg0: &QuoteCurve<T0, T1>, arg1: u64) {
        let v0 = arg0.buyback.threshold;
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::balance::value<T1>(&arg0.buyback_fees);
        if (arg1 < v0 && v1 >= v0) {
            let v2 = BuybackReady{
                curve_id     : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
                buyback_fees : v1,
                threshold    : v0,
            };
            0x2::event::emit<BuybackReady>(v2);
        };
    }

    fun emit_graduated<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u32, arg3: bool, arg4: u128, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2::object::ID) {
        let v0 = GraduatedToCetus{
            curve_id        : arg0,
            pool_id         : arg1,
            quote           : 0x1::type_name::with_defining_ids<T0>(),
            token_is_coin_a : arg5,
            tick_spacing    : arg2,
            quote_in        : arg6,
            tokens_in       : arg7,
            tokens_burned   : arg8,
            excess_locked   : arg9,
            joined          : arg3,
            sqrt_price      : arg4,
            proof_id        : arg10,
        };
        0x2::event::emit<GraduatedToCetus>(v0);
    }

    fun finish_join<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: 0x2::object::ID, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: u64, arg9: u32, arg10: u128, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = keep_creator_seed<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg12);
        let v3 = GradProtocolRecipientKey{dummy_field: false};
        let v4 = 0x2::object::id<QuoteCurve<T0, T1>>(arg0);
        send_protocol_proof(v4, arg1, arg3, arg4, 0x2::dynamic_field::remove<GradProtocolRecipientKey, address>(&mut arg0.id, v3), arg12);
        emit_graduated<T1>(v4, arg4, arg9, true, arg10, arg11, arg7 - v2, arg8 - v1, v1, v2, v0);
    }

    fun flip_age_now<T0, T1>(arg0: &QuoteCurve<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = GradFlippedAtKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<GradFlippedAtKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = GradFlippedAtKey{dummy_field: false};
        let v2 = *0x2::dynamic_field::borrow<GradFlippedAtKey, u64>(&arg0.id, v1);
        let v3 = 0x2::clock::timestamp_ms(arg1);
        if (v3 > v2) {
            v3 - v2
        } else {
            0
        }
    }

    fun grad_bonuses(arg0: u64) : (u64, u64) {
        (bps_of(arg0, 50), bps_of(arg0, 50))
    }

    public fun grad_dust_bps() : u64 {
        1
    }

    public fun grad_flipped_at_ms<T0, T1>(arg0: &QuoteCurve<T0, T1>) : 0x1::option::Option<u64> {
        let v0 = GradFlippedAtKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GradFlippedAtKey>(&arg0.id, v0)) {
            let v2 = GradFlippedAtKey{dummy_field: false};
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<GradFlippedAtKey, u64>(&arg0.id, v2))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun grad_funds_claimed<T0, T1>(arg0: &QuoteCurve<T0, T1>) : bool {
        let v0 = GradClaimedKey{dummy_field: false};
        0x2::dynamic_field::exists<GradClaimedKey>(&arg0.id, v0)
    }

    public fun grad_join_band_bps() : u64 {
        100
    }

    public fun grad_price<T0, T1>(arg0: &QuoteCurve<T0, T1>) : (u64, u64) {
        let v0 = GradPriceKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<GradPriceKey>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = GradPriceKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<GradPriceKey, GradPrice>(&arg0.id, v1);
        (v2.quote_side, v2.token_side)
    }

    public fun grad_threshold<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        arg0.grad_threshold
    }

    public(friend) fun graduate_if_ready<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0, T1>(arg0);
        if (!arg0.graduated && (0x2::balance::value<T0>(&arg0.token_reserve) == 0 || 0x2::balance::value<T1>(&arg0.quote_reserve) >= arg0.grad_threshold)) {
            do_graduate_inline<T0, T1>(arg0, arg1, arg2);
        };
    }

    public fun graduate_to_cetus<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::ProtocolConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg5);
        let v0 = begin_impl<T0, T1>(arg0, arg1, arg2, arg6, arg7);
        walk_join<T0, T1>(v0, arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun graduate_to_cetus_qt<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::ProtocolConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg5);
        let v0 = begin_impl<T0, T1>(arg0, arg1, arg2, arg6, arg7);
        walk_join_qt<T0, T1>(v0, arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun graduated<T0, T1>(arg0: &QuoteCurve<T0, T1>) : bool {
        arg0.graduated
    }

    public fun graduation_dust_spent<T0, T1>(arg0: &QuoteCurve<T0, T1>) : (u64, u64) {
        let v0 = GradDustKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GradDustKey>(&arg0.id, v0)) {
            let v3 = GradDustKey{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow<GradDustKey, GradDust>(&arg0.id, v3);
            (v4.tokens, v4.quote)
        } else {
            (0, 0)
        }
    }

    public fun graduation_pools<T0, T1>(arg0: &QuoteCurve<T0, T1>) : vector<0x2::object::ID> {
        let v0 = GradDustKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GradDustKey>(&arg0.id, v0)) {
            let v2 = GradDustKey{dummy_field: false};
            0x2::dynamic_field::borrow<GradDustKey, GradDust>(&arg0.id, v2).pools
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun graduation_protected<T0, T1>(arg0: &QuoteCurve<T0, T1>) : 0x1::option::Option<bool> {
        let v0 = GradModeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GradModeKey>(&arg0.id, v0)) {
            let v2 = GradModeKey{dummy_field: false};
            0x1::option::some<bool>(*0x2::dynamic_field::borrow<GradModeKey, bool>(&arg0.id, v2))
        } else {
            0x1::option::none<bool>()
        }
    }

    public fun graduation_quote<T0, T1>(arg0: &QuoteCurve<T0, T1>) : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T1>()
    }

    fun gross_up_for_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = ((0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator() - 100) as u128);
        let v1 = ((arg0 as u128) * (0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator() as u128) + v0 - 1) / v0;
        if (v1 >= (arg1 as u128)) {
            arg1
        } else {
            (v1 as u64)
        }
    }

    public fun harvest_lp_fees<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg1);
        assert_lp_harvestable<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3));
        let v0 = LpProofKey{dummy_field: false};
        let (v1, v2) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, T1>(arg1, arg2, arg3, 0x2::dynamic_object_field::borrow_mut<LpProofKey, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.id, v0), arg4);
        pay_lp_fees<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), v1, v2, arg4);
    }

    public fun harvest_lp_fees_qt<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg1);
        assert_lp_harvestable<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3));
        let v0 = LpProofKey{dummy_field: false};
        let (v1, v2) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T1, T0>(arg1, arg2, arg3, 0x2::dynamic_object_field::borrow_mut<LpProofKey, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.id, v0), arg4);
        pay_lp_fees<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), v2, v1, arg4);
    }

    public fun harvest_lp_rewards<T0, T1, T2, T3, T4>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg1);
        assert_lp_harvestable<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3));
        let v0 = LpProofKey{dummy_field: false};
        let v1 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_reward<T2, T3, T4>(arg1, arg2, arg3, 0x2::dynamic_object_field::borrow_mut<LpProofKey, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.id, v0), arg4, arg5, arg6);
        pay_or_destroy<T4>(&arg0.payouts, v1, arg6);
        let v2 = LpRewardsHarvested{
            curve_id : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            pool_id  : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3),
            reward   : 0x1::type_name::with_defining_ids<T4>(),
            amount   : 0x2::coin::value<T4>(&v1),
        };
        0x2::event::emit<LpRewardsHarvested>(v2);
    }

    public fun holder_rewards_settings<T0, T1>(arg0: &QuoteCurve<T0, T1>) : (bool, address, u64, u64) {
        let v0 = HolderRewardsFloorKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<HolderRewardsFloorKey>(&arg0.id, v0)) {
            return (false, @0x0, 0, 0)
        };
        let v1 = HolderRewardsFloorKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<HolderRewardsFloorKey, HolderRewardsFloor>(&arg0.id, v1);
        (true, v2.vault, v2.floor_pct, v2.current_pct)
    }

    fun holder_share_is_zero<T0, T1>(arg0: &QuoteCurve<T0, T1>) : bool {
        let (v0, _, _, v3) = holder_rewards_settings<T0, T1>(arg0);
        !v0 || v3 == 0
    }

    fun in_band(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: bool, arg5: u64, arg6: u64) : bool {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        if (v0 > 2 * v1 || 2 * v0 < v1) {
            return false
        };
        let v2 = (0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator() as u256);
        if (arg4) {
            let v4 = v0 * v0 * (arg3 as u256) * v2;
            let v5 = (arg2 as u256) << 128;
            v4 >= v5 * (v2 - (arg5 as u256)) && v4 <= v5 * (v2 + (arg6 as u256))
        } else {
            let v6 = ((arg3 as u256) << 128) * v2;
            let v7 = v0 * v0 * (arg2 as u256);
            v7 * (v2 - (arg5 as u256)) <= v6 && v6 <= v7 * (v2 + (arg6 as u256))
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(4500 + 3000 + 2500 == 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator(), 13840975446475669527);
        assert!(4500 + 2500 + 2000 + 1000 == 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator(), 13840975467950506007);
    }

    public(friend) fun inject_reserve<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        assert_curve_version<T0, T1>(arg0);
        assert!(0x2::balance::value<T1>(&arg1) <= bps_of(effective_quote_reserve<T0, T1>(arg0), 100), 13860111565890650163);
        0x2::balance::join<T1>(&mut arg0.quote_reserve, arg1);
    }

    public fun is_allowed_quote<T0>() : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (v1, _, _, _) = quote_params(&v0);
        v1
    }

    fun is_own_pool<T0, T1>(arg0: &QuoteCurve<T0, T1>, arg1: 0x2::object::ID) : bool {
        let v0 = GradDustKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GradDustKey>(&arg0.id, v0)) {
            let v2 = GradDustKey{dummy_field: false};
            0x1::vector::contains<0x2::object::ID>(&0x2::dynamic_field::borrow<GradDustKey, GradDust>(&arg0.id, v2).pools, &arg1)
        } else {
            false
        }
    }

    fun isqrt_u256(arg0: u256) : u256 {
        if (arg0 < 2) {
            return arg0
        };
        let v0 = 0;
        while (arg0 > 0) {
            arg0 = arg0 >> 1;
            v0 = v0 + 1;
        };
        let v1 = 1 << (((v0 + 1) / 2) as u8);
        loop {
            let v2 = v1 + arg0 / v1 >> 1;
            if (v2 >= v1) {
                break
            };
            v1 = v2;
        };
        v1
    }

    fun join_band_low_at(arg0: u32, arg1: u64) : u64 {
        if (arg0 != 200) {
            return 100
        };
        let v0 = arg1 / 86400000;
        if (v0 >= (1000 - 100) / 300) {
            1000
        } else {
            100 + v0 * 300
        }
    }

    public fun join_band_low_bps_now<T0, T1>(arg0: &QuoteCurve<T0, T1>, arg1: u32, arg2: &0x2::clock::Clock) : u64 {
        join_band_low_at(arg1, flip_age_now<T0, T1>(arg0, arg2))
    }

    public fun join_band_low_max_bps() : u64 {
        1000
    }

    public fun join_band_low_step_bps() : u64 {
        300
    }

    public fun join_band_low_step_ms() : u64 {
        86400000
    }

    fun join_checks<T0, T1, T2, T3>(arg0: &GradWalk<T0, T1>, arg1: &QuoteCurve<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: bool) : (u32, u32, bool, u64, u64, u128) {
        assert!(arg0.curve_id == 0x2::object::id<QuoteCurve<T0, T1>>(arg1), 13866315019089477759);
        assert!(arg0.t_is_a == arg4, 13870537148037071005);
        assert_curve_version<T0, T1>(arg1);
        let v0 = *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx);
        assert_pool_at_tier<T2, T3>(arg2, v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3));
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.seed)) {
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.seed)) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3), 13882922068488814774);
        };
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_add_liquidity<T2, T3>(arg3), 13867440953356583047);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg3);
        let (v2, v3) = walk_band<T0, T1>(arg0);
        assert!(in_band(v1, arg0.sqrt_target, arg0.price_num, arg0.price_den, arg4, v2, v3), 13867159512739479685);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(v0);
        let (v6, v7, v8, _, _) = two_half_plan(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v5), v1, 0x2::balance::value<T1>(&arg0.quote), lp_supply() - arg0.lp_sold, arg4);
        (v4, v5, v6, v7, v8, v1)
    }

    fun keep_creator_seed<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::object::ID, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64, u64) {
        let v0 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg1, arg2, arg6);
        let v1 = 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v0);
        let v2 = 0x2::balance::value<T0>(&arg4);
        if (v2 > 0) {
            let v3 = treasury_mut<T0, T1>(arg0);
            0x2::coin::burn<T0>(v3, 0x2::coin::from_balance<T0>(arg4, arg6));
        } else {
            0x2::balance::destroy_zero<T0>(arg4);
        };
        let v4 = LockedGradExcessKey{dummy_field: false};
        0x2::dynamic_field::add<LockedGradExcessKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v4, arg5);
        arg0.pool_id = 0x1::option::some<0x2::object::ID>(arg3);
        arg0.creator_lp_nft_id = 0x1::option::some<0x2::object::ID>(v1);
        place_creator_proof<T0, T1>(arg0, v0, arg3);
        (v1, v2, 0x2::balance::value<T1>(&arg5))
    }

    public fun last_buyback_ms<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        arg0.last_buyback_ms
    }

    public fun last_creator_activity_ms<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        arg0.last_creator_activity_ms
    }

    public fun launch_fees<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.launch_fees)
    }

    public fun locked_grad_excess<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        let v0 = LockedGradExcessKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LockedGradExcessKey>(&arg0.id, v0)) {
            let v2 = LockedGradExcessKey{dummy_field: false};
            0x2::balance::value<T1>(0x2::dynamic_field::borrow<LockedGradExcessKey, 0x2::balance::Balance<T1>>(&arg0.id, v2))
        } else {
            0
        }
    }

    fun lp_supply() : u64 {
        1000000000000000 - 800000000000000
    }

    public fun metadata_cap_stored<T0, T1>(arg0: &QuoteCurve<T0, T1>) : bool {
        let v0 = MetadataCapKey{dummy_field: false};
        0x2::dynamic_object_field::exists<MetadataCapKey>(&arg0.id, v0)
    }

    public fun migrate_curve<T0, T1>(arg0: &mut QuoteCurve<T0, T1>) {
        assert!(arg0.version < 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853637284943233063);
        arg0.version = 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current();
        let v0 = CurveMigrated{
            curve_id     : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            from_version : arg0.version,
            to_version   : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(),
        };
        0x2::event::emit<CurveMigrated>(v0);
    }

    public fun min_buyback_min_out_bps() : u64 {
        9000
    }

    fun min_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun no_plan(arg0: bool) : (bool, bool, u64, u64, bool, u128) {
        (false, arg0, 0, 0, false, 0)
    }

    public fun open_deny_exit<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0, T1>(arg0);
        assert!(!arg0.paused, 13842953738477240347);
        let v0 = DenyExitKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0), 13869975340544688281);
        let v1 = GradClaimedKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<GradClaimedKey>(&arg0.id, v1), 13849427671531913249);
        let v2 = CetusDenyReportKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<CetusDenyReportKey>(&arg0.id, v2), 13869130924204097683);
        let v3 = CetusDenyReportKey{dummy_field: false};
        let v4 = *0x2::dynamic_field::borrow<CetusDenyReportKey, u64>(&arg0.id, v3);
        let v5 = 0x2::clock::timestamp_ms(arg2);
        assert!(v5 >= v4 + 604800000, 13869693887042683031);
        assert!(cetus_denies_pair<T0, T1>(arg1), 13868567991430283407);
        let v6 = !arg0.graduated;
        if (v6) {
            assert_graduation_ready<T0, T1>(arg0);
        };
        if (v6) {
            do_graduate_inline<T0, T1>(arg0, arg2, arg3);
        };
        let v7 = DenyExitKey{dummy_field: false};
        0x2::dynamic_field::add<DenyExitKey, u64>(&mut arg0.id, v7, v5);
        let v8 = DenyExitOpened{
            curve_id       : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            reported_at_ms : v4,
            opened_at_ms   : v5,
            reserve        : 0x2::balance::value<T1>(&arg0.quote_reserve),
            circulating    : circulating_supply<T0, T1>(arg0),
        };
        0x2::event::emit<DenyExitOpened>(v8);
    }

    public fun open_stuck_exit<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x2::clock::Clock) {
        assert_curve_version<T0, T1>(arg0);
        let v0 = DenyExitKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0), 13869975435033968793);
        let v1 = GradClaimedKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<GradClaimedKey>(&arg0.id, v1), 13849427766021193761);
        let v2 = if (arg0.graduated) {
            let v3 = GradFlippedAtKey{dummy_field: false};
            0x2::dynamic_field::exists<GradFlippedAtKey>(&arg0.id, v3)
        } else {
            false
        };
        assert!(v2, 13872790193391534241);
        let v4 = GradFlippedAtKey{dummy_field: false};
        let v5 = *0x2::dynamic_field::borrow<GradFlippedAtKey, u64>(&arg0.id, v4);
        let v6 = 0x2::clock::timestamp_ms(arg1);
        assert!(v6 >= v5 + 345600000, 13872508731299594399);
        let v7 = DenyExitKey{dummy_field: false};
        0x2::dynamic_field::add<DenyExitKey, u64>(&mut arg0.id, v7, v6);
        let v8 = StuckExitOpened{
            curve_id      : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            flipped_at_ms : v5,
            opened_at_ms  : v6,
            reserve       : 0x2::balance::value<T1>(&arg0.quote_reserve),
            circulating   : circulating_supply<T0, T1>(arg0),
        };
        0x2::event::emit<StuckExitOpened>(v8);
    }

    fun our_pool_cap_id<T0, T1>(arg0: &QuoteCurve<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = PoolCreationCapKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists<PoolCreationCapKey>(&arg0.id, v0)) {
            let v2 = PoolCreationCapKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(0x2::dynamic_object_field::borrow<PoolCreationCapKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg0.id, v2)))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun pair_holder<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : 0x1::option::Option<0x2::object::ID> {
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T0, T1>()) {
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_permission_pair<T0, T1>(arg0, 200)) {
                0x1::option::some<0x2::object::ID>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::permission_pair_cap<T0, T1>(arg0, 200))
            } else {
                0x1::option::none<0x2::object::ID>()
            }
        } else if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_permission_pair<T1, T0>(arg0, 200)) {
            0x1::option::some<0x2::object::ID>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::permission_pair_cap<T1, T0>(arg0, 200))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun pair_mode<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg1: 0x2::object::ID) : bool {
        let v0 = 0x1::option::some<0x2::object::ID>(arg1);
        let v1 = pair_holder<T0, 0x2::sui::SUI>(arg0);
        assert!(same_cap(&v1, &v0), 13863212265994453105);
        let v2 = pair_holder<T0, T1>(arg0);
        let v3 = same_cap(&v2, &v0);
        assert!(v3 || 0x1::option::is_none<0x2::object::ID>(&v2), 13864056703809749109);
        v3
    }

    public fun paused<T0, T1>(arg0: &QuoteCurve<T0, T1>) : bool {
        arg0.paused
    }

    fun pay_lp_fees<T0, T1>(arg0: &QuoteCurve<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        pay_or_destroy<T1>(&arg0.payouts, arg3, arg4);
        pay_or_destroy<T0>(&arg0.payouts, arg2, arg4);
        let v0 = LpFeesHarvested{
            curve_id     : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            pool_id      : arg1,
            quote        : 0x1::type_name::with_defining_ids<T1>(),
            quote_total  : 0x2::coin::value<T1>(&arg3),
            tokens_total : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<LpFeesHarvested>(v0);
    }

    fun pay_or_destroy<T0>(arg0: &vector<Payout>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            pay_out_to_payouts<T0>(arg0, arg1, arg2);
        };
    }

    fun pay_out_to_payouts<T0>(arg0: &vector<Payout>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Payout>(arg0);
        let v1 = 0;
        while (v1 < v0 - 1) {
            let v2 = 0x1::vector::borrow<Payout>(arg0, v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, bps_of(0x2::coin::value<T0>(&arg1), v2.bps), arg2), v2.recipient);
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x1::vector::borrow<Payout>(arg0, v0 - 1).recipient);
    }

    fun payout_bps_of(arg0: &vector<Payout>, arg1: address) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Payout>(arg0)) {
            let v2 = 0x1::vector::borrow<Payout>(arg0, v1);
            if (v2.recipient == arg1) {
                v0 = v0 + v2.bps;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun payouts<T0, T1>(arg0: &QuoteCurve<T0, T1>) : (vector<address>, vector<u64>) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Payout>(&arg0.payouts)) {
            let v3 = 0x1::vector::borrow<Payout>(&arg0.payouts, v2);
            0x1::vector::push_back<address>(&mut v0, v3.recipient);
            0x1::vector::push_back<u64>(&mut v1, v3.bps);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun place_creator_proof<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof, arg2: 0x2::object::ID) {
        if (holder_share_is_zero<T0, T1>(arg0)) {
            let v0 = arg0.creator;
            let v1 = CreatorLpProofSentKey{dummy_field: false};
            0x2::dynamic_field::add<CreatorLpProofSentKey, address>(&mut arg0.id, v1, v0);
            0x2::transfer::public_transfer<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg1, v0);
            let v2 = CreatorLpProofSent{
                curve_id  : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
                pool_id   : arg2,
                proof_id  : 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&arg1),
                recipient : v0,
            };
            0x2::event::emit<CreatorLpProofSent>(v2);
        } else {
            let v3 = LpProofKey{dummy_field: false};
            0x2::dynamic_object_field::add<LpProofKey, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.id, v3, arg1);
        };
    }

    public fun pool_creation_cap_id<T0, T1>(arg0: &QuoteCurve<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        our_pool_cap_id<T0, T1>(arg0)
    }

    public fun pool_id<T0, T1>(arg0: &QuoteCurve<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool_id
    }

    fun position_amounts(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u64, arg4: bool, arg5: bool) : (u128, u64, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(arg0, arg1, arg0, arg2, arg3, arg4 == arg5);
        let (v3, v4) = if (arg5) {
            (v1, v2)
        } else {
            (v2, v1)
        };
        (v0, v3, v4)
    }

    public fun protocol_config_id<T0, T1>(arg0: &QuoteCurve<T0, T1>) : 0x2::object::ID {
        arg0.protocol_config_id
    }

    public fun protocol_fees<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.protocol_fees)
    }

    fun protocol_position<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg3: u128, arg4: u32, arg5: u32, arg6: &mut 0x2::balance::Balance<T0>, arg7: &mut 0x2::balance::Balance<T1>, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2)) {
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg2);
            return add_full_range<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
        };
        let v0 = 0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg2);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        if (v1 < arg3) {
            let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4);
            let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
            let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
            let (v5, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v2, v3, v2, v4, arg8, arg9);
            let v8 = if (v5 == 0) {
                0
            } else {
                (((arg8 as u256) * ((arg3 - v1) as u256) / (v5 as u256)) as u64)
            };
            let v9 = if (v8 == 0) {
                0
            } else {
                let (v10, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v2, v3, v2, v4, v8, arg9);
                v10
            };
            if (v9 > 0) {
                let v13 = &mut v0;
                add_to_position<T0, T1>(arg0, arg1, v13, arg6, arg7, v8, arg9, arg10);
            };
        };
        v0
    }

    public fun push_creator_fees<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0, T1>(arg0);
        assert!(!arg0.paused, 13842945066938269723);
        let v0 = 0x2::balance::value<T1>(&arg0.creator_fees);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.creator_fees), arg2);
        pay_out_to_payouts<T1>(&arg0.payouts, v1, arg2);
        let v2 = CreatorFeesPushed{
            curve_id : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            caller   : 0x2::tx_context::sender(arg2),
            amount   : v0,
        };
        0x2::event::emit<CreatorFeesPushed>(v2);
    }

    public fun quote_band<T0>() : (bool, u8, u64, u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        quote_params(&v0)
    }

    fun quote_buy(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : BuyQuote {
        let v0 = arg0 - bps_of(arg0, 100);
        let v1 = arg1 + arg4;
        let v2 = 1073000000000000 - 800000000000000 - arg2;
        let v3 = quote_out(v0, v1, v2);
        if (v3 < arg2 && arg1 >= arg3) {
            return BuyQuote{
                graduate_now       : true,
                tokens_out         : 0,
                effective_quote_in : 0,
                tail_refund        : arg0,
                fee                : 0,
                swap_amount        : 0,
                graduates          : true,
            }
        };
        let (v4, v5) = clip_to_graduation(v0, v3, v1, v2, arg1, arg2, arg3);
        let v6 = gross_up_for_fee(v5, arg0);
        let v7 = bps_of(v6, 100);
        let v8 = v6 - v7;
        let v9 = v4 == arg2 || arg1 + v8 >= arg3;
        BuyQuote{
            graduate_now       : false,
            tokens_out         : v4,
            effective_quote_in : v6,
            tail_refund        : arg0 - v6,
            fee                : v7,
            swap_amount        : v8,
            graduates          : v9,
        }
    }

    public(friend) fun quote_buyback<T0, T1>(arg0: &QuoteCurve<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.token_reserve);
        let v1 = quote_out(arg1, effective_quote_reserve<T0, T1>(arg0), effective_token_reserve<T0, T1>(arg0));
        if (v1 > v0) {
            v0
        } else {
            v1
        }
    }

    public fun quote_decimals<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u8 {
        arg0.quote_decimals
    }

    fun quote_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        (((arg2 as u128) * v0 / ((arg1 as u128) + v0)) as u64)
    }

    fun quote_params(arg0: &0x1::type_name::TypeName) : (bool, u8, u64, u64) {
        quote_params_of_name(0x1::ascii::as_bytes(0x1::type_name::as_string(arg0)))
    }

    fun quote_params_of_name(arg0: &vector<u8>) : (bool, u8, u64, u64) {
        if (*arg0 == b"aaffd090b57fcdcf293f7e7ec59c119acc910eeb5fc4aadfb4185fa56b6a2cb5::suipump::SUIPUMP") {
            (true, 6, 5000000000000, 300000000000000)
        } else if (*arg0 == b"d30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC") {
            (true, 8, 1000000, 200000000)
        } else {
            (false, 0, 0, 0)
        }
    }

    public fun quote_reserve<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_reserve)
    }

    fun quote_sell(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : SellQuote {
        let v0 = quote_out(arg0, 1073000000000000 - 800000000000000 - arg2, arg1 + arg3);
        let v1 = bps_of(v0, 100);
        SellQuote{
            gross : v0,
            fee   : v1,
            net   : v0 - v1,
        }
    }

    public fun redeem_pro_rata<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_curve_version<T0, T1>(arg0);
        let v0 = DenyExitKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0), 13870257000205123739);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 13837042961533763595);
        let v2 = circulating_supply<T0, T1>(arg0);
        let v3 = if (v2 > v1) {
            v2
        } else {
            v1
        };
        let v4 = (((0x2::balance::value<T1>(&arg0.quote_reserve) as u128) * (v1 as u128) / (v3 as u128)) as u64);
        let v5 = treasury_mut<T0, T1>(arg0);
        0x2::coin::burn<T0>(v5, arg1);
        let v6 = RedeemedProRata{
            curve_id          : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            redeemer          : 0x2::tx_context::sender(arg2),
            tokens_in         : v1,
            quote_out         : v4,
            reserve_after     : 0x2::balance::value<T1>(&arg0.quote_reserve),
            circulating_after : circulating_supply<T0, T1>(arg0),
        };
        0x2::event::emit<RedeemedProRata>(v6);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_reserve, v4), arg2)
    }

    public fun repair_cap_bps() : u64 {
        200
    }

    fun repair_checks<T0, T1, T2, T3>(arg0: &GradWalk<T0, T1>, arg1: &QuoteCurve<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: bool) : (bool, u64, u64, bool) {
        assert!(arg0.curve_id == 0x2::object::id<QuoteCurve<T0, T1>>(arg1), 13866312558073217151);
        assert!(arg0.t_is_a == arg4, 13870534687020810397);
        assert_curve_version<T0, T1>(arg1);
        let v0 = if (arg0.open) {
            true
        } else if (*0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx) == 200) {
            true
        } else {
            is_own_pool<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3))
        };
        assert!(v0, 13882075195426930864);
        assert!(!arg0.repaired, 13882356678993707186);
        assert_pool_at_tier<T2, T3>(arg2, *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3));
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_add_liquidity<T2, T3>(arg3), 13867438513815158919);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_swap<T2, T3>(arg3), 13882638166855450804);
        let (v1, v2) = walk_band<T0, T1>(arg0);
        assert!(!in_band(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg3), arg0.sqrt_target, arg0.price_num, arg0.price_den, arg4, v1, v2), 13866875581041344643);
        assert!(repair_fee_ok<T0, T1, T2, T3>(arg0, arg3), 13883482608965845178);
        let (v3, v4, v5, v6, v7, _) = repair_plan<T0, T1, T2, T3>(arg0, arg3);
        assert!(v3, 13881230817741045930);
        (v4, v5, v6, v7)
    }

    fun repair_fee_ok<T0, T1, T2, T3>(arg0: &GradWalk<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>) : bool {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T2, T3>(arg1);
        v0 <= *0x1::vector::borrow<u64>(&arg0.tier_fees, arg0.idx) && (*0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx) != 200 || v0 <= 10000)
    }

    public fun repair_max_fee_rate_canonical() : u64 {
        10000
    }

    fun repair_plan<T0, T1, T2, T3>(arg0: &GradWalk<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>) : (bool, bool, u64, u64, bool, u128) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg1);
        let v1 = arg0.sqrt_target;
        let v2 = v0 > v1;
        let v3 = arg0.t_is_a;
        let v4 = v2 == v3;
        let v5 = 0x2::balance::value<T1>(&arg0.quote);
        if (arg0.lp_sold > lp_supply()) {
            return no_plan(v2)
        };
        if (!repair_fee_ok<T0, T1, T2, T3>(arg0, arg1)) {
            return no_plan(v2)
        };
        let v6 = bps_of(v5, 10);
        let v7 = bps_of(lp_supply() - arg0.lp_sold, 10);
        let v8 = bps_of(v5, 200);
        let v9 = if (v0 == v1) {
            true
        } else if (v6 == 0) {
            true
        } else if (v7 == 0) {
            true
        } else {
            v8 == 0
        };
        if (v9) {
            return no_plan(v2)
        };
        let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(*0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx));
        let v12 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v10);
        let v13 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v11);
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v12);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v13);
        let v16 = if (v0 <= v14) {
            true
        } else if (v0 >= v15) {
            true
        } else if (v1 <= v14) {
            true
        } else {
            v1 >= v15
        };
        if (v16) {
            return no_plan(v2)
        };
        let (v17, v18) = if (v3) {
            (v7, v6)
        } else {
            (v6, v7)
        };
        let v19 = min_u256(min_u256(seed_liq_from_a(v0, v15, v17), seed_liq_from_b(v0, v14, v18)), min_u256(seed_liq_from_a(v1, v15, v17), seed_liq_from_b(v1, v14, v18)));
        if (v19 == 0 || v19 > 340282366920938463463374607431768211455) {
            return no_plan(v2)
        };
        let v20 = seed_a_of(v19, v0, v15);
        let v21 = seed_b_of(v19, v0, v14);
        let v22 = v20 >= v21;
        let v23 = if (v22) {
            v20
        } else {
            v21
        };
        if (v23 == 0 || v23 > 18446744073709551615) {
            return no_plan(v2)
        };
        if (v22 && (v0 as u256) * (v15 as u256) > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v23) {
            return no_plan(v2)
        };
        if (!v22 && v19 * ((v15 - v0) as u256) >= 6277101735386680763835789423207666416102355444464034512896) {
            return no_plan(v2)
        };
        let (v24, v25, v26) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v12, v13, v12, v0, (v23 as u64), v22);
        if (v24 == 0) {
            return no_plan(v2)
        };
        let (v27, v28) = if (v3) {
            (v25, v26)
        } else {
            (v26, v25)
        };
        if (swap_out_for(v0, v1, v24, v2) == 0) {
            return no_plan(v2)
        };
        let v29 = 1000000;
        let v30 = (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T2, T3>(arg1) as u256);
        if (v30 >= v29) {
            return no_plan(v2)
        };
        let v31 = (swap_in_for(v0, v1, v24, v2) * v29 + v29 - v30 - 1) / (v29 - v30) + 1;
        let v32 = if (v4) {
            (v8 as u256) * (arg0.price_den as u256) / (arg0.price_num as u256)
        } else {
            (v8 as u256)
        };
        if (v32 == 0 || v32 + v31 > 18446744073709551615) {
            return no_plan(v2)
        };
        let v33 = v4 && (v27 as u256) + v31 + v32 <= ((lp_supply() - arg0.lp_sold) as u256) && v28 <= v5 || (v28 as u256) + v31 + v32 <= (v5 as u256) && (v27 as u256) <= ((lp_supply() - arg0.lp_sold) as u256);
        if (!v33) {
            return no_plan(v2)
        };
        let v34 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, T3>(arg1, v2, true, (v32 as u64));
        let v35 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v34) || v2 && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v34) <= v1 || 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v34) >= v1;
        (v35, v2, ((v31 + v32) as u64), (v23 as u64), v22, v24)
    }

    public fun repair_seed_bps() : u64 {
        10
    }

    public fun report_cetus_deny<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &0x2::clock::Clock) {
        assert_curve_version<T0, T1>(arg0);
        let v0 = DenyExitKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0), 13869975224580571289);
        let v1 = GradClaimedKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<GradClaimedKey>(&arg0.id, v1), 13849427555567796257);
        if (!arg0.graduated) {
            assert_graduation_ready<T0, T1>(arg0);
        };
        assert!(cetus_denies_pair<T0, T1>(arg1), 13868567862581264527);
        let v2 = CetusDenyReportKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<CetusDenyReportKey>(&arg0.id, v2), 13868849341853073553);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = CetusDenyReportKey{dummy_field: false};
        0x2::dynamic_field::add<CetusDenyReportKey, u64>(&mut arg0.id, v4, v3);
        let v5 = CetusDenyReported{
            curve_id       : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            reported_at_ms : v3,
        };
        0x2::event::emit<CetusDenyReported>(v5);
    }

    fun reserve_after_grad_bonuses(arg0: u64) : u64 {
        let (v0, v1) = grad_bonuses(arg0);
        arg0 - v0 - v1
    }

    public fun rewards_vault<T0, T1>(arg0: &QuoteCurve<T0, T1>) : 0x1::option::Option<address> {
        let v0 = RewardsVaultKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RewardsVaultKey>(&arg0.id, v0)) {
            let v2 = RewardsVaultKey{dummy_field: false};
            0x1::option::some<address>(*0x2::dynamic_field::borrow<RewardsVaultKey, address>(&arg0.id, v2))
        } else {
            0x1::option::none<address>()
        }
    }

    fun same_cap(arg0: &0x1::option::Option<0x2::object::ID>, arg1: &0x1::option::Option<0x2::object::ID>) : bool {
        if (0x1::option::is_some<0x2::object::ID>(arg0)) {
            if (0x1::option::is_some<0x2::object::ID>(arg1)) {
                *0x1::option::borrow<0x2::object::ID>(arg0) == *0x1::option::borrow<0x2::object::ID>(arg1)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun seal_supply_burn_only<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &mut 0x2::coin_registry::Currency<T0>) {
        assert_curve_version<T0, T1>(arg0);
        abort 13877846632612233269
    }

    public fun seal_supply_burn_only_keep_metadata<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_sealable<T0, T1>(arg0);
        assert!(!0x2::coin_registry::is_metadata_cap_claimed<T0>(arg1), 13878128163423649847);
        0x2::coin_registry::update_from_legacy_metadata<T0>(arg1, arg2);
        let v0 = 0x2::coin_registry::claim_metadata_cap<T0>(arg1, treasury_ref<T0, T1>(arg0), arg3);
        let v1 = MetadataCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<MetadataCapKey, 0x2::coin_registry::MetadataCap<T0>>(&mut arg0.id, v1, v0);
        let v2 = TreasuryCapKey{dummy_field: false};
        let v3 = 0x2::dynamic_object_field::remove<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v2);
        0x2::coin_registry::make_supply_burn_only<T0>(arg1, v3);
        let v4 = 0x2::object::id<QuoteCurve<T0, T1>>(arg0);
        let v5 = 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg1);
        let v6 = SupplySealedBurnOnly{
            curve_id     : v4,
            currency_id  : v5,
            final_supply : 0x2::coin::total_supply<T0>(&v3),
        };
        0x2::event::emit<SupplySealedBurnOnly>(v6);
        let v7 = MetadataCapStored{
            curve_id        : v4,
            currency_id     : v5,
            metadata_cap_id : 0x2::object::id<0x2::coin_registry::MetadataCap<T0>>(&v0),
        };
        0x2::event::emit<MetadataCapStored>(v7);
    }

    fun seed_a_of(arg0: u256, arg1: u128, arg2: u128) : u256 {
        let v0 = arg0 * ((arg2 - arg1) as u256);
        if (v0 >= 6277101735386680763835789423207666416102355444464034512896) {
            return 115792089237316195423570985008687907853269984665640564039457584007913129639935
        };
        (v0 << 64) / (arg1 as u256) * (arg2 as u256)
    }

    fun seed_b_of(arg0: u256, arg1: u128, arg2: u128) : u256 {
        arg0 * ((arg1 - arg2) as u256) >> 64
    }

    fun seed_liq_from_a(arg0: u128, arg1: u128, arg2: u64) : u256 {
        let v0 = (arg0 as u256) * (arg1 as u256);
        let v1 = (arg2 as u256);
        if (v1 > 0 && v0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v1) {
            return 115792089237316195423570985008687907853269984665640564039457584007913129639935
        };
        v0 * v1 / (((arg1 - arg0) as u256) << 64)
    }

    fun seed_liq_from_b(arg0: u128, arg1: u128, arg2: u64) : u256 {
        ((arg2 as u256) << 64) / ((arg0 - arg1) as u256)
    }

    public fun sell<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_curve_version<T0, T1>(arg0);
        assert!(!arg0.graduated, 13836187996753494021);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13837032430273953803);
        assert_no_self_referral(&arg3, arg0.creator, arg4);
        let v1 = quote_sell(v0, 0x2::balance::value<T1>(&arg0.quote_reserve), 0x2::balance::value<T0>(&arg0.token_reserve), arg0.virtual_quote_reserve);
        let v2 = split_fee(v1.fee, 0x1::option::is_some<address>(&arg3), arg0.buyback.bps);
        assert!(v1.net >= arg2, 13835906560431357955);
        assert!(0x2::balance::value<T1>(&arg0.quote_reserve) >= v1.gross, 13835625089749483521);
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg1));
        let v3 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_reserve, v1.gross), arg4);
        let v4 = &mut v3;
        take_fees<T0, T1>(arg0, v4, &v2, &arg3, arg4);
        let v5 = TokensSold{
            curve_id          : 0x2::object::id<QuoteCurve<T0, T1>>(arg0),
            seller            : 0x2::tx_context::sender(arg4),
            tokens_in         : v0,
            quote_out         : v1.net,
            creator_fee       : v2.creator,
            protocol_fee      : v2.protocol,
            airdrop_fee       : v2.airdrop,
            lp_fee            : 0,
            referral_fee      : v2.referral,
            referral          : arg3,
            new_quote_reserve : 0x2::balance::value<T1>(&arg0.quote_reserve),
            new_token_reserve : 0x2::balance::value<T0>(&arg0.token_reserve),
        };
        0x2::event::emit<TokensSold>(v5);
        v3
    }

    fun send_protocol_proof(arg0: 0x2::object::ID, arg1: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::object::ID, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg1, arg2, arg5);
        0x2::transfer::public_transfer<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(v0, arg4);
        let v1 = ProtocolLpProofSent{
            curve_id  : arg0,
            pool_id   : arg3,
            proof_id  : 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v0),
            recipient : arg4,
        };
        0x2::event::emit<ProtocolLpProofSent>(v1);
    }

    public fun set_paused<T0, T1>(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminCap, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminRegistry, arg2: &mut QuoteCurve<T0, T1>, arg3: bool) {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::assert_active_admin(arg0, arg1);
        assert_curve_version<T0, T1>(arg2);
        arg2.paused = arg3;
        let v0 = PauseToggled{
            curve_id : 0x2::object::id<QuoteCurve<T0, T1>>(arg2),
            paused   : arg3,
        };
        0x2::event::emit<PauseToggled>(v0);
    }

    public fun share_curve<T0, T1>(arg0: QuoteCurve<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) {
        assert_launch_ready<T0, T1>(&arg0, arg1);
        0x2::transfer::share_object<QuoteCurve<T0, T1>>(arg0);
    }

    fun skip_impl<T0, T1, T2, T3>(arg0: &mut GradWalk<T0, T1>, arg1: &QuoteCurve<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: bool) {
        assert!(arg0.curve_id == 0x2::object::id<QuoteCurve<T0, T1>>(arg1), 13866311059129630847);
        assert!(arg0.t_is_a == arg4, 13870533188077224093);
        assert!(!arg0.repaired, 13882918091349098678);
        let v0 = *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3);
        assert_pool_at_tier<T2, T3>(arg2, v0, v1);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg3);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_add_liquidity<T2, T3>(arg3);
        let (v4, v5) = walk_band<T0, T1>(arg0);
        let v6 = v3 && in_band(v2, arg0.sqrt_target, arg0.price_num, arg0.price_den, arg0.t_is_a, v4, v5);
        assert!(!v6, 13866874052032987267);
        if (v0 == 200 || is_own_pool<T0, T1>(arg1, v1)) {
            assert!(!v3 || !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_swap<T2, T3>(arg3), 13883199776779337912);
        } else if (arg0.open) {
            let (v7, _, _, _, _, _) = repair_plan<T0, T1, T2, T3>(arg0, arg3);
            let v13 = if (v3) {
                if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_swap<T2, T3>(arg3)) {
                    v7
                } else {
                    false
                }
            } else {
                false
            };
            assert!(!v13, 13881792423369965742);
        };
        assert!(arg0.idx + 1 < 0x1::vector::length<u32>(&arg0.tiers), 13867718683121942665);
        arg0.idx = arg0.idx + 1;
        let v14 = GradTierSkipped{
            curve_id              : arg0.curve_id,
            tick_spacing          : v0,
            pool_id               : v1,
            pool_sqrt_price       : v2,
            add_liquidity_allowed : v3,
        };
        0x2::event::emit<GradTierSkipped>(v14);
    }

    fun split_fee(arg0: u64, arg1: bool, arg2: u64) : FeeSplit {
        let v0 = bps_of(arg0, 4500);
        let v1 = bps_of(v0, arg2);
        let v2 = if (arg1) {
            bps_of(arg0, 1000)
        } else {
            0
        };
        let v3 = if (arg1) {
            2000
        } else {
            2500
        };
        let v4 = bps_of(arg0, v3);
        FeeSplit{
            creator  : v0 - v1,
            buyback  : v1,
            protocol : arg0 - v0 - v4 - v2,
            airdrop  : v4,
            referral : v2,
        }
    }

    fun sqrt_price_x64_ceil(arg0: u128, arg1: u128) : u128 {
        let v0 = (arg0 as u256) << 128;
        let v1 = (arg1 as u256);
        let v2 = isqrt_u256(v0 / v1);
        let v3 = if (v2 * v2 * v1 == v0) {
            v2
        } else {
            v2 + 1
        };
        (v3 as u128)
    }

    fun sqrt_price_x64_floor(arg0: u128, arg1: u128) : u128 {
        (isqrt_u256(((arg0 as u256) << 128) / (arg1 as u256)) as u128)
    }

    public(friend) fun stamp_buyback_executed<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: u64) {
        assert_curve_version<T0, T1>(arg0);
        arg0.last_buyback_ms = arg1;
    }

    public(friend) fun stamp_creator_activity<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x2::clock::Clock) {
        assert_curve_version<T0, T1>(arg0);
        arg0.last_creator_activity_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public(friend) fun store_buyback_config<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        assert_curve_version<T0, T1>(arg0);
        assert!(arg1 <= 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator(), 13845756144508600351);
        assert!(arg3 >= 9000 && arg3 < 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator(), 13857015156462714923);
        let v0 = BuybackConfig{
            bps         : arg1,
            burn        : arg2,
            min_out_bps : arg3,
            deadline_ms : arg4,
            threshold   : arg5,
        };
        arg0.buyback = v0;
    }

    public fun stuck_exit_delay_ms() : u64 {
        345600000
    }

    fun swap_in_for(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u256 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v1 = (arg2 as u256) * (v0 as u256);
        if (v1 >= 6277101735386680763835789423207666416102355444464034512896) {
            return 340282366920938463463374607431768211456
        };
        if (arg3) {
            let v3 = v1 << 64;
            let v4 = (arg0 as u256) * (arg1 as u256);
            let v5 = v3 / v4;
            if (v5 * v4 == v3) {
                v5
            } else {
                v5 + 1
            }
        } else if (v1 & 18446744073709551615 > 0) {
            (v1 >> 64) + 1
        } else {
            v1 >> 64
        }
    }

    fun swap_out_for(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u256 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v1 = (arg2 as u256) * (v0 as u256);
        if (v1 >= 6277101735386680763835789423207666416102355444464034512896) {
            return 0
        };
        if (arg3) {
            v1 >> 64
        } else {
            (v1 << 64) / (arg0 as u256) * (arg1 as u256)
        }
    }

    public fun sweep_max_injection_bps() : u64 {
        100
    }

    public(friend) fun take_buyback_fees<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        assert_curve_version<T0, T1>(arg0);
        0x2::balance::split<T1>(&mut arg0.buyback_fees, arg1)
    }

    fun take_fees<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: &FeeSplit, arg3: &0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg1, arg2.creator, arg4)));
        0x2::balance::join<T1>(&mut arg0.protocol_fees, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg1, arg2.protocol, arg4)));
        0x2::balance::join<T1>(&mut arg0.airdrop_fees, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg1, arg2.airdrop, arg4)));
        if (arg2.buyback > 0) {
            0x2::balance::join<T1>(&mut arg0.buyback_fees, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg1, arg2.buyback, arg4)));
        };
        emit_buyback_ready_if_crossed<T0, T1>(arg0, 0x2::balance::value<T1>(&arg0.buyback_fees));
        if (arg2.referral > 0 && 0x1::option::is_some<address>(arg3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg1, arg2.referral, arg4), *0x1::option::borrow<address>(arg3));
        };
    }

    fun take_graduation_reserve<T0, T1>(arg0: &mut QuoteCurve<T0, T1>, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::ProtocolConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x2::object::id<0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::ProtocolConfig>(arg1) == arg0.protocol_config_id, 13880665784721342525);
        if (arg2) {
            do_graduate_inline<T0, T1>(arg0, arg3, arg4);
        };
        let v0 = GradClaimedKey{dummy_field: false};
        0x2::dynamic_field::add<GradClaimedKey, bool>(&mut arg0.id, v0, true);
        let v1 = GradProtocolRecipientKey{dummy_field: false};
        0x2::dynamic_field::add<GradProtocolRecipientKey, address>(&mut arg0.id, v1, 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::protocol_lp_recipient(arg1));
        0x2::balance::withdraw_all<T1>(&mut arg0.quote_reserve)
    }

    fun tier_fee_rates(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &vector<u32>) : vector<u64> {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::fee_tiers(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(arg1)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::fee_rate(0x2::vec_map::get<u32, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::FeeTier>(v0, 0x1::vector::borrow<u32>(arg1, v2))));
            v2 = v2 + 1;
        };
        v1
    }

    fun tier_order(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) : vector<u32> {
        let v0 = 0x2::vec_map::keys<u32, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::FeeTier>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::fee_tiers(arg0));
        let v1 = 0x1::vector::length<u32>(&v0);
        let v2 = 1;
        while (v2 < v1) {
            while (v2 > 0 && *0x1::vector::borrow<u32>(&v0, v2 - 1) > *0x1::vector::borrow<u32>(&v0, v2)) {
                0x1::vector::swap<u32>(&mut v0, v2 - 1, v2);
                v2 = v2 - 1;
            };
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < v1 && *0x1::vector::borrow<u32>(&v0, v3) < 200) {
            v3 = v3 + 1;
        };
        let v4 = v3 < v1 && *0x1::vector::borrow<u32>(&v0, v3) == 200;
        let v5 = vector[];
        if (v4) {
            0x1::vector::push_back<u32>(&mut v5, 200);
        };
        let v6 = if (v4) {
            v3 + 1
        } else {
            v3
        };
        let v7 = v6;
        let v8 = v3;
        while (v7 < v1 || v8 > 0) {
            if (v7 < v1) {
                0x1::vector::push_back<u32>(&mut v5, *0x1::vector::borrow<u32>(&v0, v7));
                v7 = v7 + 1;
            };
            if (v8 > 0) {
                let v9 = v8 - 1;
                v8 = v9;
                0x1::vector::push_back<u32>(&mut v5, *0x1::vector::borrow<u32>(&v0, v9));
            };
        };
        v5
    }

    public fun token_reserve<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    fun treasury_mut<T0, T1>(arg0: &mut QuoteCurve<T0, T1>) : &mut 0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<TreasuryCapKey>(&arg0.id, v0), 13858140605398253615);
        let v1 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v1)
    }

    fun treasury_ref<T0, T1>(arg0: &QuoteCurve<T0, T1>) : &0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<TreasuryCapKey>(&arg0.id, v0), 13858140626873090095);
        let v1 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v1)
    }

    public fun treasury_sealed<T0, T1>(arg0: &QuoteCurve<T0, T1>) : bool {
        let v0 = TreasuryCapKey{dummy_field: false};
        !0x2::dynamic_object_field::exists<TreasuryCapKey>(&arg0.id, v0)
    }

    fun two_half_plan(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u64, arg4: u64, arg5: bool) : (bool, u64, u64, u64, u64) {
        let v0 = arg4 / 2;
        let v1 = arg4 - v0;
        let (v2, _, v4) = position_amounts(arg0, arg1, arg2, v0, true, arg5);
        let (v5, _, v7) = position_amounts(arg0, arg1, arg2, v1, true, arg5);
        let v8 = if (v2 > 0) {
            if (v5 > 0) {
                (v4 as u128) + (v7 as u128) <= (arg3 as u128)
            } else {
                false
            }
        } else {
            false
        };
        if (v8) {
            return (true, v0, v1, v1, v7)
        };
        let v9 = arg3 / 2;
        let v10 = arg3 - v9;
        let (v11, v12, _) = position_amounts(arg0, arg1, arg2, v9, false, arg5);
        let (v14, v15, _) = position_amounts(arg0, arg1, arg2, v10, false, arg5);
        let v17 = if (v11 > 0) {
            if (v14 > 0) {
                (v12 as u128) + (v15 as u128) <= (arg4 as u128)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v17, 13865469808179937401);
        (false, v9, v10, v15, v10)
    }

    public fun update_payouts<T0, T1>(arg0: &CreatorCap, arg1: &mut QuoteCurve<T0, T1>, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0, T1>(arg1);
        assert_active_creator<T0, T1>(arg0, arg1);
        assert!(!arg1.paused, 13842944908024479771);
        let v0 = build_payouts(arg2, arg3);
        assert_holder_rewards_floor<T0, T1>(arg1, &v0);
        stamp_creator_activity<T0, T1>(arg1, arg4);
        arg1.payouts = v0;
        let v1 = PayoutsUpdated{
            curve_id   : 0x2::object::id<QuoteCurve<T0, T1>>(arg1),
            updated_by : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PayoutsUpdated>(v1);
    }

    public fun version<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        arg0.version
    }

    public fun virtual_quote_for_threshold(arg0: u64) : u64 {
        (((arg0 as u128) * 4369 / 9000) as u64)
    }

    public fun virtual_quote_reserve<T0, T1>(arg0: &QuoteCurve<T0, T1>) : u64 {
        arg0.virtual_quote_reserve
    }

    fun walk_band<T0, T1>(arg0: &GradWalk<T0, T1>) : (u64, u64) {
        (join_band_low_at(*0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx), arg0.flip_age_ms), 100)
    }

    public fun walk_create_pool<T0, T1>(arg0: GradWalk<T0, T1>, arg1: &mut QuoteCurve<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg4);
        walk_create_pool_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun walk_create_pool_impl<T0, T1>(arg0: GradWalk<T0, T1>, arg1: &mut QuoteCurve<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.curve_id == 0x2::object::id<QuoteCurve<T0, T1>>(arg1), 13866313816498634879);
        assert_curve_version<T0, T1>(arg1);
        let v0 = *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx);
        assert!(!cetus_denies<T0>(arg3) && !cetus_denies<T1>(arg3), 13868284154221428877);
        let v1 = arg0.sqrt_target;
        let v2 = arg0.t_is_a;
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(v0);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v3);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v4);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v5);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v6);
        assert!(v1 > v7 && v1 < v8, 13865187963835908215);
        assert!(!arg0.repaired, 13882920891667775670);
        let v9 = 0x2::balance::value<T1>(&arg0.quote);
        assert!(arg0.lp_sold <= lp_supply(), 13865469451697651833);
        let (v10, v11) = dust_plan(v5, v6, v7, v8, v1, v9, lp_supply() - arg0.lp_sold, v2);
        let (_, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v5, v6, v5, v1, v10, v11);
        let (v15, v16) = if (v2) {
            (v13, v14)
        } else {
            (v14, v13)
        };
        let v17 = v11 == v2;
        let v18 = if (v17) {
            v15
        } else {
            v15 + v15 / 100 + 1
        };
        let v19 = if (v17) {
            v16 + v16 / 100 + 1
        } else {
            v16
        };
        let v20 = if (v19 > v9) {
            v9
        } else {
            v19
        };
        assert!(v20 >= v16 && (arg0.lp_sold as u128) + (v18 as u128) <= (lp_supply() as u128), 13865469490352357497);
        let GradWalk {
            curve_id    : _,
            tiers       : _,
            idx         : _,
            price_num   : _,
            price_den   : _,
            t_is_a      : _,
            sqrt_target : _,
            quote       : v28,
            open        : _,
            repaired    : _,
            lp_sold     : v31,
            seed        : v32,
            flip_age_ms : _,
            tier_fees   : _,
        } = arg0;
        let v35 = v28;
        0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v32);
        let v36 = treasury_mut<T0, T1>(arg1);
        let v37 = 0x2::coin::mint<T0>(v36, v18, arg6);
        let v38 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v35, v20), arg6);
        let (v39, v40, v41) = if (v2) {
            let (v42, v43, v44) = create_at_tier<T0, T1, T0, T1>(arg1, arg2, arg3, v0, !arg0.open, v1, v3, v4, v37, v38, v11, arg5, arg6);
            (v43, v44, v42)
        } else {
            let (v45, v46, v47) = create_at_tier<T0, T1, T1, T0>(arg1, arg2, arg3, v0, !arg0.open, v1, v3, v4, v38, v37, v11, arg5, arg6);
            (v47, v46, v45)
        };
        let v48 = v40;
        let v49 = v39;
        let v50 = v41;
        let v51 = 0x2::coin::value<T0>(&v49);
        if (v51 > 0) {
            let v52 = treasury_mut<T0, T1>(arg1);
            0x2::coin::burn<T0>(v52, v49);
        } else {
            0x2::coin::destroy_zero<T0>(v49);
        };
        0x2::balance::join<T1>(&mut v35, 0x2::coin::into_balance<T1>(v48));
        let v53 = v18 - v51;
        let v54 = v20 - 0x2::coin::value<T1>(&v48);
        let v55 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v50);
        let v56 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg4, v50, arg6);
        let v57 = GradProtocolRecipientKey{dummy_field: false};
        let v58 = 0x2::dynamic_field::remove<GradProtocolRecipientKey, address>(&mut arg1.id, v57);
        0x2::transfer::public_transfer<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(v56, v58);
        let v59 = GradDustKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GradDustKey>(&arg1.id, v59)) {
            let v60 = GradDustKey{dummy_field: false};
            let v61 = 0x2::dynamic_field::borrow_mut<GradDustKey, GradDust>(&mut arg1.id, v60);
            0x1::vector::push_back<0x2::object::ID>(&mut v61.pools, v55);
            v61.tick_spacing = v0;
            v61.tokens = v31 + v53;
            v61.quote = v61.quote + v54;
        } else {
            let v62 = GradDustKey{dummy_field: false};
            let v63 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v63, v55);
            let v64 = GradDust{
                pools        : v63,
                tick_spacing : v0,
                tokens       : v31 + v53,
                quote        : v54,
            };
            0x2::dynamic_field::add<GradDustKey, GradDust>(&mut arg1.id, v62, v64);
        };
        let v65 = GradDustKey{dummy_field: false};
        0x2::balance::join<T1>(&mut arg1.quote_reserve, v35);
        let v66 = GradClaimedKey{dummy_field: false};
        0x2::dynamic_field::remove<GradClaimedKey, bool>(&mut arg1.id, v66);
        let v67 = GraduationPoolCreated{
            curve_id        : 0x2::object::id<QuoteCurve<T0, T1>>(arg1),
            pool_id         : v55,
            tick_spacing    : v0,
            token_is_coin_a : v2,
            sqrt_price      : v1,
            dust_tokens     : v53,
            dust_quote      : v54,
            dust_liquidity  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v50),
            proof_id        : 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v56),
            recipient       : v58,
            round           : 0x1::vector::length<0x2::object::ID>(&0x2::dynamic_field::borrow<GradDustKey, GradDust>(&arg1.id, v65).pools),
            quote_returned  : 0x2::balance::value<T1>(&v35),
        };
        0x2::event::emit<GraduationPoolCreated>(v67);
    }

    public fun walk_join<T0, T1>(arg0: GradWalk<T0, T1>, arg1: &mut QuoteCurve<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg5);
        let (v0, v1, v2, v3, v4, v5) = join_checks<T0, T1, T0, T1>(&arg0, arg1, arg3, arg4, true);
        let GradWalk {
            curve_id    : _,
            tiers       : _,
            idx         : _,
            price_num   : _,
            price_den   : _,
            t_is_a      : _,
            sqrt_target : _,
            quote       : v13,
            open        : _,
            repaired    : _,
            lp_sold     : v16,
            seed        : v17,
            flip_age_ms : _,
            tier_fees   : _,
        } = arg0;
        let v20 = v13;
        let v21 = lp_supply() - v16;
        let v22 = treasury_mut<T0, T1>(arg1);
        let v23 = 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(v22, v21, arg7));
        let v24 = &mut v23;
        let v25 = &mut v20;
        let v26 = add_full_range<T0, T1>(arg2, arg4, v0, v1, v24, v25, v3, v2, arg6, arg7);
        let v27 = &mut v23;
        let v28 = &mut v20;
        let v29 = protocol_position<T0, T1>(arg2, arg4, v17, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v26), v0, v1, v27, v28, v4, v2, arg6, arg7);
        finish_join<T0, T1>(arg1, arg5, v26, v29, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), v23, v20, 0x2::balance::value<T1>(&v20), v21, *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx), v5, true, arg7);
    }

    public fun walk_join_qt<T0, T1>(arg0: GradWalk<T0, T1>, arg1: &mut QuoteCurve<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg5);
        let (v0, v1, v2, v3, v4, v5) = join_checks<T0, T1, T1, T0>(&arg0, arg1, arg3, arg4, false);
        let GradWalk {
            curve_id    : _,
            tiers       : _,
            idx         : _,
            price_num   : _,
            price_den   : _,
            t_is_a      : _,
            sqrt_target : _,
            quote       : v13,
            open        : _,
            repaired    : _,
            lp_sold     : v16,
            seed        : v17,
            flip_age_ms : _,
            tier_fees   : _,
        } = arg0;
        let v20 = v13;
        let v21 = lp_supply() - v16;
        let v22 = treasury_mut<T0, T1>(arg1);
        let v23 = 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(v22, v21, arg7));
        let v24 = &mut v20;
        let v25 = &mut v23;
        let v26 = add_full_range<T1, T0>(arg2, arg4, v0, v1, v24, v25, v3, !v2, arg6, arg7);
        let v27 = &mut v20;
        let v28 = &mut v23;
        let v29 = protocol_position<T1, T0>(arg2, arg4, v17, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v26), v0, v1, v27, v28, v4, !v2, arg6, arg7);
        finish_join<T0, T1>(arg1, arg5, v26, v29, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4), v23, v20, 0x2::balance::value<T1>(&v20), v21, *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx), v5, false, arg7);
    }

    public fun walk_repair<T0, T1>(arg0: &mut GradWalk<T0, T1>, arg1: &mut QuoteCurve<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        let (v0, v1, v2, v3) = repair_checks<T0, T1, T0, T1>(arg0, arg1, arg3, arg4, true);
        arg0.repaired = true;
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(*0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx));
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg4, v4, v5, arg6);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg4, &mut v6, v2, v3, arg5);
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v7);
        arg0.lp_sold = arg0.lp_sold + v8;
        let v10 = treasury_mut<T0, T1>(arg1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg4, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(v10, v8, arg6)), 0x2::balance::split<T1>(&mut arg0.quote, v9), v7);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.seed, v6);
        let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg4, v0, true, v1, arg0.sqrt_target, arg5);
        let v14 = v13;
        let v15 = v12;
        let v16 = v11;
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v14);
        let (v18, v19, v20, v21, v22) = if (v0) {
            arg0.lp_sold = arg0.lp_sold + v17;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg4, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(treasury_mut<T0, T1>(arg1), v17, arg6)), 0x2::balance::zero<T1>(), v14);
            0x2::balance::destroy_zero<T0>(v16);
            0x2::balance::join<T1>(&mut arg0.quote, v15);
            (0, 0, v17, 0x2::balance::value<T1>(&v15), 0)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.quote, v17), v14);
            0x2::balance::destroy_zero<T1>(v15);
            let v23 = 0x2::balance::value<T0>(&v16);
            if (v23 > 0) {
                0x2::coin::burn<T0>(treasury_mut<T0, T1>(arg1), 0x2::coin::from_balance<T0>(v16, arg6));
            } else {
                0x2::balance::destroy_zero<T0>(v16);
            };
            let v24 = credit_bought<T0, T1>(arg0, v23);
            (v17, v23, 0, 0, v24)
        };
        let v25 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4);
        assert!(in_band(v25, arg0.sqrt_target, arg0.price_num, arg0.price_den, true, 100, 100), 13881512584775663788);
        let v26 = WalkRepaired{
            curve_id        : arg0.curve_id,
            pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4),
            tick_spacing    : *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx),
            token_is_coin_a : true,
            a2b             : v0,
            sqrt_before     : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4),
            sqrt_after      : v25,
            quote_spent     : v18,
            tokens_bought   : v19,
            tokens_sold     : v20,
            quote_received  : v21,
            seed_quote      : v9,
            seed_tokens     : v8,
            seed_liquidity  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v6),
            tokens_credited : v22,
        };
        0x2::event::emit<WalkRepaired>(v26);
    }

    public fun walk_repair_qt<T0, T1>(arg0: &mut GradWalk<T0, T1>, arg1: &mut QuoteCurve<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        let (v0, v1, v2, v3) = repair_checks<T0, T1, T1, T0>(arg0, arg1, arg3, arg4, false);
        arg0.repaired = true;
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(*0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx));
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T1, T0>(arg2, arg4, v4, v5, arg6);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg2, arg4, &mut v6, v2, v3, arg5);
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T0>(&v7);
        arg0.lp_sold = arg0.lp_sold + v9;
        let v10 = treasury_mut<T0, T1>(arg1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T0>(arg2, arg4, 0x2::balance::split<T1>(&mut arg0.quote, v8), 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(v10, v9, arg6)), v7);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.seed, v6);
        let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg2, arg4, v0, true, v1, arg0.sqrt_target, arg5);
        let v14 = v13;
        let v15 = v12;
        let v16 = v11;
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v14);
        let (v18, v19, v20, v21, v22) = if (v0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg2, arg4, 0x2::balance::split<T1>(&mut arg0.quote, v17), 0x2::balance::zero<T0>(), v14);
            0x2::balance::destroy_zero<T1>(v16);
            let v23 = 0x2::balance::value<T0>(&v15);
            if (v23 > 0) {
                0x2::coin::burn<T0>(treasury_mut<T0, T1>(arg1), 0x2::coin::from_balance<T0>(v15, arg6));
            } else {
                0x2::balance::destroy_zero<T0>(v15);
            };
            let v24 = credit_bought<T0, T1>(arg0, v23);
            (v17, v23, 0, 0, v24)
        } else {
            arg0.lp_sold = arg0.lp_sold + v17;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg2, arg4, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(treasury_mut<T0, T1>(arg1), v17, arg6)), v14);
            0x2::balance::destroy_zero<T0>(v15);
            0x2::balance::join<T1>(&mut arg0.quote, v16);
            (0, 0, v17, 0x2::balance::value<T1>(&v16), 0)
        };
        let v25 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg4);
        assert!(in_band(v25, arg0.sqrt_target, arg0.price_num, arg0.price_den, false, 100, 100), 13881512825293832364);
        let v26 = WalkRepaired{
            curve_id        : arg0.curve_id,
            pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4),
            tick_spacing    : *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx),
            token_is_coin_a : false,
            a2b             : v0,
            sqrt_before     : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg4),
            sqrt_after      : v25,
            quote_spent     : v18,
            tokens_bought   : v19,
            tokens_sold     : v20,
            quote_received  : v21,
            seed_quote      : v8,
            seed_tokens     : v9,
            seed_liquidity  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v6),
            tokens_credited : v22,
        };
        0x2::event::emit<WalkRepaired>(v26);
    }

    public fun walk_skip_occupied<T0, T1>(arg0: &mut GradWalk<T0, T1>, arg1: &QuoteCurve<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        skip_impl<T0, T1, T0, T1>(arg0, arg1, arg2, arg3, true);
    }

    public fun walk_skip_occupied_qt<T0, T1>(arg0: &mut GradWalk<T0, T1>, arg1: &QuoteCurve<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>) {
        skip_impl<T0, T1, T1, T0>(arg0, arg1, arg2, arg3, false);
    }

    fun walk_target(arg0: u128, arg1: u128, arg2: bool) : u128 {
        let v0 = if (arg2) {
            sqrt_price_x64_ceil(arg0, arg1)
        } else {
            sqrt_price_x64_floor(arg1, arg0)
        };
        assert!(v0 > 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() && v0 < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), 13865184605171482743);
        v0
    }

    // decompiled from Move bytecode v7
}

