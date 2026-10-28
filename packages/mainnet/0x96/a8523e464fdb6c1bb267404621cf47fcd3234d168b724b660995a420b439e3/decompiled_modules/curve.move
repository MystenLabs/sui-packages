module 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve {
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

    struct Curve<phantom T0> has key {
        id: 0x2::object::UID,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserve: 0x2::balance::Balance<T0>,
        creator: address,
        payouts: vector<Payout>,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        protocol_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        airdrop_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        graduated: bool,
        paused: bool,
        graduation_target: u8,
        anti_bot_delay: u8,
        created_at_ms: u64,
        metadata_updated: bool,
        lp_fees_accumulated: u64,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        creator_lp_nft_id: 0x1::option::Option<0x2::object::ID>,
        current_grad_threshold: u64,
        active_creator_cap_id: 0x2::object::ID,
        last_creator_activity_ms: u64,
        cto_cooldown_until_ms: u64,
        buyback: BuybackConfig,
        buyback_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        last_buyback_ms: u64,
        version: u64,
        price_config_id: 0x2::object::ID,
    }

    struct BuybackConfig has drop, store {
        bps: u64,
        burn: bool,
        min_out_bps: u64,
        deadline_ms: u64,
        threshold_mist: u64,
    }

    struct FeeSplit has copy, drop {
        creator: u64,
        buyback: u64,
        protocol: u64,
        airdrop: u64,
        referral: u64,
        lp: u64,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        graduation_target: u8,
        anti_bot_delay: u8,
    }

    struct TokensPurchased has copy, drop {
        curve_id: 0x2::object::ID,
        buyer: address,
        sui_in: u64,
        tokens_out: u64,
        creator_fee: u64,
        protocol_fee: u64,
        airdrop_fee: u64,
        lp_fee: u64,
        referral_fee: u64,
        referral: 0x1::option::Option<address>,
        new_sui_reserve: u64,
        new_token_reserve: u64,
        grad_threshold_used: u64,
        tail_refund: u64,
    }

    struct TokensSold has copy, drop {
        curve_id: 0x2::object::ID,
        seller: address,
        tokens_in: u64,
        sui_out: u64,
        creator_fee: u64,
        protocol_fee: u64,
        airdrop_fee: u64,
        lp_fee: u64,
        referral_fee: u64,
        referral: 0x1::option::Option<address>,
        new_sui_reserve: u64,
        new_token_reserve: u64,
    }

    struct Graduated has copy, drop {
        curve_id: 0x2::object::ID,
        final_sui_reserve: u64,
        creator_bonus: u64,
        protocol_bonus: u64,
        graduation_target: u8,
    }

    struct GraduatedToCetus has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        quote: 0x1::type_name::TypeName,
        tick_spacing: u32,
        joined: bool,
        sqrt_price: u128,
        token_is_coin_a: bool,
        quote_in: u64,
        tokens_in: u64,
        tokens_burned: u64,
        excess_locked: u64,
        proof_id: 0x2::object::ID,
    }

    struct LpFeesHarvested has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        quote: 0x1::type_name::TypeName,
        quote_total: u64,
        creator_share: u64,
        protocol_share: u64,
        tokens_burned: u64,
        tokens_locked: u64,
    }

    struct CreatorFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
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

    struct PayoutsUpdated has copy, drop {
        curve_id: 0x2::object::ID,
        updated_by: address,
    }

    struct LaunchFeeCollected has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    struct Comment has copy, drop {
        curve_id: 0x2::object::ID,
        author: address,
        text: 0x1::string::String,
        parent_id: address,
    }

    struct CommentGateSet has copy, drop {
        curve_id: 0x2::object::ID,
        holder_gated: bool,
    }

    struct PauseToggled has copy, drop {
        curve_id: 0x2::object::ID,
        paused: bool,
    }

    struct MetadataUpdated has copy, drop {
        curve_id: 0x2::object::ID,
    }

    struct MetadataRebranded has copy, drop {
        curve_id: 0x2::object::ID,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
        old_symbol: 0x1::ascii::String,
        new_symbol: 0x1::ascii::String,
        old_icon_url: 0x1::string::String,
        new_icon_url: 0x1::string::String,
        name_changed: bool,
        symbol_changed: bool,
        description_changed: bool,
        icon_changed: bool,
        rebranded_at_ms: u64,
    }

    struct BuyQuote has copy, drop {
        graduate_now: bool,
        tokens_out: u64,
        effective_sui_in: u64,
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

    struct ProtocolSurchargeCollected has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    struct PoolCreationCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GradQuoteKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PoolCreationCapAttached has copy, drop {
        curve_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        quote: 0x1::type_name::TypeName,
    }

    struct GradPriceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GradFlippedAtKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GradPrice has copy, drop, store {
        sui_side: u64,
        token_side: u64,
    }

    struct LpProofKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LockedLpFeeTokensKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LockedGradExcessKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
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
    }

    struct GradTierSkipped has copy, drop {
        curve_id: 0x2::object::ID,
        tick_spacing: u32,
        pool_id: 0x2::object::ID,
        pool_sqrt_price: u128,
        add_liquidity_allowed: bool,
    }

    struct QuoteSwapExecuted has copy, drop {
        curve_id: 0x1::option::Option<0x2::object::ID>,
        swap_pool_id: 0x2::object::ID,
        quote: 0x1::type_name::TypeName,
        price_scaled: u64,
        spot_sqrt_price: u128,
        sui_in: u64,
        quote_out: u64,
        fair_out: u64,
        min_out: u64,
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

    struct ProtocolQuoteFeesKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolQuoteFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        quote: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun pool_id<T0>(arg0: &Curve<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool_id
    }

    public fun active_creator_cap_id<T0>(arg0: &Curve<T0>) : 0x2::object::ID {
        arg0.active_creator_cap_id
    }

    public fun airdrop_fees<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.airdrop_fees)
    }

    public fun anti_bot_delay<T0>(arg0: &Curve<T0>) : u8 {
        arg0.anti_bot_delay
    }

    public(friend) fun assert_active_creator<T0>(arg0: &CreatorCap, arg1: &Curve<T0>) {
        assert_curve_version<T0>(arg1);
        assert!(arg0.curve_id == 0x2::object::id<Curve<T0>>(arg1), 13836749954569732105);
        assert!(0x2::object::id<CreatorCap>(arg0) == arg1.active_creator_cap_id, 13845194208168509487);
    }

    public(friend) fun assert_curve_version<T0>(arg0: &Curve<T0>) {
        assert!(arg0.version == 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(), 13853638332916695101);
    }

    fun assert_graduation_ready<T0>(arg0: &Curve<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg2: &0x2::clock::Clock) {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.graduated, 13836190822841974789);
        assert!(!arg0.paused, 13842946239465521197);
        assert!(0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig>(arg1) == arg0.price_config_id, 13853923785033252927);
        assert!(0x2::balance::value<T0>(&arg0.token_reserve) == 0 || 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= resolve_grad_threshold(arg1, arg2), 13836472383718162439);
    }

    fun assert_launch_protected<T0, T1>(arg0: &Curve<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) {
        let v0 = our_pool_cap_id<T0>(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 13862372784572530814);
        assert!(recorded_quote<T0>(arg0) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>()), 13864343113705128072);
        assert_pairs_registered<T0, T1>(arg1, *0x1::option::borrow<0x2::object::ID>(&v0));
    }

    fun assert_lp_harvestable<T0>(arg0: &Curve<T0>, arg1: 0x2::object::ID) {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.paused, 13842958918208978989);
        assert!(arg0.graduated, 13836484998037110791);
        let v0 = LpProofKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<LpProofKey>(&arg0.id, v0), 13866039874896134295);
        assert!(arg0.pool_id == 0x1::option::some<0x2::object::ID>(arg1), 13865758404214259861);
    }

    fun assert_no_self_referral(arg0: &0x1::option::Option<address>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<address>(arg0)) {
            let v0 = *0x1::option::borrow<address>(arg0);
            assert!(v0 != 0x2::tx_context::sender(arg2), 13842660679974780971);
            assert!(v0 != arg1, 13842660684269748267);
        };
    }

    fun assert_pair_holders<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg1: 0x2::object::ID) {
        let v0 = 0x1::option::some<0x2::object::ID>(arg1);
        let v1 = pair_holder<T0, 0x2::sui::SUI>(arg0);
        assert!(same_cap(&v1, &v0), 13863217166553120896);
        if (0x1::type_name::with_defining_ids<T1>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let v2 = pair_holder<T0, T1>(arg0);
            assert!(same_cap(&v2, &v0), 13864061600073580678);
        };
    }

    fun assert_pairs_registered<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg1: 0x2::object::ID) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(is_allowed_quote(&v0), 13863780077852098692);
        assert_pair_holders<T0, T1>(arg0, arg1);
    }

    fun assert_pool_at_tier<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg1: u32, arg2: 0x2::object::ID) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_simple_info(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::new_pool_key<T0, T1>(arg1))) == arg2, 13866596764650963099);
    }

    fun assert_recorded_quote<T0, T1>(arg0: &Curve<T0>) {
        assert!(recorded_quote<T0>(arg0) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>()), 13864350020012540040);
    }

    fun assert_sealable<T0>(arg0: &Curve<T0>) {
        assert_curve_version<T0>(arg0);
        assert!(arg0.graduated, 13836472559811821575);
        assert!(0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"grad_funds_claimed"), 13858427620884611147);
        let v0 = TreasuryCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<TreasuryCapKey>(&arg0.id, v0), 13858146154497704009);
    }

    fun assert_swap_guards<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(is_usd_quote(&v0), 13870822028924682425);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) == arg2, 13871103508197277895);
        let v1 = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::price_scaled(arg0);
        assert!(v1 != 0 && swap_price_fresh(arg0, arg3), 13871384991764054217);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg1);
        let v3 = (v1 as u128);
        assert!(in_band(v2, sqrt_price_x64_ceil(1000000, v3), 1000000, v3, true, 100) && v2 < swap_price_limit(v1), 13871666496805667019);
        v1
    }

    public fun attach_pool_creation_cap<T0, T1>(arg0: &mut Curve<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap) {
        assert_curve_version<T0>(arg0);
        assert!(!pool_protect_skips<T0>(arg0), 13836195684744953861);
        let v0 = PoolCreationCapKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<PoolCreationCapKey>(&arg0.id, v0), 13863498761789046914);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg2);
        assert_pairs_registered<T0, T1>(arg1, v1);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        let v3 = PoolCreationCapAttached{
            curve_id : 0x2::object::id<Curve<T0>>(arg0),
            cap_id   : v1,
            quote    : v2,
        };
        0x2::event::emit<PoolCreationCapAttached>(v3);
        let v4 = PoolCreationCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<PoolCreationCapKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&mut arg0.id, v4, arg2);
        let v5 = GradQuoteKey{dummy_field: false};
        0x2::dynamic_field::add<GradQuoteKey, 0x1::type_name::TypeName>(&mut arg0.id, v5, v2);
    }

    fun begin_checks<T0, T1>(arg0: &Curve<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg2: &0x2::clock::Clock, arg3: bool) : (bool, u64, u64, u64) {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.paused, 13842952943909470253);
        assert!(0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig>(arg1) == arg0.price_config_id, 13853930472297332799);
        assert!(arg0.graduation_target == 0, 13864626525712416909);
        assert!(recorded_quote<T0>(arg0) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>()), 13864345055030345864);
        let v0 = DenyExitKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0), 13869974558862344371);
        assert!(!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"grad_funds_claimed"), 13849426889849307191);
        let v1 = PoolCreationCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<PoolCreationCapKey>(&arg0.id, v1), 13862374743077617790);
        if (arg3) {
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T0, T1>(), 13864908035048997007);
        };
        let v2 = !arg0.graduated;
        if (v2) {
            assert_graduation_ready<T0>(arg0, arg1, arg2);
        };
        let (v3, v4, v5) = if (v2) {
            (effective_sui_reserve<T0>(arg0), effective_token_reserve<T0>(arg0), reserve_after_grad_bonuses(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)) + 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_fees))
        } else {
            let v6 = GradPriceKey{dummy_field: false};
            let v7 = 0x2::dynamic_field::borrow<GradPriceKey, GradPrice>(&arg0.id, v6);
            (v7.sui_side, v7.token_side, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve))
        };
        assert!(v5 >= 500000000000, 13849708450725494841);
        (v2, v3, v4, v5)
    }

    public fun begin_graduation_quote<T0, T1>(arg0: &mut Curve<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : GradWalk<T0, T1> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg3);
        let v0 = pinned_swap_pool<T1>();
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 13870822363932131513);
        begin_quote_impl<T0, T1>(arg0, arg1, arg2, arg4, *0x1::option::borrow<0x2::object::ID>(&v0), arg5, arg6)
    }

    public fun begin_graduation_sui<T0>(arg0: &mut Curve<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : GradWalk<T0, 0x2::sui::SUI> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg3);
        begin_sui_impl<T0>(arg0, arg1, arg2, arg4, arg5)
    }

    fun begin_quote_checks<T0, T1>(arg0: &Curve<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: u64, arg4: &0x2::clock::Clock) : (bool, u128, u128, bool, u128, vector<u32>) {
        let (v0, v1, v2, _) = begin_checks<T0, T1>(arg0, arg1, arg4, false);
        let v4 = 0x1::type_name::with_defining_ids<T1>();
        assert!(is_usd_quote(&v4), 13870819520663781561);
        assert!(arg3 != 0 && swap_price_fresh(arg1, arg4), 13871382483503153353);
        let (v5, v6) = usd_price(v1, v2, arg3);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T0, T1>();
        let v8 = tier_order(arg2);
        assert!(!0x1::vector::is_empty<u32>(&v8), 13868004805255102629);
        (v0, v5, v6, v7, walk_target(v5, v6, v7), v8)
    }

    fun begin_quote_impl<T0, T1>(arg0: &mut Curve<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : GradWalk<T0, T1> {
        let (v0, v1, v2, v3, v4, v5) = begin_quote_checks<T0, T1>(arg0, arg1, arg2, 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::price_scaled(arg1), arg5);
        let v6 = assert_swap_guards<T1>(arg1, arg3, arg4, arg5);
        let v7 = take_graduation_reserve<T0>(arg0, v0, arg5, arg6);
        let v8 = 0x2::object::id<Curve<T0>>(arg0);
        GradWalk<T0, T1>{
            curve_id    : v8,
            tiers       : v5,
            idx         : 0,
            price_num   : v1,
            price_den   : v2,
            t_is_a      : v3,
            sqrt_target : v4,
            quote       : swap_exact_sui<T1>(arg2, arg3, v7, v6, 0x1::option::some<0x2::object::ID>(v8), arg5),
        }
    }

    fun begin_sui_impl<T0>(arg0: &mut Curve<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : GradWalk<T0, 0x2::sui::SUI> {
        let (v0, v1, v2, _) = begin_checks<T0, 0x2::sui::SUI>(arg0, arg1, arg3, true);
        let v4 = (v1 as u128);
        let v5 = (v2 as u128);
        let v6 = tier_order(arg2);
        assert!(!0x1::vector::is_empty<u32>(&v6), 13868004569031901349);
        let v7 = take_graduation_reserve<T0>(arg0, v0, arg3, arg4);
        GradWalk<T0, 0x2::sui::SUI>{
            curve_id    : 0x2::object::id<Curve<T0>>(arg0),
            tiers       : v6,
            idx         : 0,
            price_num   : v4,
            price_den   : v5,
            t_is_a      : true,
            sqrt_target : walk_target(v4, v5, true),
            quote       : v7,
        }
    }

    fun bps_of(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator() as u128)) as u64)
    }

    fun build_payouts(arg0: vector<address>, arg1: vector<u64>) : vector<Payout> {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 > 0 && v0 <= 10, 13840410198714875929);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 13840410203009843225);
        let v1 = 0;
        let v2 = 0x1::vector::empty<Payout>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<address>(&arg0, v3);
            let v5 = *0x1::vector::borrow<u64>(&arg1, v3);
            let v6 = 0;
            while (v6 < v3) {
                assert!(0x1::vector::borrow<Payout>(&v2, v6).recipient != v4, 13840410245959516185);
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
        assert!(v1 == 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator(), 13840410276024287257);
        v2
    }

    public(friend) fun burn_balance<T0>(arg0: &mut Curve<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg0);
        0x2::coin::burn<T0>(treasury_mut<T0>(arg0), 0x2::coin::from_balance<T0>(arg1, arg2));
    }

    public fun burn_tokens<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 13857867866386595911);
        let v0 = treasury_mut<T0>(arg0);
        let v1 = TokensBurned{
            curve_id           : 0x2::object::id<Curve<T0>>(arg0),
            burner             : 0x2::tx_context::sender(arg2),
            amount             : 0x2::coin::burn<T0>(v0, arg1),
            total_supply_after : 0x2::coin::total_supply<T0>(treasury_ref<T0>(arg0)),
        };
        0x2::event::emit<TokensBurned>(v1);
    }

    public fun buy<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.graduated, 13836189555826622469);
        assert!(!arg0.paused, 13842944959565266989);
        assert!(0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig>(arg4) == arg0.price_config_id, 13853922492248096831);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 13837034002231984139);
        assert_no_self_referral(&arg3, arg0.creator, arg6);
        if (arg0.anti_bot_delay > 0) {
            if (0x2::clock::timestamp_ms(arg5) < arg0.created_at_ms + (arg0.anti_bot_delay as u64) * 1000) {
                assert!(0x2::tx_context::sender(arg6) == arg0.creator, 13840130248451424279);
            };
        };
        let v1 = resolve_grad_threshold(arg4, arg5);
        let v2 = quote_buy(v0, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 0x2::balance::value<T0>(&arg0.token_reserve), v1);
        if (!v2.graduate_now) {
            assert!(v2.tokens_out > 0, 13835626700362219521);
            assert!(v2.tokens_out >= arg2, 13835908179634028547);
        };
        arg0.current_grad_threshold = v1;
        let v3 = if (v2.graduate_now) {
            do_graduate_inline<T0>(arg0, arg5, arg6);
            split_fee(0, 0x1::option::is_some<address>(&arg3), arg0.buyback.bps)
        } else {
            let v4 = split_fee(v2.fee, 0x1::option::is_some<address>(&arg3), arg0.buyback.bps);
            let v5 = &mut arg1;
            take_fees<T0>(arg0, v5, &v4, &arg3, arg6);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2.swap_amount + v4.lp, arg6)));
            v4
        };
        let v6 = v3;
        let v7 = 0x2::balance::split<T0>(&mut arg0.token_reserve, v2.tokens_out);
        if (!arg0.graduated && (0x2::balance::value<T0>(&arg0.token_reserve) == 0 || 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v1)) {
            do_graduate_inline<T0>(arg0, arg5, arg6);
        };
        let v8 = TokensPurchased{
            curve_id            : 0x2::object::id<Curve<T0>>(arg0),
            buyer               : 0x2::tx_context::sender(arg6),
            sui_in              : v0,
            tokens_out          : v2.tokens_out,
            creator_fee         : v6.creator,
            protocol_fee        : v6.protocol,
            airdrop_fee         : v6.airdrop,
            lp_fee              : v6.lp,
            referral_fee        : v6.referral,
            referral            : arg3,
            new_sui_reserve     : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            new_token_reserve   : 0x2::balance::value<T0>(&arg0.token_reserve),
            grad_threshold_used : v1,
            tail_refund         : v2.tail_refund,
        };
        0x2::event::emit<TokensPurchased>(v8);
        (0x2::coin::from_balance<T0>(v7, arg6), arg1)
    }

    public fun buyback_bps<T0>(arg0: &Curve<T0>) : u64 {
        arg0.buyback.bps
    }

    public fun buyback_burn<T0>(arg0: &Curve<T0>) : bool {
        arg0.buyback.burn
    }

    public fun buyback_deadline_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.buyback.deadline_ms
    }

    public fun buyback_fees_pending<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_fees)
    }

    public fun buyback_min_out_bps<T0>(arg0: &Curve<T0>) : u64 {
        arg0.buyback.min_out_bps
    }

    public(friend) fun buyback_swap<T0>(arg0: &mut Curve<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) : 0x2::balance::Balance<T0> {
        assert_curve_version<T0>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, arg1);
        0x2::balance::split<T0>(&mut arg0.token_reserve, quote_buyback<T0>(arg0, 0x2::balance::value<0x2::sui::SUI>(&arg1)))
    }

    public fun buyback_threshold_mist<T0>(arg0: &Curve<T0>) : u64 {
        arg0.buyback.threshold_mist
    }

    fun cetus_denies<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : bool {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::in_denied_list<T0>(arg0) && !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::in_allowed_list<T0>(arg0)
    }

    fun cetus_denies_pair<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : bool {
        cetus_denies<T0>(arg0) || cetus_denies<T1>(arg0)
    }

    public fun cetus_deny_reported_at_ms<T0>(arg0: &Curve<T0>) : 0x1::option::Option<u64> {
        let v0 = CetusDenyReportKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CetusDenyReportKey>(&arg0.id, v0)) {
            let v2 = CetusDenyReportKey{dummy_field: false};
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<CetusDenyReportKey, u64>(&arg0.id, v2))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun circulating_supply<T0>(arg0: &Curve<T0>) : u64 {
        let v0 = 0x2::coin::total_supply<T0>(treasury_ref<T0>(arg0));
        let v1 = 0x2::balance::value<T0>(&arg0.token_reserve);
        if (v0 <= v1) {
            0
        } else {
            v0 - v1
        }
    }

    public fun claim_airdrop_fees<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::AdminCap, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::AdminRegistry, arg2: &mut Curve<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::assert_active_admin(arg0, arg1);
        assert_curve_version<T0>(arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.airdrop_fees) > 0, 13837318363426848781);
        let v0 = &mut arg2.airdrop_fees;
        let v1 = withdraw_all_fees(v0, arg3);
        let v2 = AirdropFeesClaimed{
            curve_id : 0x2::object::id<Curve<T0>>(arg2),
            amount   : 0x2::coin::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<AirdropFeesClaimed>(v2);
        v1
    }

    public fun claim_creator_fees<T0>(arg0: &CreatorCap, arg1: &mut Curve<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        assert_active_creator<T0>(arg0, arg1);
        assert!(!arg1.paused, 13842947643919826989);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.creator_fees);
        assert!(v0 > 0, 13837318152973451277);
        stamp_creator_activity<T0>(arg1, arg2);
        let v1 = &mut arg1.creator_fees;
        let v2 = withdraw_all_fees(v1, arg3);
        pay_out_to_payouts<0x2::sui::SUI>(&arg1.payouts, v2, arg3);
        let v3 = CreatorFeesClaimed{
            curve_id : 0x2::object::id<Curve<T0>>(arg1),
            creator  : 0x2::tx_context::sender(arg3),
            amount   : v0,
        };
        0x2::event::emit<CreatorFeesClaimed>(v3);
    }

    public fun claim_protocol_fees<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::AdminCap, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::AdminRegistry, arg2: &mut Curve<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::assert_active_admin(arg0, arg1);
        assert_curve_version<T0>(arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.protocol_fees) > 0, 13837318294707372045);
        let v0 = &mut arg2.protocol_fees;
        let v1 = withdraw_all_fees(v0, arg3);
        let v2 = ProtocolFeesClaimed{
            curve_id : 0x2::object::id<Curve<T0>>(arg2),
            amount   : 0x2::coin::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<ProtocolFeesClaimed>(v2);
        v1
    }

    public fun claim_protocol_quote_fees<T0, T1>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::AdminCap, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::AdminRegistry, arg2: &mut Curve<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::assert_active_admin(arg0, arg1);
        assert_curve_version<T0>(arg2);
        assert!(protocol_quote_fees<T0, T1>(arg2) > 0, 13837329972723449869);
        let v0 = ProtocolQuoteFeesKey<T1>{dummy_field: false};
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x2::dynamic_field::borrow_mut<ProtocolQuoteFeesKey<T1>, 0x2::balance::Balance<T1>>(&mut arg2.id, v0)), arg3);
        let v2 = ProtocolQuoteFeesClaimed{
            curve_id : 0x2::object::id<Curve<T0>>(arg2),
            quote    : 0x1::type_name::with_defining_ids<T1>(),
            amount   : 0x2::coin::value<T1>(&v1),
        };
        0x2::event::emit<ProtocolQuoteFeesClaimed>(v2);
        v1
    }

    public fun clear_cetus_deny_report<T0, T1>(arg0: &mut Curve<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) {
        assert_curve_version<T0>(arg0);
        assert_recorded_quote<T0, T1>(arg0);
        let v0 = DenyExitKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0), 13869979717118066867);
        let v1 = CetusDenyReportKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<CetusDenyReportKey>(&arg0.id, v1), 13869135296482508973);
        assert!(0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"grad_funds_claimed") || !cetus_denies_pair<T0, T1>(arg1), 13869416775754317999);
        let v2 = CetusDenyReportKey{dummy_field: false};
        let v3 = CetusDenyReportCleared{
            curve_id       : 0x2::object::id<Curve<T0>>(arg0),
            reported_at_ms : 0x2::dynamic_field::remove<CetusDenyReportKey, u64>(&mut arg0.id, v2),
        };
        0x2::event::emit<CetusDenyReportCleared>(v3);
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
        } else if (arg4 + arg0 >= arg6) {
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

    public fun collect_protocol_surcharge<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_curve_version<T0>(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000000, 13856460667596439619);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = ProtocolSurchargeCollected{
            curve_id : 0x2::object::id<Curve<T0>>(arg0),
            amount   : v0,
        };
        0x2::event::emit<ProtocolSurchargeCollected>(v1);
    }

    public fun comments_holder_gated<T0>(arg0: &Curve<T0>) : bool {
        !0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"comments_ungated")
    }

    public fun create_and_return<T0>(arg0: 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::LaunchTicket<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::LaunchIssuerRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: vector<address>, arg6: vector<u64>, arg7: u8, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (Curve<T0>, CreatorCap) {
        create_impl<T0>(arg0, arg1, arg2, arg3, 0x2::coin::get_name<T0>(arg4), 0x2::coin::get_symbol<T0>(arg4), arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun create_at_tier<T0, T1, T2>(arg0: &Curve<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: u32, arg4: u128, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T2>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        if (arg3 == 200) {
            let v3 = PoolCreationCapKey{dummy_field: false};
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T1, T2>(arg1, arg2, 0x2::dynamic_object_field::borrow<PoolCreationCapKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg0.id, v3), arg3, arg4, 0x1::string::utf8(b""), arg5, arg6, arg7, arg8, arg9, arg10, arg11)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T1, T2>(arg1, arg2, arg3, arg4, 0x1::string::utf8(b""), arg5, arg6, arg7, arg8, arg9, arg10, arg11)
        }
    }

    fun create_impl<T0>(arg0: 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::LaunchTicket<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::LaunchIssuerRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::ascii::String, arg6: vector<address>, arg7: vector<u64>, arg8: u8, arg9: u8, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (Curve<T0>, CreatorCap) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 2000000000, 13837595826904236047);
        assert!(arg8 == 0, 13837877310471012369);
        let v0 = if (arg9 == 0) {
            true
        } else if (arg9 == 15) {
            true
        } else {
            arg9 == 30
        };
        assert!(v0, 13838158806922690579);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 13849980781716963387);
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::consume_launch_ticket<T0>(arg0, arg1, arg10, arg11);
        let v1 = 0x2::tx_context::sender(arg11);
        let v2 = 0x2::balance::zero<0x2::sui::SUI>();
        0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v3 = 0x2::object::new(arg11);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::object::new(arg11);
        let v6 = BuybackConfig{
            bps            : 0,
            burn           : false,
            min_out_bps    : 9900,
            deadline_ms    : 0,
            threshold_mist : 0,
        };
        let v7 = Curve<T0>{
            id                       : v3,
            sui_reserve              : 0x2::balance::zero<0x2::sui::SUI>(),
            token_reserve            : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg2, 800000000000000, arg11)),
            creator                  : v1,
            payouts                  : build_payouts(arg6, arg7),
            creator_fees             : 0x2::balance::zero<0x2::sui::SUI>(),
            protocol_fees            : v2,
            airdrop_fees             : 0x2::balance::zero<0x2::sui::SUI>(),
            graduated                : false,
            paused                   : false,
            graduation_target        : arg8,
            anti_bot_delay           : arg9,
            created_at_ms            : 0x2::clock::timestamp_ms(arg10),
            metadata_updated         : false,
            lp_fees_accumulated      : 0,
            pool_id                  : 0x1::option::none<0x2::object::ID>(),
            creator_lp_nft_id        : 0x1::option::none<0x2::object::ID>(),
            current_grad_threshold   : 0,
            active_creator_cap_id    : 0x2::object::uid_to_inner(&v5),
            last_creator_activity_ms : 0x2::clock::timestamp_ms(arg10),
            cto_cooldown_until_ms    : 0,
            buyback                  : v6,
            buyback_fees             : 0x2::balance::zero<0x2::sui::SUI>(),
            last_buyback_ms          : 0x2::clock::timestamp_ms(arg10),
            version                  : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(),
            price_config_id          : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::canonical_price_config_id(arg1),
        };
        let v8 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut v7.id, v8, arg2);
        let v9 = LaunchFeeCollected{
            curve_id : v4,
            amount   : 2000000000,
        };
        0x2::event::emit<LaunchFeeCollected>(v9);
        let v10 = CurveCreated{
            curve_id          : v4,
            creator           : v1,
            name              : arg4,
            symbol            : arg5,
            graduation_target : v7.graduation_target,
            anti_bot_delay    : v7.anti_bot_delay,
        };
        0x2::event::emit<CurveCreated>(v10);
        let v11 = CreatorCap{
            id       : v5,
            curve_id : v4,
        };
        (v7, v11)
    }

    public fun created_at_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun creator<T0>(arg0: &Curve<T0>) : address {
        arg0.creator
    }

    public fun creator_fees<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees)
    }

    public fun creator_lp_nft_id<T0>(arg0: &Curve<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.creator_lp_nft_id
    }

    public fun cto_circulating_supply<T0>(arg0: &Curve<T0>) : u64 {
        if (treasury_sealed<T0>(arg0)) {
            800000000000000 - 0x2::balance::value<T0>(&arg0.token_reserve)
        } else {
            circulating_supply<T0>(arg0)
        }
    }

    public fun cto_cooldown_until_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.cto_cooldown_until_ms
    }

    public fun current_grad_threshold<T0>(arg0: &Curve<T0>) : u64 {
        arg0.current_grad_threshold
    }

    public fun current_version() : u64 {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current()
    }

    public fun curve_supply() : u64 {
        800000000000000
    }

    fun dampened_grad_threshold(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 9000000000000
        };
        let v0 = 1000000;
        let v1 = isqrt(arg0 * v0);
        if (v1 == 0) {
            return 9000000000000
        };
        9000000000000 * isqrt(1000 * v0) / v1
    }

    public fun default_buyback_min_out_bps() : u64 {
        9900
    }

    public fun deny_exit_delay_ms() : u64 {
        604800000
    }

    public fun deny_exit_open<T0>(arg0: &Curve<T0>) : bool {
        let v0 = DenyExitKey{dummy_field: false};
        0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0)
    }

    fun dispose_lp_fee_tokens<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>) : (u64, u64) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            (0, 0)
        } else {
            let v3 = TreasuryCapKey{dummy_field: false};
            if (0x2::dynamic_object_field::exists<TreasuryCapKey>(&arg0.id, v3)) {
                0x2::coin::burn<T0>(treasury_mut<T0>(arg0), arg1);
                (v0, 0)
            } else {
                let v4 = LockedLpFeeTokensKey{dummy_field: false};
                if (!0x2::dynamic_field::exists<LockedLpFeeTokensKey>(&arg0.id, v4)) {
                    let v5 = LockedLpFeeTokensKey{dummy_field: false};
                    0x2::dynamic_field::add<LockedLpFeeTokensKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v5, 0x2::balance::zero<T0>());
                };
                let v6 = LockedLpFeeTokensKey{dummy_field: false};
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<LockedLpFeeTokensKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v6), 0x2::coin::into_balance<T0>(arg1));
                (0, v0)
            }
        }
    }

    public(friend) fun distribute_to_payouts<T0, T1>(arg0: &Curve<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        pay_out_to_payouts<T1>(&arg0.payouts, arg1, arg2);
    }

    fun do_graduate_inline<T0>(arg0: &mut Curve<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GradPrice{
            sui_side   : effective_sui_reserve<T0>(arg0),
            token_side : effective_token_reserve<T0>(arg0),
        };
        let v1 = GradPriceKey{dummy_field: false};
        0x2::dynamic_field::add<GradPriceKey, GradPrice>(&mut arg0.id, v1, v0);
        let v2 = GradFlippedAtKey{dummy_field: false};
        0x2::dynamic_field::add<GradFlippedAtKey, u64>(&mut arg0.id, v2, 0x2::clock::timestamp_ms(arg1));
        let (v3, v4) = grad_bonuses(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve));
        let v5 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v3), arg2);
        pay_out_to_payouts<0x2::sui::SUI>(&arg0.payouts, v5, arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.buyback_fees));
        let v6 = 0x2::balance::withdraw_all<T0>(&mut arg0.token_reserve);
        if (0x2::balance::value<T0>(&v6) > 0) {
            let v7 = treasury_mut<T0>(arg0);
            0x2::coin::burn<T0>(v7, 0x2::coin::from_balance<T0>(v6, arg2));
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        arg0.graduated = true;
        let v8 = Graduated{
            curve_id          : 0x2::object::id<Curve<T0>>(arg0),
            final_sui_reserve : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            creator_bonus     : v3,
            protocol_bonus    : v4,
            graduation_target : arg0.graduation_target,
        };
        0x2::event::emit<Graduated>(v8);
    }

    public(friend) fun effective_sui_reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) + 4369000000000
    }

    fun effective_token_reserve<T0>(arg0: &Curve<T0>) : u64 {
        1073000000000000 - 800000000000000 - 0x2::balance::value<T0>(&arg0.token_reserve)
    }

    fun emit_buyback_ready_if_crossed<T0>(arg0: &Curve<T0>, arg1: u64) {
        let v0 = arg0.buyback.threshold_mist;
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_fees);
        if (arg1 < v0 && v1 >= v0) {
            let v2 = BuybackReady{
                curve_id     : 0x2::object::id<Curve<T0>>(arg0),
                buyback_fees : v1,
                threshold    : v0,
            };
            0x2::event::emit<BuybackReady>(v2);
        };
    }

    fun grad_bonuses(arg0: u64) : (u64, u64) {
        let v0 = (arg0 as u128);
        let v1 = (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator() as u128);
        (((v0 * (50 as u128) / v1) as u64), ((v0 * (50 as u128) / v1) as u64))
    }

    public fun grad_flipped_at_ms<T0>(arg0: &Curve<T0>) : 0x1::option::Option<u64> {
        let v0 = GradFlippedAtKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GradFlippedAtKey>(&arg0.id, v0)) {
            let v2 = GradFlippedAtKey{dummy_field: false};
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<GradFlippedAtKey, u64>(&arg0.id, v2))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun grad_funds_claimed<T0>(arg0: &Curve<T0>) : bool {
        0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"grad_funds_claimed")
    }

    public fun grad_join_band_bps() : u64 {
        100
    }

    public fun grad_swap_params() : (u64, u64, u64) {
        (600000, 100, 100)
    }

    public fun graduate<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        graduate_impl<T0>(arg0, arg2, arg3, arg4);
    }

    public(friend) fun graduate_if_drained<T0>(arg0: &mut Curve<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg0);
        if (0x2::balance::value<T0>(&arg0.token_reserve) == 0) {
            do_graduate_inline<T0>(arg0, arg1, arg2);
        };
    }

    fun graduate_impl<T0>(arg0: &mut Curve<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_graduation_ready<T0>(arg0, arg1, arg2);
        do_graduate_inline<T0>(arg0, arg2, arg3);
    }

    public fun graduate_to_cetus_quote<T0, T1>(arg0: &mut Curve<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg4);
        let v0 = pinned_swap_pool<T1>();
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 13870822449831477433);
        let v1 = begin_quote_impl<T0, T1>(arg0, arg1, arg2, arg5, *0x1::option::borrow<0x2::object::ID>(&v0), arg6, arg7);
        walk_create_impl<T0, T1>(v1, arg0, arg2, arg3, arg4, arg6, arg7);
    }

    public fun graduate_to_cetus_sui<T0>(arg0: &mut Curve<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg4);
        let v0 = begin_sui_impl<T0>(arg0, arg1, arg2, arg5, arg6);
        walk_create_impl<T0, 0x2::sui::SUI>(v0, arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun graduated<T0>(arg0: &Curve<T0>) : bool {
        arg0.graduated
    }

    public fun graduation_quote<T0>(arg0: &Curve<T0>) : 0x1::option::Option<0x1::type_name::TypeName> {
        recorded_quote<T0>(arg0)
    }

    public fun graduation_target<T0>(arg0: &Curve<T0>) : u8 {
        arg0.graduation_target
    }

    fun gross_up_for_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = ((0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator() - 100) as u128);
        let v1 = ((arg0 as u128) * (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator() as u128) + v0 - 1) / v0;
        if (v1 >= (arg1 as u128)) {
            arg1
        } else {
            (v1 as u64)
        }
    }

    public fun harvest_lp_fees<T0>(arg0: &mut Curve<T0>, arg1: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg1);
        assert_lp_harvestable<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3));
        let v0 = LpProofKey{dummy_field: false};
        let (v1, v2) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, 0x2::sui::SUI>(arg1, arg2, arg3, 0x2::dynamic_object_field::borrow_mut<LpProofKey, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.id, v0), arg4);
        let v3 = v2;
        let (v4, v5) = dispose_lp_fee_tokens<T0>(arg0, v1);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        let v7 = bps_of(v6, 5000);
        if (v7 > 0) {
            let v8 = 0x2::coin::split<0x2::sui::SUI>(&mut v3, v7, arg4);
            pay_out_to_payouts<0x2::sui::SUI>(&arg0.payouts, v8, arg4);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_fees, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        let v9 = LpFeesHarvested{
            curve_id       : 0x2::object::id<Curve<T0>>(arg0),
            pool_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3),
            quote          : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            quote_total    : v6,
            creator_share  : v7,
            protocol_share : 0x2::coin::value<0x2::sui::SUI>(&v3),
            tokens_burned  : v4,
            tokens_locked  : v5,
        };
        0x2::event::emit<LpFeesHarvested>(v9);
    }

    public fun harvest_lp_fees_quote<T0, T1>(arg0: &mut Curve<T0>, arg1: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg1);
        assert_lp_harvestable<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3));
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(is_usd_quote(&v0), 13870825190020612281);
        let v1 = LpProofKey{dummy_field: false};
        let (v2, v3) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, T1>(arg1, arg2, arg3, 0x2::dynamic_object_field::borrow_mut<LpProofKey, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.id, v1), arg4);
        split_quote_lp_fees<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), v2, v3, arg4);
    }

    public fun harvest_lp_fees_quote_qt<T0, T1>(arg0: &mut Curve<T0>, arg1: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg1);
        assert_lp_harvestable<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3));
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(is_usd_quote(&v0), 13870825275919958201);
        let v1 = LpProofKey{dummy_field: false};
        let (v2, v3) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T1, T0>(arg1, arg2, arg3, 0x2::dynamic_object_field::borrow_mut<LpProofKey, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.id, v1), arg4);
        split_quote_lp_fees<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), v3, v2, arg4);
    }

    public(friend) fun has_live_takeover<T0>(arg0: &Curve<T0>) : bool {
        0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"cto_live_proposal")
    }

    fun icon_url_string<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : 0x1::string::String {
        let v0 = 0x2::coin::get_icon_url<T0>(arg0);
        if (0x1::option::is_some<0x2::url::Url>(&v0)) {
            0x1::string::from_ascii(0x2::url::inner_url(0x1::option::borrow<0x2::url::Url>(&v0)))
        } else {
            0x1::string::utf8(b"")
        }
    }

    fun in_band(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: bool, arg5: u64) : bool {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        if (v0 > 2 * v1 || 2 * v0 < v1) {
            return false
        };
        let v2 = (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator() as u256);
        let v3 = (arg5 as u256);
        if (arg4) {
            let v5 = v0 * v0 * (arg3 as u256) * v2;
            let v6 = (arg2 as u256) << 128;
            v5 >= v6 * (v2 - v3) && v5 <= v6 * (v2 + v3)
        } else {
            let v7 = ((arg3 as u256) << 128) * v2;
            let v8 = v0 * v0 * (arg2 as u256);
            v8 * (v2 - v3) <= v7 && v7 <= v8 * (v2 + v3)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(4500 + 3000 + 2500 + 0 == 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator(), 13840979857407344667);
        assert!(4500 + 2500 + 2000 + 1000 + 0 == 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator(), 13840979878882181147);
        assert!(reserve_after_grad_bonuses(dampened_grad_threshold(0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::max_price_scaled())) >= 500000000000, 13855053679259811905);
    }

    public(friend) fun inject_reserve<T0>(arg0: &mut Curve<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        assert_curve_version<T0>(arg0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1) <= (((effective_sui_reserve<T0>(arg0) as u128) * (100 as u128) / (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator() as u128)) as u64), 13860113077721628761);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, arg1);
    }

    public(friend) fun install_takeover_winner<T0>(arg0: &mut Curve<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : CreatorCap {
        assert_curve_version<T0>(arg0);
        let v0 = CreatorCap{
            id       : 0x2::object::new(arg3),
            curve_id : 0x2::object::id<Curve<T0>>(arg0),
        };
        arg0.active_creator_cap_id = 0x2::object::id<CreatorCap>(&v0);
        arg0.creator = arg1;
        arg0.last_creator_activity_ms = arg2;
        let v1 = Payout{
            recipient : arg1,
            bps       : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator(),
        };
        let v2 = 0x1::vector::empty<Payout>();
        0x1::vector::push_back<Payout>(&mut v2, v1);
        arg0.payouts = v2;
        v0
    }

    fun is_allowed_quote(arg0: &0x1::type_name::TypeName) : bool {
        let v0 = 0x1::ascii::as_bytes(0x1::type_name::as_string(arg0));
        if (*v0 == b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI") {
            true
        } else if (*v0 == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC") {
            true
        } else {
            *v0 == b"44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI"
        }
    }

    fun is_printable_ascii(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            if (v2 < 32 || v2 > 126) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun is_usd_quote(arg0: &0x1::type_name::TypeName) : bool {
        let v0 = 0x1::ascii::as_bytes(0x1::type_name::as_string(arg0));
        *v0 == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC" || *v0 == b"44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI"
    }

    fun isqrt(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
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

    fun join_checks<T0, T1, T2, T3>(arg0: &GradWalk<T0, T1>, arg1: &Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: bool) : (u32, u32, bool, u128) {
        assert!(arg0.curve_id == 0x2::object::id<Curve<T0>>(arg1), 13866317248179208345);
        assert!(arg0.t_is_a == arg4, 13870539377126801591);
        assert_curve_version<T0>(arg1);
        let v0 = *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx);
        assert_pool_at_tier<T2, T3>(arg2, v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3));
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_add_liquidity<T2, T3>(arg3), 13867443169561411745);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg3);
        assert!(in_band(v1, arg0.sqrt_target, arg0.price_num, arg0.price_den, arg4, 100), 13867161711764439199);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(v0);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v2);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v3);
        let v6 = 0x2::balance::value<T1>(&arg0.quote);
        let (v7, _, v9) = position_amounts(v4, v5, v1, lp_supply(), true, arg4);
        let v10 = v7 > 0 && v9 <= v6;
        if (!v10) {
            let (v11, v12, _) = position_amounts(v4, v5, v1, v6, false, arg4);
            assert!(v11 > 0 && v12 <= lp_supply(), 13865472917737963667);
        };
        (v2, v3, v10, v1)
    }

    public fun last_buyback_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.last_buyback_ms
    }

    public fun last_creator_activity_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.last_creator_activity_ms
    }

    public(friend) fun live_takeover_id<T0>(arg0: &Curve<T0>) : 0x2::object::ID {
        *0x2::dynamic_field::borrow<vector<u8>, 0x2::object::ID>(&arg0.id, b"cto_live_proposal")
    }

    public fun lp_fees_accumulated<T0>(arg0: &Curve<T0>) : u64 {
        arg0.lp_fees_accumulated
    }

    fun lp_supply() : u64 {
        1000000000000000 - 800000000000000
    }

    public fun metadata_updated<T0>(arg0: &Curve<T0>) : bool {
        arg0.metadata_updated
    }

    public fun migrate_curve<T0>(arg0: &mut Curve<T0>) {
        assert!(arg0.version < 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(), 13853638367276433469);
        arg0.version = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current();
        let v0 = CurveMigrated{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            from_version : arg0.version,
            to_version   : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(),
        };
        0x2::event::emit<CurveMigrated>(v0);
    }

    public fun min_buyback_min_out_bps() : u64 {
        9000
    }

    public fun open_deny_exit<T0, T1>(arg0: &mut Curve<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg0);
        assert_recorded_quote<T0, T1>(arg0);
        assert!(!arg0.paused, 13842958226719244333);
        assert!(0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig>(arg1) == arg0.price_config_id, 13853935755107106879);
        let v0 = DenyExitKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0), 13869979833082183859);
        assert!(!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"grad_funds_claimed"), 13849432164069146679);
        let v1 = CetusDenyReportKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<CetusDenyReportKey>(&arg0.id, v1), 13869135416741593261);
        let v2 = CetusDenyReportKey{dummy_field: false};
        let v3 = *0x2::dynamic_field::borrow<CetusDenyReportKey, u64>(&arg0.id, v2);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        assert!(v4 >= v3 + 604800000, 13869698379580178609);
        assert!(cetus_denies_pair<T0, T1>(arg2), 13868572483967778985);
        let v5 = !arg0.graduated;
        if (v5) {
            assert_graduation_ready<T0>(arg0, arg1, arg3);
        };
        if (v5) {
            do_graduate_inline<T0>(arg0, arg3, arg4);
        };
        let v6 = DenyExitKey{dummy_field: false};
        0x2::dynamic_field::add<DenyExitKey, u64>(&mut arg0.id, v6, v4);
        let v7 = DenyExitOpened{
            curve_id       : 0x2::object::id<Curve<T0>>(arg0),
            reported_at_ms : v3,
            opened_at_ms   : v4,
            reserve        : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            circulating    : circulating_supply<T0>(arg0),
        };
        0x2::event::emit<DenyExitOpened>(v7);
    }

    public fun open_stuck_exit<T0>(arg0: &mut Curve<T0>, arg1: &0x2::clock::Clock) {
        assert_curve_version<T0>(arg0);
        let v0 = DenyExitKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0), 13869979983406039219);
        assert!(!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"grad_funds_claimed"), 13849432314393002039);
        let v1 = if (arg0.graduated) {
            let v2 = GradFlippedAtKey{dummy_field: false};
            0x2::dynamic_field::exists<GradFlippedAtKey>(&arg0.id, v2)
        } else {
            false
        };
        assert!(v1, 13872794741765243092);
        let v3 = GradFlippedAtKey{dummy_field: false};
        let v4 = *0x2::dynamic_field::borrow<GradFlippedAtKey, u64>(&arg0.id, v3);
        let v5 = 0x2::clock::timestamp_ms(arg1);
        assert!(v5 >= v4 + 2592000000, 13872513279673303250);
        let v6 = DenyExitKey{dummy_field: false};
        0x2::dynamic_field::add<DenyExitKey, u64>(&mut arg0.id, v6, v5);
        let v7 = StuckExitOpened{
            curve_id      : 0x2::object::id<Curve<T0>>(arg0),
            flipped_at_ms : v4,
            opened_at_ms  : v5,
            reserve       : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            circulating   : circulating_supply<T0>(arg0),
        };
        0x2::event::emit<StuckExitOpened>(v7);
    }

    fun our_pool_cap_id<T0>(arg0: &Curve<T0>) : 0x1::option::Option<0x2::object::ID> {
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

    public fun paused<T0>(arg0: &Curve<T0>) : bool {
        arg0.paused
    }

    fun pay_out_to_payouts<T0>(arg0: &vector<Payout>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Payout>(arg0);
        let v1 = 0;
        while (v1 < v0 - 1) {
            let v2 = 0x1::vector::borrow<Payout>(arg0, v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, (((0x2::coin::value<T0>(&arg1) as u128) * (v2.bps as u128) / (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator() as u128)) as u64), arg2), v2.recipient);
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x1::vector::borrow<Payout>(arg0, v0 - 1).recipient);
    }

    fun pinned_swap_pool<T0>() : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::ascii::as_bytes(0x1::type_name::as_string(&v0));
        if (*v1 == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC") {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(@0xb8d7d9e66a60c239e7a60110efcf8de6c705580ed924d0dde141f4a0e2c90105))
        } else if (*v1 == b"44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI") {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(@0x440e5e3b13b8220c5c338bb5a4291cab5c58064eaf3654c77f3e9aed5147689c))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun pinned_swap_pool_id<T0>() : 0x1::option::Option<0x2::object::ID> {
        pinned_swap_pool<T0>()
    }

    public fun pool_creation_cap_id<T0>(arg0: &Curve<T0>) : 0x1::option::Option<0x2::object::ID> {
        our_pool_cap_id<T0>(arg0)
    }

    fun pool_protect_skips<T0>(arg0: &Curve<T0>) : bool {
        arg0.graduated || 0x1::option::is_some<0x2::object::ID>(&arg0.pool_id)
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

    public fun post_comment<T0>(arg0: &mut Curve<T0>, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::coin::Coin<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.paused, 13842948107776294957);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 1000000, 13842385162117447719);
        if (comments_holder_gated<T0>(arg0)) {
            assert!(0x2::coin::value<T0>(arg3) > 0, 13845481404041789489);
        };
        let v0 = 0x1::string::length(&arg1);
        assert!(v0 > 0, 13839851917390643221);
        assert!(v0 <= 280, 13839570446710210601);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = Comment{
            curve_id  : 0x2::object::id<Curve<T0>>(arg0),
            author    : 0x2::tx_context::sender(arg5),
            text      : arg1,
            parent_id : arg4,
        };
        0x2::event::emit<Comment>(v1);
    }

    public fun price_config_id<T0>(arg0: &Curve<T0>) : 0x2::object::ID {
        arg0.price_config_id
    }

    public fun protocol_fees<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.protocol_fees)
    }

    public fun protocol_quote_fees<T0, T1>(arg0: &Curve<T0>) : u64 {
        let v0 = ProtocolQuoteFeesKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists<ProtocolQuoteFeesKey<T1>>(&arg0.id, v0)) {
            let v2 = ProtocolQuoteFeesKey<T1>{dummy_field: false};
            0x2::balance::value<T1>(0x2::dynamic_field::borrow<ProtocolQuoteFeesKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v2))
        } else {
            0
        }
    }

    fun quote_buy(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : BuyQuote {
        let v0 = arg0 - (((arg0 as u128) * (100 as u128) / (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator() as u128)) as u64);
        let v1 = arg1 + 4369000000000;
        let v2 = 1073000000000000 - 800000000000000 - arg2;
        let v3 = quote_out(v0, v1, v2);
        if (v3 < arg2 && arg1 >= arg3) {
            return BuyQuote{
                graduate_now     : true,
                tokens_out       : 0,
                effective_sui_in : 0,
                tail_refund      : arg0,
                fee              : 0,
                swap_amount      : 0,
                graduates        : true,
            }
        };
        let (v4, v5) = clip_to_graduation(v0, v3, v1, v2, arg1, arg2, arg3);
        let v6 = gross_up_for_fee(v5, arg0);
        let v7 = v6 * 100 / 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator();
        let v8 = v6 - v7;
        let v9 = v4 == arg2 || arg1 + v8 >= arg3;
        BuyQuote{
            graduate_now     : false,
            tokens_out       : v4,
            effective_sui_in : v6,
            tail_refund      : arg0 - v6,
            fee              : v7,
            swap_amount      : v8,
            graduates        : v9,
        }
    }

    public(friend) fun quote_buyback<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.token_reserve);
        let v1 = quote_out(arg1, effective_sui_reserve<T0>(arg0), effective_token_reserve<T0>(arg0));
        if (v1 > v0) {
            v0
        } else {
            v1
        }
    }

    fun quote_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        (((arg2 as u128) * v0 / ((arg1 as u128) + v0)) as u64)
    }

    fun quote_sell(arg0: u64, arg1: u64, arg2: u64) : SellQuote {
        let v0 = quote_out(arg0, 1073000000000000 - 800000000000000 - arg2, arg1 + 4369000000000);
        let v1 = v0 * 100 / 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator();
        SellQuote{
            gross : v0,
            fee   : v1,
            net   : v0 - v1,
        }
    }

    public fun rebrand_available_at_ms<T0>(arg0: &Curve<T0>) : u64 {
        if (0x2::dynamic_field::exists_with_type<vector<u8>, u64>(&arg0.id, b"metadata_rebranded_at_ms")) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"metadata_rebranded_at_ms") + 86400000
        } else {
            0
        }
    }

    public fun rebrand_cooldown_ms() : u64 {
        86400000
    }

    public fun rebrand_metadata<T0>(arg0: &CreatorCap, arg1: &mut Curve<T0>, arg2: &mut 0x2::coin::CoinMetadata<T0>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::ascii::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        assert_active_creator<T0>(arg0, arg1);
        assert!(!treasury_sealed<T0>(arg1), 13858146639829008457);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 >= rebrand_available_at_ms<T0>(arg1), 13860398448232890445);
        let v1 = if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            true
        } else if (0x1::option::is_some<0x1::ascii::String>(&arg4)) {
            true
        } else if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            true
        } else {
            0x1::option::is_some<0x1::string::String>(&arg6)
        };
        assert!(v1, 13860679948979535951);
        let v2 = 0x2::coin::get_name<T0>(arg2);
        let v3 = 0x2::coin::get_symbol<T0>(arg2);
        let v4 = icon_url_string<T0>(arg2);
        let v5 = 0x1::option::is_some<0x1::string::String>(&arg3) && *0x1::option::borrow<0x1::string::String>(&arg3) != v2;
        let v6 = 0x1::option::is_some<0x1::ascii::String>(&arg4) && *0x1::option::borrow<0x1::ascii::String>(&arg4) != v3;
        let v7 = 0x1::option::is_some<0x1::string::String>(&arg5) && *0x1::option::borrow<0x1::string::String>(&arg5) != 0x2::coin::get_description<T0>(arg2);
        let v8 = 0x1::option::is_some<0x1::string::String>(&arg6) && *0x1::option::borrow<0x1::string::String>(&arg6) != v4;
        if (v5) {
            let v9 = 0x1::option::borrow<0x1::string::String>(&arg3);
            assert!(!0x1::string::is_empty(v9), 13861242980537598035);
            assert!(0x1::string::length(v9) <= 64, 13841821211436384291);
        };
        if (v6) {
            let v10 = 0x1::option::borrow<0x1::ascii::String>(&arg4);
            assert!(is_printable_ascii(0x1::ascii::as_bytes(v10)), 13861524476989276245);
            assert!(0x1::ascii::length(v10) <= 16, 13842102707888062501);
        };
        if (v8) {
            assert!(is_printable_ascii(0x1::string::as_bytes(0x1::option::borrow<0x1::string::String>(&arg6))), 13861805973440954455);
        };
        let v11 = if (v5) {
            true
        } else if (v6) {
            true
        } else if (v7) {
            true
        } else {
            v8
        };
        assert!(v11, 13860961565690298449);
        stamp_creator_activity<T0>(arg1, arg7);
        let v12 = if (v5) {
            *0x1::option::borrow<0x1::string::String>(&arg3)
        } else {
            v2
        };
        let v13 = if (v6) {
            *0x1::option::borrow<0x1::ascii::String>(&arg4)
        } else {
            v3
        };
        let v14 = if (v8) {
            *0x1::option::borrow<0x1::string::String>(&arg6)
        } else {
            v4
        };
        let v15 = v14;
        if (v5) {
            0x2::coin::update_name<T0>(treasury_ref<T0>(arg1), arg2, v12);
        };
        if (v6) {
            0x2::coin::update_symbol<T0>(treasury_ref<T0>(arg1), arg2, v13);
        };
        if (v7) {
            0x2::coin::update_description<T0>(treasury_ref<T0>(arg1), arg2, *0x1::option::borrow<0x1::string::String>(&arg5));
        };
        if (v8) {
            0x2::coin::update_icon_url<T0>(treasury_ref<T0>(arg1), arg2, 0x1::ascii::string(*0x1::string::as_bytes(&v15)));
        };
        if (0x2::dynamic_field::exists_with_type<vector<u8>, u64>(&arg1.id, b"metadata_rebranded_at_ms")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg1.id, b"metadata_rebranded_at_ms") = v0;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg1.id, b"metadata_rebranded_at_ms", v0);
        };
        arg1.metadata_updated = true;
        let v16 = 0x2::object::id<Curve<T0>>(arg1);
        let v17 = MetadataRebranded{
            curve_id            : v16,
            old_name            : v2,
            new_name            : v12,
            old_symbol          : v3,
            new_symbol          : v13,
            old_icon_url        : v4,
            new_icon_url        : v15,
            name_changed        : v5,
            symbol_changed      : v6,
            description_changed : v7,
            icon_changed        : v8,
            rebranded_at_ms     : v0,
        };
        0x2::event::emit<MetadataRebranded>(v17);
        let v18 = MetadataUpdated{curve_id: v16};
        0x2::event::emit<MetadataUpdated>(v18);
    }

    fun record_seed<T0, T1>(arg0: &mut Curve<T0>, arg1: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::object::ID, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: u32, arg8: bool, arg9: u128, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg1, arg2, arg11);
        let v1 = 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v0);
        let v2 = 0x2::balance::value<T0>(&arg4);
        if (v2 > 0) {
            let v3 = treasury_mut<T0>(arg0);
            0x2::coin::burn<T0>(v3, 0x2::coin::from_balance<T0>(arg4, arg11));
        } else {
            0x2::balance::destroy_zero<T0>(arg4);
        };
        let v4 = 0x2::balance::value<T1>(&arg5);
        let v5 = LockedGradExcessKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<LockedGradExcessKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v5, arg5);
        let v6 = LpProofKey{dummy_field: false};
        0x2::dynamic_object_field::add<LpProofKey, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.id, v6, v0);
        arg0.pool_id = 0x1::option::some<0x2::object::ID>(arg3);
        arg0.creator_lp_nft_id = 0x1::option::some<0x2::object::ID>(v1);
        let v7 = GraduatedToCetus{
            curve_id        : 0x2::object::id<Curve<T0>>(arg0),
            pool_id         : arg3,
            quote           : 0x1::type_name::with_defining_ids<T1>(),
            tick_spacing    : arg7,
            joined          : arg8,
            sqrt_price      : arg9,
            token_is_coin_a : arg10,
            quote_in        : arg6 - v4,
            tokens_in       : lp_supply() - v2,
            tokens_burned   : v2,
            excess_locked   : v4,
            proof_id        : v1,
        };
        0x2::event::emit<GraduatedToCetus>(v7);
    }

    fun recorded_quote<T0>(arg0: &Curve<T0>) : 0x1::option::Option<0x1::type_name::TypeName> {
        let v0 = GradQuoteKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GradQuoteKey>(&arg0.id, v0)) {
            let v2 = GradQuoteKey{dummy_field: false};
            0x1::option::some<0x1::type_name::TypeName>(*0x2::dynamic_field::borrow<GradQuoteKey, 0x1::type_name::TypeName>(&arg0.id, v2))
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        }
    }

    public fun redeem_pro_rata<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_curve_version<T0>(arg0);
        let v0 = DenyExitKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0), 13870261613001703605);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 13837047574328639499);
        let v2 = (((0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128) * (v1 as u128) / (circulating_supply<T0>(arg0) as u128)) as u64);
        let v3 = treasury_mut<T0>(arg0);
        0x2::coin::burn<T0>(v3, arg1);
        let v4 = RedeemedProRata{
            curve_id          : 0x2::object::id<Curve<T0>>(arg0),
            redeemer          : 0x2::tx_context::sender(arg2),
            tokens_in         : v1,
            quote_out         : v2,
            reserve_after     : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            circulating_after : circulating_supply<T0>(arg0),
        };
        0x2::event::emit<RedeemedProRata>(v4);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v2), arg2)
    }

    public fun report_cetus_deny<T0, T1>(arg0: &mut Curve<T0>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x2::clock::Clock) {
        assert_curve_version<T0>(arg0);
        assert_recorded_quote<T0, T1>(arg0);
        let v0 = DenyExitKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<DenyExitKey>(&arg0.id, v0), 13869979618333819059);
        assert!(!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"grad_funds_claimed"), 13849431949320781879);
        if (!arg0.graduated) {
            assert_graduation_ready<T0>(arg0, arg1, arg3);
        };
        assert!(cetus_denies_pair<T0, T1>(arg2), 13868572256334512297);
        let v1 = CetusDenyReportKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<CetusDenyReportKey>(&arg0.id, v1), 13868853735606321323);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = CetusDenyReportKey{dummy_field: false};
        0x2::dynamic_field::add<CetusDenyReportKey, u64>(&mut arg0.id, v3, v2);
        let v4 = CetusDenyReported{
            curve_id       : 0x2::object::id<Curve<T0>>(arg0),
            reported_at_ms : v2,
        };
        0x2::event::emit<CetusDenyReported>(v4);
    }

    fun reserve_after_grad_bonuses(arg0: u64) : u64 {
        let (v0, v1) = grad_bonuses(arg0);
        arg0 - v0 - v1
    }

    fun resolve_grad_threshold(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg1: &0x2::clock::Clock) : u64 {
        if (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::price_scaled(arg0) == 0) {
            return 9000000000000
        };
        let v0 = dampened_grad_threshold(0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::price_scaled(arg0));
        let v1 = dampened_grad_threshold(0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::prev_price_scaled(arg0));
        let v2 = if (v1 > v0) {
            v1
        } else {
            v0
        };
        if (0x2::clock::timestamp_ms(arg1) > 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::price_updated_at_ms(arg0) + 1800000) {
            return if (v2 > 9000000000000) {
                v2
            } else {
                9000000000000
            }
        };
        v2
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

    public fun seal_supply_burn_only<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::coin_registry::Currency<T0>) {
        assert_sealable<T0>(arg0);
        let v0 = TreasuryCapKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::remove<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0);
        0x2::coin_registry::make_supply_burn_only<T0>(arg1, v1);
        let v2 = SupplySealedBurnOnly{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            currency_id  : 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg1),
            final_supply : 0x2::coin::total_supply<T0>(&v1),
        };
        0x2::event::emit<SupplySealedBurnOnly>(v2);
    }

    public fun sell<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.graduated, 13836190414820081669);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13837034848340541451);
        assert_no_self_referral(&arg3, arg0.creator, arg4);
        let v1 = quote_sell(v0, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 0x2::balance::value<T0>(&arg0.token_reserve));
        let v2 = split_fee(v1.fee, 0x1::option::is_some<address>(&arg3), arg0.buyback.bps);
        assert!(v1.net >= arg2, 13835908969908011011);
        let v3 = v1.gross - v2.lp;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v3, 13835627507816071169);
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg1));
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v3), arg4);
        let v5 = &mut v4;
        take_fees<T0>(arg0, v5, &v2, &arg3, arg4);
        let v6 = TokensSold{
            curve_id          : 0x2::object::id<Curve<T0>>(arg0),
            seller            : 0x2::tx_context::sender(arg4),
            tokens_in         : v0,
            sui_out           : v1.net,
            creator_fee       : v2.creator,
            protocol_fee      : v2.protocol,
            airdrop_fee       : v2.airdrop,
            lp_fee            : v2.lp,
            referral_fee      : v2.referral,
            referral          : arg3,
            new_sui_reserve   : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            new_token_reserve : 0x2::balance::value<T0>(&arg0.token_reserve),
        };
        0x2::event::emit<TokensSold>(v6);
        v4
    }

    public fun set_comment_gate<T0>(arg0: &CreatorCap, arg1: &mut Curve<T0>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        assert_active_creator<T0>(arg0, arg1);
        assert!(arg2 == 0x2::dynamic_field::exists<vector<u8>>(&arg1.id, b"comments_ungated"), 13849140415530532917);
        stamp_creator_activity<T0>(arg1, arg3);
        if (arg2) {
            0x2::dynamic_field::remove<vector<u8>, bool>(&mut arg1.id, b"comments_ungated");
        } else {
            0x2::dynamic_field::add<vector<u8>, bool>(&mut arg1.id, b"comments_ungated", true);
        };
        let v0 = CommentGateSet{
            curve_id     : 0x2::object::id<Curve<T0>>(arg1),
            holder_gated : arg2,
        };
        0x2::event::emit<CommentGateSet>(v0);
    }

    public(friend) fun set_cto_cooldown_until_ms<T0>(arg0: &mut Curve<T0>, arg1: u64) {
        assert_curve_version<T0>(arg0);
        arg0.cto_cooldown_until_ms = arg1;
    }

    public(friend) fun set_live_takeover<T0>(arg0: &mut Curve<T0>, arg1: 0x2::object::ID) {
        assert_curve_version<T0>(arg0);
        0x2::dynamic_field::add<vector<u8>, 0x2::object::ID>(&mut arg0.id, b"cto_live_proposal", arg1);
    }

    public fun set_paused<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::AdminCap, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::AdminRegistry, arg2: &mut Curve<T0>, arg3: bool) {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::assert_active_admin(arg0, arg1);
        assert_curve_version<T0>(arg2);
        arg2.paused = arg3;
        let v0 = PauseToggled{
            curve_id : 0x2::object::id<Curve<T0>>(arg2),
            paused   : arg3,
        };
        0x2::event::emit<PauseToggled>(v0);
    }

    public fun share_curve<T0, T1>(arg0: Curve<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) {
        assert_launch_protected<T0, T1>(&arg0, arg1);
        0x2::transfer::share_object<Curve<T0>>(arg0);
    }

    fun skip_impl<T0, T1, T2, T3>(arg0: &mut GradWalk<T0, T1>, arg1: &Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: bool) {
        assert!(arg0.curve_id == 0x2::object::id<Curve<T0>>(arg1), 13866316140077645977);
        assert!(arg0.t_is_a == arg4, 13870538269025239223);
        let v0 = *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3);
        assert_pool_at_tier<T2, T3>(arg2, v0, v1);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg3);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_add_liquidity<T2, T3>(arg3);
        let v4 = v3 && in_band(v2, arg0.sqrt_target, arg0.price_num, arg0.price_den, arg0.t_is_a, 100);
        assert!(!v4, 13866879137275969693);
        assert!(arg0.idx + 1 < 0x1::vector::length<u32>(&arg0.tiers), 13867723570796429475);
        arg0.idx = arg0.idx + 1;
        let v5 = GradTierSkipped{
            curve_id              : arg0.curve_id,
            tick_spacing          : v0,
            pool_id               : v1,
            pool_sqrt_price       : v2,
            add_liquidity_allowed : v3,
        };
        0x2::event::emit<GradTierSkipped>(v5);
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
        let v5 = bps_of(arg0, 0);
        FeeSplit{
            creator  : v0 - v1,
            buyback  : v1,
            protocol : arg0 - v0 - v4 - v2 - v5,
            airdrop  : v4,
            referral : v2,
            lp       : v5,
        }
    }

    fun split_quote_lp_fees<T0, T1>(arg0: &mut Curve<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = dispose_lp_fee_tokens<T0>(arg0, arg2);
        let v2 = 0x2::coin::value<T1>(&arg3);
        let v3 = bps_of(v2, 5000);
        if (v3 > 0) {
            let v4 = 0x2::coin::split<T1>(&mut arg3, v3, arg4);
            pay_out_to_payouts<T1>(&arg0.payouts, v4, arg4);
        };
        let v5 = ProtocolQuoteFeesKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists<ProtocolQuoteFeesKey<T1>>(&arg0.id, v5)) {
            let v6 = ProtocolQuoteFeesKey<T1>{dummy_field: false};
            0x2::dynamic_field::add<ProtocolQuoteFeesKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v6, 0x2::balance::zero<T1>());
        };
        let v7 = ProtocolQuoteFeesKey<T1>{dummy_field: false};
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<ProtocolQuoteFeesKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v7), 0x2::coin::into_balance<T1>(arg3));
        let v8 = LpFeesHarvested{
            curve_id       : 0x2::object::id<Curve<T0>>(arg0),
            pool_id        : arg1,
            quote          : 0x1::type_name::with_defining_ids<T1>(),
            quote_total    : v2,
            creator_share  : v3,
            protocol_share : 0x2::coin::value<T1>(&arg3),
            tokens_burned  : v0,
            tokens_locked  : v1,
        };
        0x2::event::emit<LpFeesHarvested>(v8);
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

    public(friend) fun stamp_buyback_executed<T0>(arg0: &mut Curve<T0>, arg1: u64) {
        assert_curve_version<T0>(arg0);
        arg0.last_buyback_ms = arg1;
    }

    public(friend) fun stamp_creator_activity<T0>(arg0: &mut Curve<T0>, arg1: &0x2::clock::Clock) {
        assert_curve_version<T0>(arg0);
        arg0.last_creator_activity_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public(friend) fun store_buyback_config<T0>(arg0: &mut Curve<T0>, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        assert_curve_version<T0>(arg0);
        assert!(arg1 <= 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator(), 13845757553259184179);
        assert!(arg3 >= 9000 && arg3 < 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator(), 13857016565213691973);
        let v0 = BuybackConfig{
            bps            : arg1,
            burn           : arg2,
            min_out_bps    : arg3,
            deadline_ms    : arg4,
            threshold_mist : arg5,
        };
        arg0.buyback = v0;
    }

    public fun stuck_exit_delay_ms() : u64 {
        2592000000
    }

    public fun sui_reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    fun swap_check_impl<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock) : u8 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!is_usd_quote(&v0)) {
            return 1
        };
        if (0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1) != arg2) {
            return 2
        };
        let v1 = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::price_scaled(arg0);
        if (v1 == 0 || !swap_price_fresh(arg0, arg4)) {
            return 3
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg1);
        let v3 = swap_price_limit(v1);
        if (!in_band(v2, sqrt_price_x64_ceil(1000000, (v1 as u128)), 1000000, (v1 as u128), true, 100) || v2 >= v3) {
            return 4
        };
        if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_swap<T0, 0x2::sui::SUI>(arg1)) {
            return 5
        };
        if (arg3 == 0) {
            return 8
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg1, false, true, arg3);
        let v5 = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v4)) {
            true
        } else if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v4) >= v3) {
            true
        } else if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v4) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v4) != arg3) {
            true
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v4) == 0
        };
        if (v5) {
            return 6
        };
        let (_, v7) = swap_fair_and_min(arg3, v1);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v4) < v7) {
            return 7
        };
        0
    }

    fun swap_exact_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 13837045151967084555);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, true, v0, swap_price_limit(arg3), arg5);
        let v4 = v3;
        let v5 = v1;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v4) == v0, 13871948070566756557);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, v4);
        let (v6, v7) = swap_fair_and_min(v0, arg3);
        let v8 = 0x2::balance::value<T0>(&v5);
        assert!(v8 >= v7, 13872229567018434767);
        let v9 = QuoteSwapExecuted{
            curve_id        : arg4,
            swap_pool_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1),
            quote           : 0x1::type_name::with_defining_ids<T0>(),
            price_scaled    : arg3,
            spot_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg1),
            sui_in          : v0,
            quote_out       : v8,
            fair_out        : v6,
            min_out         : v7,
        };
        0x2::event::emit<QuoteSwapExecuted>(v9);
        v5
    }

    fun swap_fair_and_min(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = (((arg0 as u256) * (arg1 as u256) / (1000000 as u256)) as u64);
        let v1 = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator();
        (v0, (((v0 as u256) * ((v1 - 100) as u256) / (v1 as u256)) as u64))
    }

    fun swap_price_fresh(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) <= 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::price_updated_at_ms(arg0) + 600000
    }

    fun swap_price_limit(arg0: u64) : u128 {
        let v0 = (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator() as u128);
        sqrt_price_x64_floor(1000000 * (v0 + (100 as u128)), (arg0 as u128) * v0)
    }

    public fun swap_sui_for_usd_quote<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = pinned_swap_pool<T0>();
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 13870822634515071161);
        let v1 = assert_swap_guards<T0>(arg0, arg2, *0x1::option::borrow<0x2::object::ID>(&v0), arg4);
        0x2::coin::from_balance<T0>(swap_exact_sui<T0>(arg1, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg3), v1, 0x1::option::none<0x2::object::ID>(), arg4), arg5)
    }

    public fun sweep_max_injection_bps() : u64 {
        100
    }

    public(friend) fun take_buyback_fees<T0>(arg0: &mut Curve<T0>, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert_curve_version<T0>(arg0);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.buyback_fees, arg1)
    }

    fun take_fees<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &FeeSplit, arg3: &0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2.creator, arg4)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2.protocol, arg4)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.airdrop_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2.airdrop, arg4)));
        if (arg2.buyback > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2.buyback, arg4)));
        };
        emit_buyback_ready_if_crossed<T0>(arg0, 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_fees));
        if (arg2.referral > 0 && 0x1::option::is_some<address>(arg3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2.referral, arg4), *0x1::option::borrow<address>(arg3));
        };
        arg0.lp_fees_accumulated = arg0.lp_fees_accumulated + arg2.lp;
    }

    fun take_graduation_reserve<T0>(arg0: &mut Curve<T0>, arg1: bool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (arg1) {
            do_graduate_inline<T0>(arg0, arg2, arg3);
        };
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, b"grad_funds_claimed", true);
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_reserve)
    }

    public(friend) fun take_live_takeover<T0>(arg0: &mut Curve<T0>) : 0x2::object::ID {
        assert_curve_version<T0>(arg0);
        0x2::dynamic_field::remove<vector<u8>, 0x2::object::ID>(&mut arg0.id, b"cto_live_proposal")
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

    public fun token_reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    fun treasury_mut<T0>(arg0: &mut Curve<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<TreasuryCapKey>(&arg0.id, v0), 13858141545997795401);
        let v1 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v1)
    }

    fun treasury_ref<T0>(arg0: &Curve<T0>) : &0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<TreasuryCapKey>(&arg0.id, v0), 13858141567472631881);
        let v1 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v1)
    }

    public fun treasury_sealed<T0>(arg0: &Curve<T0>) : bool {
        let v0 = TreasuryCapKey{dummy_field: false};
        !0x2::dynamic_object_field::exists<TreasuryCapKey>(&arg0.id, v0)
    }

    fun try_swap_impl<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: 0x2::object::ID, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        if (swap_check_impl<T0>(arg0, arg2, arg3, 0x2::balance::value<0x2::sui::SUI>(&arg4), arg5) != 0) {
            return (0x2::balance::zero<T0>(), arg4)
        };
        (swap_exact_sui<T0>(arg1, arg2, arg4, 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::price_scaled(arg0), 0x1::option::none<0x2::object::ID>(), arg5), 0x2::balance::zero<0x2::sui::SUI>())
    }

    public fun try_swap_sui_for_usd_quote<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = pinned_swap_pool<T0>();
        if (0x1::option::is_none<0x2::object::ID>(&v0)) {
            return (0x2::balance::zero<T0>(), arg3)
        };
        try_swap_impl<T0>(arg0, arg1, arg2, *0x1::option::borrow<0x2::object::ID>(&v0), arg3, arg4)
    }

    public fun update_metadata<T0>(arg0: &CreatorCap, arg1: &mut Curve<T0>, arg2: &mut 0x2::coin::CoinMetadata<T0>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::ascii::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        assert_active_creator<T0>(arg0, arg1);
        assert!(!arg1.metadata_updated, 13841257874935513117);
        assert!(0x2::clock::timestamp_ms(arg7) < arg1.created_at_ms + 604800000, 13841539358502289439);
        let v0 = if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            true
        } else if (0x1::option::is_some<0x1::ascii::String>(&arg4)) {
            true
        } else if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            true
        } else {
            0x1::option::is_some<0x1::string::String>(&arg6)
        };
        assert!(v0, 13862087057572102177);
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            assert!(0x1::string::length(0x1::option::borrow<0x1::string::String>(&arg3)) <= 64, 13841820867839000611);
        };
        if (0x1::option::is_some<0x1::ascii::String>(&arg4)) {
            assert!(0x1::ascii::length(0x1::option::borrow<0x1::ascii::String>(&arg4)) <= 16, 13842102355700744229);
        };
        let v1 = if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            0x1::option::some<0x1::ascii::String>(0x1::ascii::string(*0x1::string::as_bytes(0x1::option::borrow<0x1::string::String>(&arg6))))
        } else {
            0x1::option::none<0x1::ascii::String>()
        };
        let v2 = v1;
        assert!(!treasury_sealed<T0>(arg1), 13858146455145414729);
        stamp_creator_activity<T0>(arg1, arg7);
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            0x2::coin::update_name<T0>(treasury_ref<T0>(arg1), arg2, *0x1::option::borrow<0x1::string::String>(&arg3));
        };
        if (0x1::option::is_some<0x1::ascii::String>(&arg4)) {
            0x2::coin::update_symbol<T0>(treasury_ref<T0>(arg1), arg2, *0x1::option::borrow<0x1::ascii::String>(&arg4));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            0x2::coin::update_description<T0>(treasury_ref<T0>(arg1), arg2, *0x1::option::borrow<0x1::string::String>(&arg5));
        };
        if (0x1::option::is_some<0x1::ascii::String>(&v2)) {
            0x2::coin::update_icon_url<T0>(treasury_ref<T0>(arg1), arg2, *0x1::option::borrow<0x1::ascii::String>(&v2));
        };
        arg1.metadata_updated = true;
        let v3 = MetadataUpdated{curve_id: 0x2::object::id<Curve<T0>>(arg1)};
        0x2::event::emit<MetadataUpdated>(v3);
    }

    public fun update_payouts<T0>(arg0: &CreatorCap, arg1: &mut Curve<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        assert_active_creator<T0>(arg0, arg1);
        assert!(!arg1.paused, 13842947540840611885);
        stamp_creator_activity<T0>(arg1, arg4);
        arg1.payouts = build_payouts(arg2, arg3);
        let v0 = PayoutsUpdated{
            curve_id   : 0x2::object::id<Curve<T0>>(arg1),
            updated_by : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PayoutsUpdated>(v0);
    }

    fun usd_price(arg0: u64, arg1: u64, arg2: u64) : (u128, u128) {
        ((arg0 as u128) * (arg2 as u128), (arg1 as u128) * 1000000)
    }

    public fun usd_quote_swap_check<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock) : u8 {
        let v0 = pinned_swap_pool<T0>();
        if (0x1::option::is_none<0x2::object::ID>(&v0)) {
            return 1
        };
        swap_check_impl<T0>(arg0, arg1, *0x1::option::borrow<0x2::object::ID>(&v0), arg2, arg3)
    }

    public fun version<T0>(arg0: &Curve<T0>) : u64 {
        arg0.version
    }

    public fun walk_create<T0, T1>(arg0: GradWalk<T0, T1>, arg1: &mut Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg4);
        walk_create_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun walk_create_impl<T0, T1>(arg0: GradWalk<T0, T1>, arg1: &mut Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.curve_id == 0x2::object::id<Curve<T0>>(arg1), 13866316492264964249);
        assert_curve_version<T0>(arg1);
        let v0 = *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx);
        assert!(!cetus_denies<T0>(arg3) && !cetus_denies<T1>(arg3), 13868286829987758247);
        let v1 = arg0.sqrt_target;
        let v2 = arg0.t_is_a;
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(v0);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v3);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v4);
        assert!(v1 > 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v5) && v1 < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v6), 13865190643897204881);
        let v7 = 0x2::balance::value<T1>(&arg0.quote);
        let (v8, _, v10) = position_amounts(v5, v6, v1, lp_supply(), true, v2);
        let v11 = if (v8 > 0) {
            if (v10 > 0) {
                v10 <= v7
            } else {
                false
            }
        } else {
            false
        };
        if (!v11) {
            let v12 = 0x1::type_name::with_defining_ids<T1>();
            assert!(is_usd_quote(&v12), 13865472161823719571);
            let (v13, v14, _) = position_amounts(v5, v6, v1, v7, false, v2);
            let v16 = if (v13 > 0) {
                if (v14 > 0) {
                    v14 <= lp_supply()
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v16, 13865472170413654163);
        };
        let GradWalk {
            curve_id    : _,
            tiers       : _,
            idx         : _,
            price_num   : _,
            price_den   : _,
            t_is_a      : _,
            sqrt_target : _,
            quote       : v24,
        } = arg0;
        let v25 = v24;
        let v26 = 0x2::coin::from_balance<T1>(v25, arg6);
        let v27 = treasury_mut<T0>(arg1);
        let v28 = 0x2::coin::mint<T0>(v27, lp_supply(), arg6);
        let (v29, v30, v31) = if (v2) {
            create_at_tier<T0, T0, T1>(arg1, arg2, arg3, v0, v1, v3, v4, v28, v26, v11, arg5, arg6)
        } else {
            let (v32, v33, v34) = create_at_tier<T0, T1, T0>(arg1, arg2, arg3, v0, v1, v3, v4, v26, v28, !v11, arg5, arg6);
            (v32, v34, v33)
        };
        let v35 = v29;
        record_seed<T0, T1>(arg1, arg4, v35, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v35), 0x2::coin::into_balance<T0>(v30), 0x2::coin::into_balance<T1>(v31), 0x2::balance::value<T1>(&v25), v0, false, v1, v2, arg6);
    }

    public fun walk_join<T0, T1>(arg0: GradWalk<T0, T1>, arg1: &mut Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg5);
        let (v0, v1, v2, v3) = join_checks<T0, T1, T0, T1>(&arg0, arg1, arg3, arg4, true);
        let GradWalk {
            curve_id    : _,
            tiers       : _,
            idx         : _,
            price_num   : _,
            price_den   : _,
            t_is_a      : _,
            sqrt_target : _,
            quote       : v11,
        } = arg0;
        let v12 = v11;
        let v13 = 0x2::balance::value<T1>(&v12);
        let v14 = treasury_mut<T0>(arg1);
        let v15 = 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(v14, lp_supply(), arg7));
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg4, v0, v1, arg7);
        let v17 = if (v2) {
            lp_supply()
        } else {
            v13
        };
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg4, &mut v16, v17, v2, arg6);
        let (v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v18);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg4, 0x2::balance::split<T0>(&mut v15, v19), 0x2::balance::split<T1>(&mut v12, v20), v18);
        record_seed<T0, T1>(arg1, arg5, v16, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), v15, v12, v13, *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx), true, v3, true, arg7);
    }

    public fun walk_join_qt<T0, T1>(arg0: GradWalk<T0, T1>, arg1: &mut Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg2);
        0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::checked_package_version(arg5);
        let (v0, v1, v2, v3) = join_checks<T0, T1, T1, T0>(&arg0, arg1, arg3, arg4, false);
        let GradWalk {
            curve_id    : _,
            tiers       : _,
            idx         : _,
            price_num   : _,
            price_den   : _,
            t_is_a      : _,
            sqrt_target : _,
            quote       : v11,
        } = arg0;
        let v12 = v11;
        let v13 = 0x2::balance::value<T1>(&v12);
        let v14 = treasury_mut<T0>(arg1);
        let v15 = 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(v14, lp_supply(), arg7));
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T1, T0>(arg2, arg4, v0, v1, arg7);
        let v17 = if (v2) {
            lp_supply()
        } else {
            v13
        };
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg2, arg4, &mut v16, v17, !v2, arg6);
        let (v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T0>(&v18);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T0>(arg2, arg4, 0x2::balance::split<T1>(&mut v12, v19), 0x2::balance::split<T0>(&mut v15, v20), v18);
        record_seed<T0, T1>(arg1, arg5, v16, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4), v15, v12, v13, *0x1::vector::borrow<u32>(&arg0.tiers, arg0.idx), true, v3, false, arg7);
    }

    public fun walk_skip_occupied<T0, T1>(arg0: &mut GradWalk<T0, T1>, arg1: &Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        skip_impl<T0, T1, T0, T1>(arg0, arg1, arg2, arg3, true);
    }

    public fun walk_skip_occupied_qt<T0, T1>(arg0: &mut GradWalk<T0, T1>, arg1: &Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>) {
        skip_impl<T0, T1, T1, T0>(arg0, arg1, arg2, arg3, false);
    }

    fun walk_target(arg0: u128, arg1: u128, arg2: bool) : u128 {
        let v0 = if (arg2) {
            sqrt_price_x64_ceil(arg0, arg1)
        } else {
            sqrt_price_x64_floor(arg1, arg0)
        };
        assert!(v0 > 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() && v0 < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), 13865189621694988433);
        v0
    }

    fun withdraw_all_fees(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(arg0), arg1)
    }

    // decompiled from Move bytecode v7
}

